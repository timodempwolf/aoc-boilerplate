const std = @import("std");
const Allocator = std.mem.Allocator;
const print = std.debug.print;

fn readFile(path: []const u8, allocator: Allocator) ![]const u8 {
    const file = try std.fs.cwd().openFile(path, .{});
    defer file.close();
    const file_size = (try file.stat()).size;
    const content = try allocator.alloc(u8, file_size);
    _ = try file.readAll(content);
    return content;
}

fn calculate(path: []const u8, allocator: Allocator) ![]const u8 {
    const content = try readFile(path, allocator);
    var result: u32 = 0;

    var it = std.mem.split(u8, content, "\n");
    while (it.next()) |line| {
        if (line.len == 0) {
            continue;
        }
        result = 0;
    }
    const result_str = try std.fmt.allocPrint(allocator, "{d}", .{result});
    return result_str;
}

pub fn main() !void {
    //var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    //defer _ = gpa.deinit();
    //const allocator = gpa.allocator();
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer _ = arena.deinit();
    const allocator = arena.allocator();
    const start = std.time.nanoTimestamp();
    const result = try calculate("../input.txt", allocator);
    const end = std.time.nanoTimestamp();
    print("Part 1 - Result: {s}\n", .{result});
    print("Part 1 - Time: {d:.3} μs\n", .{@as(f64, @floatFromInt((end - start))) / 1000});
}

test "Part 1" {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer _ = arena.deinit();
    const allocator = arena.allocator();

    const expected = "13";
    const result = try calculate("../example.txt", allocator);

    if (!std.mem.eql(u8, result, expected)) {
        std.debug.print("Expected: {s}, Result: {s}\n", .{ expected, result });
        return error.UnexpectedResult;
    }
}
