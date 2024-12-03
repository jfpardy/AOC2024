package day3
import "core:fmt"
import "core:os"
import "core:strings"
import "core:strconv"
import "core:math"
import "../utils"


//General purpose
parse_next_mul :: proc(s : string) -> int {
    x, x_err := strconv.parse_int(s[:])
    if x_err do return 0
    x_digits := int(math.floor(math.log10(f32(x))+1))
    if s[x_digits] != ',' do return 0

    y, y_err := strconv.parse_int(s[x_digits+1:])
    if y_err do return 0

    y_digits := int(math.floor(math.log10(f32(y))+1))
    if s[x_digits+1+y_digits] != ')' do return 0

    return x*y
}

//Task 1
task1 :: proc(file_name : string) -> int {
    input := utils.read_entire_file_to_string(file_name)
    result := 0
    for i:= 0; i < len(input); i +=1 {
        if strings.starts_with(input[i:], "mul(") do result += parse_next_mul(input[i+4:])
    }

    return result
}

//Task 2
task2 :: proc(file_name : string) -> int {
    input := utils.read_entire_file_to_string(file_name)
    result := 0
    enabled := true
    for i:= 0; i < len(input); i +=1 {
        if strings.starts_with(input[i:], "mul(") && enabled do result += parse_next_mul(input[i+4:])
        else if strings.starts_with(input[i:], "don't") do enabled = false
        else if strings.starts_with(input[i:], "do") do enabled = true
    }

    return result
}


main :: proc()  {
    task_1_result := task1("input.txt")
    fmt.print("Task 1: ",task_1_result, '\n')
    task_2_result := task2("input.txt")
    fmt.print("Task 2: ",task_2_result, '\n')
}
