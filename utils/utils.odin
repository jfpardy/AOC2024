package utils;
import "core:fmt"
import "core:os"
import "core:strconv"

read_entire_file_to_string :: proc(file_name: string) -> string {
    FileHandle, err := os.open(file_name, os.O_RDONLY)
    defer os.close(FileHandle)
    Size,_:=os.file_size(FileHandle)
    Buffer : []byte = make([]byte, Size)
    os.read(FileHandle, Buffer)
    return string(Buffer)
}