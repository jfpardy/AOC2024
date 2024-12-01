package day1;
import "core:fmt";
import "core:os"
import "core:strings"
import "core:strconv"
import "core:slice"
main :: proc (){
    //Task 1
    read_input_file_to_distance("input.txt")
    //Task 2
    read_input_to_sum("input.txt")
}

input :: struct {
    first_list: [dynamic]int,
    second_list: [dynamic]int,
}
read_input_to_structs :: proc(file_name :string) ->input{
    FileHandle, Error := os.open(file_name, os.O_RDONLY)
    result := input{}
    defer os.close(FileHandle)
    if Error != nil {
        fmt.printf("Error opening file: %s\n", Error)
    }
    input_string := read_entire_file_to_string(FileHandle)
    string_array := strings.split(input_string, "\n")

    for line in string_array {
        if line == "" {
            continue
        }
        strings_input := strings.split(line, "   ")
        append(&result.first_list,strconv.atoi(strings_input[0]))
        append(&result.second_list,strconv.atoi(strings_input[1]))
    }
    //Sort the lists
    slice.sort(result.first_list[:])
    slice.sort(result.second_list[:])
    return result
}

read_input_to_sum :: proc(file_name :string) ->int {
    input := read_input_to_structs(file_name)
    sum_list :[dynamic]int
    for i:=0; i < len(input.first_list); i+=1 {
        append(&sum_list, 0)
        count :int = 0;
        for j:=0; j < len(input.first_list); j+=1 {
            if input.first_list[i] == input.second_list[j] {
                count += 1
            }
        }
        sum_list[i] += count*input.first_list[i]
    }
    sum := 0;
    for i:=0 ; i < len(sum_list); i+=1 {
        sum += sum_list[i]
    }
    fmt.print(sum)
    return sum
}
frequency_of_int :: proc(number:int, a: [dynamic]int) -> int {
    count := 0
    for i:=0; i < len(a); i+=1 {
        if a[i] == number {
            count += 1
        }
    }
    return count
}
read_input_file_to_distance :: proc (file_name: string) -> int {
    result := read_input_to_structs(file_name)
    output: int = 0
    output = find_distance(result)
    
    fmt.print(output)
    return output
}
find_distance :: proc(input: input) -> int {
    output :int = 0
    for i:= 0; i < len(input.first_list); i+=1 {
        output += abs(input.first_list[i] - input.second_list[i])
    }
    return output
}
read_entire_file_to_string :: proc(FileHandle: os.Handle) -> string {
    Size,_:=os.file_size(FileHandle)
    Buffer : []byte = make([]byte, Size)
    os.read(FileHandle, Buffer)
    return string(Buffer)
}