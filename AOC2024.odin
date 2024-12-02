package AOC2024;
import "core:fmt"
import "core:strconv"
import "core:os"
import day1 "day1"
import day2 "day2"


main :: proc()
{
    //Take input from user
    fmt.println("Enter the day number: ")
    input: [256]byte
    n, err:= os.read(os.stdin, input[:])
    if err != nil {
        fmt.println("Error reading input")
        os.exit(1)
    }
    if n == 0 {
        fmt.println("No input provided")
        os.exit(1)
    }
    if input[0] == '*' {
        all_days()
        os.exit(0)
    }
    
    day_number := strconv.atoi(string(input[:n-1]))
    fmt.printf("Day number: %d\n", day_number)
    //Switch case for different days
    switch day_number{
    case 1:
        day_1_tasks()
    case 2:
        day_2_tasks()
    case:
        fmt.println("Invalid day number/Day not yet complete.")
    }
}
day_1_tasks :: proc(){
    //Task 1
    fmt.println("Task 1: ")
    fmt.println(day1.read_input_file_to_distance("day1\\input.txt"))
    //Task 2
    fmt.println("Task 2: ")
    fmt.println(day1.read_input_to_sum("day1\\input.txt"))
}
day_2_tasks :: proc(){
    //Task 1
    fmt.println("Task 1: ")
    fmt.println(day2.check_safety_part_1("day2\\input.txt"))
    //Task 2
    fmt.println("Task 2: ")
    fmt.println(day2.check_safety_part_2("day2\\input.txt"))
}

all_days :: proc(){
    for i:=1; i<=25; i+=1 {
        fmt.printf("Day %d\n", i)
        switch i{
        case 1:
            day_1_tasks()
            fmt.println("\n")
        case 2:
            day_2_tasks()
        case:
            fmt.println("Day not yet complete.")
        }
    }
}