package day2;
import "core:fmt"
import "core:os"
import "core:strings"
import "core:strconv"
import "core:slice"
main :: proc() {
    num_safe := check_safety_part_1("input.txt")
    fmt.print(num_safe, '\n')
    num_safe = check_safety_part_2("input.txt")
    fmt.print(num_safe, '\n')
}

InputStruct :: struct {
    Levels: [dynamic][dynamic]int
}

check_safety_part_1 :: proc(file_name : string) -> int {
    input := load_input(file_name)
    count := 0
    //Loop through each outer array
    for i := 0; i < len(input.Levels); i += 1 {
        levels := input.Levels[i]
        safe := check_safety(levels)
        if safe {
            count += 1
        }
    }

return count
}

check_safety :: proc (levels: [dynamic]int) -> bool{
    safe:= true
    increasing : bool            
    for j := 0; j < len(levels); j += 1 {
        //true is increasing, false is decreasing

        if j == 0 {
            increasing = levels[j] < levels[j+1]
        }
        else{
        if abs(levels[j] - levels[j-1]) > 3 {
            safe = false
            break
        }
        else if abs(levels[j] - levels[j-1]) < 1{
            safe = false
            break
        }
        //Check if all values are increasing or decreasing
            if increasing != (levels[j] > levels[j-1]) {
                safe = false
                break
        }
    }
}
return safe
}
check_safety_part_2 :: proc(file_name: string) -> int{
    input := load_input(file_name)
    count := 0
    
    for i := 0; i < len(input.Levels); i += 1 {
        levels :[dynamic]int= input.Levels[i]
        safety := check_safety(levels)
        if safety {
            count += 1
            
        }
        else{
        for j:= 0; j <len(input.Levels[i]); j += 1{
            updated_levels :[dynamic]int
            append(&updated_levels, ..levels[0:j])
            append(&updated_levels, ..levels[j+1:])
            safety = check_safety(updated_levels)
            if safety {
                count += 1
                break
            }
        }
    }
    }
    return count
}

load_input :: proc(file_name : string) -> InputStruct {
    file, err := os.open(file_name)
    input : InputStruct
    if err != nil {
        fmt.println("Error: %s", err)
        os.exit(1)
    }
    defer os.close(file)
    file_contents := read_entire_file_to_string(file)
    lines := strings.split(file_contents, "\n")
    for i := 0; i < len(lines); i += 1 {
        if lines[i] == "" {
            continue
        }
        append(&input.Levels, [dynamic]int{})
        levels_str := strings.split(lines[i], " ")
        for j := 0; j < len(levels_str); j += 1 {
            output, _ := strconv.parse_int(levels_str[j])
            append(&input.Levels[i], output)
        }
    }
    return input
}

read_entire_file_to_string :: proc(FileHandle: os.Handle) -> string {
    Size,_:=os.file_size(FileHandle)
    Buffer : []byte = make([]byte, Size)
    os.read(FileHandle, Buffer)
    return string(Buffer)
}