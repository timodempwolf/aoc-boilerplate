const std = @import("std");

pub fn readFile(path: []const u8, allocator: std.mem.Allocator) ![]const u8 {
    const file = try std.fs.cwd().openFile(path, .{});
    defer file.close();
    const file_size = (try file.stat()).size;
    const content = try allocator.alloc(u8, file_size);
    _ = try file.readAll(content);
    return content;
}

pub fn printResult(result: []const u8, start: i128, end: i128) void {
    std.debug.print("Result:\n{s}\n", .{std.mem.trimRight(u8, result, " \t\r\n")});
    const time = @as(f64, @floatFromInt((end - start)));
    if (time > 1000 * 1000 * 1000 * 60) {
        std.debug.print("Execution time: {d:.3} min\n", .{time / (1000 * 1000 * 1000 * 60)});
    } else if (time > 1000 * 1000 * 1000) {
        std.debug.print("Execution time: {d:.3} s  \n", .{time / (1000 * 1000 * 1000)});
    } else if (time > 1000 * 1000) {
        std.debug.print("Execution time: {d:.3} ms \n", .{time / (1000 * 1000)});
    } else if (time > 1000) {
        std.debug.print("Execution time: {d:.3} μs \n", .{time / 1000});
    } else {
        std.debug.print("Execution time: {d:.3} ns \n", .{time});
    }
}
