/*
This file contains some functions that are completetly out of place in other parts of the code
but are needed for its functioning due to some missing parts of the standard library.

@TODO: 
Add find_by procedure
Add multi-argument append_if_unique
Add pop_back procedure
*/

enum_name :: (t: $T) -> string  {
    info :: type_info(T);
    #assert(info.type == .ENUM);
    return info.names[t.(s64)];
}

radians :: (angle: float32) -> float32 { return angle * PI / 180.0; }

copy :: array_copy;
free :: array_free;
reset :: array_reset;
append :: array_add;
append_if_unique :: array_add_if_unique;
insert_at :: array_insert_at;
unordered_remove_by_value :: array_unordered_remove_by_value;
unordered_remove_by_index :: array_unordered_remove_by_index;
ordered_remove_by_value :: array_ordered_remove_by_value;
ordered_remove_by_index :: array_ordered_remove_by_index;
find :: array_find;
reserve :: array_reserve;
resize :: array_resize;

ensure_space :: table_ensure_space;
append :: table_add;
set :: table_set;
contains :: table_contains;
find_pointer :: table_find_pointer;
find :: table_find;
find_multiple :: table_find_multiple;
//remove :: table_remove;