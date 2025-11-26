const std = @import("std");
const utils = @import("utils.zig");
const Timer = std.time.Timer;

const Allocator = std.mem.Allocator;
const Io = std.Io;
const print = std.debug.print;

fn calculate(
    path: []const u8,
    allocator: Allocator,
    io: Io,
) ![]const u8 {
    const content = try utils.readFile(path, allocator, io);
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

    var threaded: std.Io.Threaded = .init(allocator);
    defer threaded.deinit();
    const io = threaded.io();

    var timer = try Timer.start();
    const result = try calculate("../input.txt", allocator, io);
    const elapsed = timer.read();

    utils.printResult(result, elapsed);
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
