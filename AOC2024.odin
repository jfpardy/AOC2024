package AOC2024;
import "core:fmt"
import day1 "day1"


main :: proc()
{
    //Day 1
    fmt.println("################# Day 1 #################")
    //Task 1
    fmt.println("Task 1: ")
    day1.read_input_file_to_distance("day1\\input.txt")
    //Task 2
    fmt.println("\nTask 2: ")
    day1.read_input_to_sum("day1\\input.txt")
}