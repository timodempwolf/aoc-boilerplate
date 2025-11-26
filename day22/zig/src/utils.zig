const std = @import("std");

pub fn readFile(path: []const u8, allocator: std.mem.Allocator, io: std.Io) ![]const u8 {
    const file = try std.fs.cwd().openFile(path, .{});
    defer file.close();
    const file_size = (try file.stat()).size;
    var buffer: [1024]u8 = undefined;
    var file_reader = file.reader(io, &buffer);
    var reader = file_reader.interface;
    return reader.readAlloc(allocator, file_size);
}

pub fn printResult(result: []const u8, elapsed: u64) void {
    std.debug.print("Result:\n{s}\n", .{std.mem.trimRight(u8, result, " \t\r\n")});
    const time = @as(f64, @floatFromInt(elapsed));
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
