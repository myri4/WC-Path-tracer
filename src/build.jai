#import "Basic";
#import "String";

#import "Compiler";
#import "Metaprogram_Plugins";

#import "File";
#import "File_Utilities";

#import "Process";

#if OS == .WINDOWS {
    #import "Windows";
}

#run,stallable {
    workspace := compiler_create_workspace("path_tracer");

    if !workspace {
        log_error("Workspace creation failed!\n");
        return;
    }

    using build_options := get_build_options(workspace);
    output_executable_name = "path_tracer";
    output_path = "../run_tree";
    backend = .X64;

    import_paths: [..] string;
    for path : import_path 
        array_add(*import_paths, path);

    array_add(*import_paths, "../modules");
    import_path = import_paths;

    linker_args: [..]string;
    for additional_linker_arguments 
        array_add(*linker_args, it);
    
    array_add(*linker_args, "libcpmt.lib"); // vulkan memory allocator depends on this
    array_add(*linker_args, "gdi32.lib"); 
    array_add(*linker_args, "user32.lib"); 
    additional_linker_arguments = linker_args;
    
    set_build_options(build_options, workspace);
    add_build_file("./main.jai", workspace);

    compile_shaders("./shaders", "../run_tree/data/assets/shaders", "./shaders/include");

    set_build_options_dc(.{do_output=false});
}



compile_shaders :: (shader_in_dir: string, output_dir: string, include_dir: string = "") {
    make_directory_if_it_does_not_exist(output_dir);
    
    vulkan_sdk := to_string(getenv("VULKAN_SDK"));
    if !vulkan_sdk {
        compiler_report("ERROR: VULKAN_SDK environment variable not set!\n");
        return;
    }
    
    glslc_path := tprint("%/Bin/glslc", vulkan_sdk);
    #if OS == .WINDOWS {
        glslc_path = tprint("%.exe", glslc_path);
    }
    
    if !file_exists(glslc_path) {
        compiler_report(tprint("ERROR: glslc not found at %\n", glslc_path));
        return;
    }
    
    shader_extensions :: string.["vert", "frag", "comp"];
    shader_files: [..] string;
    
    for extension : shader_extensions {
        found_files := file_list(shader_in_dir, recursive = false);
        
        for file : found_files {
            if ends_with(file, tprint(".%", extension)) {
                array_add(*shader_files, file);
            }
        }
    }
    
    if shader_files.count == 0 {
        print("No shader files found in %\n", shader_in_dir);
        return;
    }
    
    header_files: [..] string;
    if include_dir {
        if file_exists(include_dir) {
            found_headers := file_list(include_dir, recursive = true);
            for header: found_headers {
                if ends_with(header, ".glsl") 
                    array_add(*header_files, header);                
            }
        }
    }
    
    compiled_count := 0;
    failed_count := 0;
    
    for shader_file : shader_files {
        shader_name := path_filename(shader_file);
        output_file := tprint("%/%", output_dir, shader_name);
        
        needs_compilation := true;
        
        if file_exists(output_file) {
            shader_time := file_modtime_and_size(shader_file);
            output_time := file_modtime_and_size(output_file);
            
            if output_time >= shader_time {
                needs_compilation = false;
                
                for header: header_files {
                    header_time := file_modtime_and_size(header);
                    if header_time > output_time {
                        needs_compilation = true;
                        break;
                    }
                }
            }
        }
        else
            print("File '%' does not exist!\n", output_file);
        
        if !needs_compilation  continue;
        
        print("Compiling shader: %\n", shader_name);
        
        args: [..] string;
        array_add(*args, glslc_path, "-std=450core", "-O0", "-o", output_file, shader_file);
        //array_add(*args, "--target-env=vulkan1.2");
        
        if include_dir && file_exists(include_dir)  array_add(*args, tprint("-I%", include_dir));
        // if debug_info  array_add(*args, "-g");
        
        result, output_string, error_string := run_command(..args, capture_and_return_output = true);
        
        if result.exit_code == 0 {
            compiled_count += 1;
            print("  Successfully compiled %\n", shader_name);
        } 
        else {
            failed_count += 1;
            compiler_report(error_string);
        }
    }
    
    print("\nShader compilation complete: % compiled, % failed\n", compiled_count, failed_count);
    
    if failed_count > 0
        compiler_report(tprint("Shader compilation failed for % files\n", failed_count));
}