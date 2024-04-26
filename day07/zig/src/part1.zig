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

    var it = std.mem.tokenizeScalar(u8, content, '\n');
    while (it.next()) |line| {
        _ = line;
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

    printResult("Part 1", result, start, end);
}

fn printResult(part: []const u8, result: []const u8, start: i128, end: i128) void {
    print("{s} - Result: {s}\n", .{ part, result });
    const time = @as(f64, @floatFromInt((end - start)));
    if (time > 1000 * 1000 * 1000 * 60) {
        print("{s} - Time: {d:.3} min\n", .{ part, time / (1000 * 1000 * 1000 * 60) });
    } else if (time > 1000 * 1000 * 1000) {
        print("{s} - Time: {d:.3} s  \n", .{ part, time / (1000 * 1000 * 1000) });
    } else if (time > 1000 * 1000) {
        print("{s} - Time: {d:.3} ms \n", .{ part, time / (1000 * 1000) });
    } else if (time > 1000) {
        print("{s} - Time: {d:.3} μs \n", .{ part, time / 1000 });
    } else {
        print("{s} - Time: {d:.3} ns \n", .{ part, time });
    }
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
