const std = @import("std");
const utils = @import("utils.zig");

const Allocator = std.mem.Allocator;
const print = std.debug.print;

fn calculate(path: []const u8, allocator: Allocator) ![]const u8 {
    const content = try utils.readFile(path, allocator);
    var result: usize = 0;

    var it = std.mem.tokenizeScalar(u8, content, '\n');
    while (it.next()) |line| {
        // BEGIN TO DELETE
        result = line.len;
        // END TO DELETE
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

    utils.printResult(result, start, end);
}

test "it_works" {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer _ = arena.deinit();
    const allocator = arena.allocator();

    const expected = "fixme";
    const result = try calculate("../example.txt", allocator);

    if (!std.mem.eql(u8, result, expected)) {
        std.debug.print("Expected: {s}, Result: {s}\n", .{ expected, result });
        return error.UnexpectedResult;
    }
}
