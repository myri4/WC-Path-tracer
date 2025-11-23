Vertex :: struct {
    position: Vector3;
    texcoord: Vector2;
    normal: Vector3;
}

OBJ_Model :: struct {
    vertices: [..]Vertex;
    indices: [..]u32;
}

Vertex_Key :: struct {
    v_idx:  s64 = -1;
    vt_idx: s64 = -1;
    vn_idx: s64 = -1;
}

compareVertKey :: (a: Vertex_Key, b: Vertex_Key) -> bool { return a.v_idx == b.v_idx && a.vt_idx == b.vt_idx && a.vn_idx == b.vn_idx; }

get_Verthash :: (key: Vertex_Key) -> u32 {
    // Simple hash combination
    // FNV-1a hash
    hash: u32 = 2166136261;
    
    // Hash v_idx
    hash ^= cast(u32)(key.v_idx & 0xFF);
    hash *= 16777619;
    hash ^= cast(u32)((key.v_idx >> 8) & 0xFF);
    hash *= 16777619;
    hash ^= cast(u32)((key.v_idx >> 16) & 0xFF);
    hash *= 16777619;
    hash ^= cast(u32)((key.v_idx >> 24) & 0xFF);
    hash *= 16777619;
    
    // Hash vt_idx
    hash ^= cast(u32)(key.vt_idx & 0xFF);
    hash *= 16777619;
    hash ^= cast(u32)((key.vt_idx >> 8) & 0xFF);
    hash *= 16777619;
    hash ^= cast(u32)((key.vt_idx >> 16) & 0xFF);
    hash *= 16777619;
    hash ^= cast(u32)((key.vt_idx >> 24) & 0xFF);
    hash *= 16777619;
    
    // Hash vn_idx
    hash ^= cast(u32)(key.vn_idx & 0xFF);
    hash *= 16777619;
    hash ^= cast(u32)((key.vn_idx >> 8) & 0xFF);
    hash *= 16777619;
    hash ^= cast(u32)((key.vn_idx >> 16) & 0xFF);
    hash *= 16777619;
    hash ^= cast(u32)((key.vn_idx >> 24) & 0xFF);
    hash *= 16777619;
    
    return hash;
}



parse_obj_file :: (filename: string) -> bool, OBJ_Model {
    model: OBJ_Model;
    
    positions: [..]Vector3;
    texcoords: [..]Vector2;
    normals: [..]Vector3;
    defer array_free(positions);
    defer array_free(texcoords);
    defer array_free(normals);
    
    vertex_map: Table(Vertex_Key, u32, given_compare_function = compareVertKey, given_hash_function = get_Verthash);
    defer deinit(*vertex_map);
    
    content, success := read_entire_file(filename);
    if !success {
        print("Error: Could not read file '%'\n", filename);
        return false, model;
    }
    defer free(content);
    
    lines := split(content, "\n");
    defer array_free(lines);
    
    for line: lines {
        trimmed := trim(line);
        if trimmed.count == 0 || trimmed[0] == #char "#" continue;
        
        tokens := split(trimmed, " ");
        defer array_free(tokens);
        
        if tokens.count == 0 continue;
        
        command := tokens[0];
        
        if command == "v" && tokens.count >= 4       append(*positions, .{string_to_float(tokens[1]), string_to_float(tokens[2]), string_to_float(tokens[3])});
        else if command == "vt" && tokens.count >= 3 append(*texcoords, .{string_to_float(tokens[1]), string_to_float(tokens[2])});
        else if command == "vn" && tokens.count >= 4 append(*normals, .{string_to_float(tokens[1]), string_to_float(tokens[2]), string_to_float(tokens[3])});
        else if command == "f" && tokens.count >= 4 {
            // Face - convert to indexed vertices and triangulate
            // Store face vertex indices
            face_indices: [..]u32;
            defer array_free(face_indices);
            
            for i: 1..tokens.count-1 {
                indices := split(tokens[i], "/");
                defer array_free(indices);
                
                key: Vertex_Key;
                
                if indices.count >= 1 && indices[0].count > 0 key.v_idx  = string_to_int(indices[0]) - 1;
                if indices.count >= 2 && indices[1].count > 0 key.vt_idx = string_to_int(indices[1]) - 1;
                if indices.count >= 3 && indices[2].count > 0 key.vn_idx = string_to_int(indices[2]) - 1;
                
                existing_index, found := table_find(*vertex_map, key);
                
                vertex_index: u32;
                if found vertex_index = xx existing_index;
                else {
                    vertex: Vertex;
                    
                    if key.v_idx >= 0  && key.v_idx  < positions.count vertex.position = positions[key.v_idx];
                    if key.vt_idx >= 0 && key.vt_idx < texcoords.count vertex.texcoord = texcoords[key.vt_idx];
                    if key.vn_idx >= 0 && key.vn_idx < normals.count   vertex.normal = normals[key.vn_idx];
                    
                    vertex_index = cast(u32)model.vertices.count;
                    array_add(*model.vertices, vertex);
                    table_add(*vertex_map, key, vertex_index);
                }
                
                array_add(*face_indices, vertex_index);
            }
            
            for i: 1..face_indices.count-2 {
                array_add(*model.indices, face_indices[0]);
                array_add(*model.indices, face_indices[i]);
                array_add(*model.indices, face_indices[i + 1]);
            }
        }
    }
    
    return true, model;
}