const std = @import("std");

pub fn main() !void {
    // Prints to stderr (it's a shortcut based on `std.io.getStdErr()`)
    std.debug.print("Starting... \n", .{});
    
    var general = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = general.deinit();
    const gpa = general.allocator();

    var file = try std.fs.cwd().openFile("input.txt", .{});
    defer file.close();
    
    var buf_reader = std.io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();
    var current: u32 = 0;
    var most: [3]u32 = [3]u32{0,0,0};
    var list = std.ArrayList(u32).init(gpa);
    defer list.deinit();
    var tmp: u32 = 0;

    var buf: [1024]u8 = undefined;
    while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        //std.debug.print("line: {s}\n", .{line});
        if (line.len == 1){
            var slice = list.toOwnedSlice();
            defer gpa.free(slice);
            tmp = total(slice);
            if ((tmp > most[0]) or (tmp > most[1]) or (tmp > most[2])){
                replaceLowest(&most, tmp);
            }
        } else {
            //std.debug.print("buf len = {d}", .{line.len});
            current = try std.fmt.parseInt(u32, line[0..(line.len-1)], 10);
            try list.append(current);
        }
    }

    std.debug.print("most: {d}", .{most});
    std.debug.print("total: {d}", .{total(&most)});
    // stdout is for the actual output of your application, for example if you
    // are implementing gzip, then only the compressed bytes should be sent to
    // stdout, not any debugging messages.
    // const stdout_file = std.io.getStdOut().writer();
    // var bw = std.io.bufferedWriter(stdout_file);
    // const stdout = bw.writer();

    // try stdout.print("Run `zig build test` to run the tests.\n", .{});

    // try bw.flush(); // don't forget to flush!
}

pub fn replaceLowest(slice: []u32, input: u32) void{
    if ((slice[0] <= slice[1]) and (slice[0] <= slice[2])){
        slice[0] = input;
    }
    else if ((slice[1] <= slice[0]) and (slice[1] <= slice[2])){
        slice[1] = input;
    }
    else if ((slice[2] <= slice[1]) and (slice[2] <= slice[0])){
        slice[2] = input;
    }
}

pub fn total(list: []const u32) u32 {
    var output: u32 = 0;
    for (list) |item| {
        output += item;
    }
    return output;
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}

test "value adding" {
    const test_items = [_]u32 {1000,2000,3000};
    try std.testing.expect(total(&test_items) == 6000);
}
