const std = @import("std");

// Although this function looks imperative, note that its job is to
// declaratively construct a build graph that will be executed by an external
// runner.
pub fn build(b: *std.Build) void {
    // Standard target options allows the person running `zig build` to choose
    // what target to build for. Here we do not override the defaults, which
    // means any target is allowed, and the default is native. Other options
    // for restricting supported target set are available.
    const target = b.standardTargetOptions(.{});

    // Standard optimization options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall. Here we do not
    // set a preferred release mode, allowing the user to decide how to optimize.
    const optimize = b.standardOptimizeOption(.{});

    const part1 = b.addExecutable(.{
        .name = "part1",
        // In this case the main source file is merely a path, however, in more
        // complicated build scripts, this could be a generated file.
        .root_source_file = .{ .cwd_relative = "src/part1.zig" },
        .target = target,
        .optimize = optimize,
    });

    const part2 = b.addExecutable(.{
        .name = "part2",
        // In this case the main source file is merely a path, however, in more
        // complicated build scripts, this could be a generated file.
        .root_source_file = .{ .cwd_relative = "src/part2.zig" },
        .target = target,
        .optimize = optimize,
    });

    // This declares intent for the executable to be installed into the
    // standard location when the user invokes the "install" step (the default
    // step when running `zig build`).
    b.installArtifact(part1);
    b.installArtifact(part2);

    // This *creates* a Run step in the build graph, to be executed when another
    // step is evaluated that depends on it. The next line below will establish
    // such a dependency.
    const run_part1 = b.addRunArtifact(part1);
    const run_part2 = b.addRunArtifact(part2);
    const run_part2_dependend = b.addRunArtifact(part2);

    // By making the run step depend on the install step, it will be run from the
    // installation directory rather than directly from within the cache directory.
    // This is not necessary, however, if the application depends on other installed
    // files, this ensures they will be present and in the expected location.
    run_part1.step.dependOn(b.getInstallStep());
    run_part2.step.dependOn(b.getInstallStep());
    run_part2_dependend.step.dependOn(&run_part1.step);

    // This allows the user to pass arguments to the application in the build
    // command itself, like this: `zig build run -- arg1 arg2 etc`
    if (b.args) |args| {
        run_part1.addArgs(args);
        run_part2.addArgs(args);
    }

    // This creates a build step. It will be visible in the `zig build --help` menu,
    // and can be selected like this: `zig build run`
    // This will evaluate the `run` step rather than the default, which is "install".
    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_part1.step);
    run_step.dependOn(&run_part2_dependend.step);

    const run_part1_step = b.step("run-part1", "Run part1");
    run_part1_step.dependOn(&run_part1.step);

    const run_part2_step = b.step("run-part2", "Run part2");
    run_part2_step.dependOn(&run_part2.step);

    // Creates a step for unit testing. This only builds the test executable
    // but does not run it.
    const part1_tests = b.addTest(.{
        .root_source_file = .{ .cwd_relative = "src/part1.zig" },
        .target = target,
        .optimize = optimize,
    });
    const part2_tests = b.addTest(.{
        .root_source_file = .{ .cwd_relative = "src/part2.zig" },
        .target = target,
        .optimize = optimize,
    });

    const run_part1_tests = b.addRunArtifact(part1_tests);
    const run_part2_tests = b.addRunArtifact(part2_tests);
    const run_part2_tests_dependend = b.addRunArtifact(part2_tests);

    // Similar to creating the run step earlier, this exposes a `test` step to
    // the `zig build --help` menu, providing a way for the user to request
    // running the unit tests.
    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_part1_tests.step);
    test_step.dependOn(&run_part2_tests_dependend.step);

    const test_part1_step = b.step("test-part1", "Run part1 unit tests");
    test_part1_step.dependOn(&run_part1_tests.step);

    const test_part2_step = b.step("test-part2", "Run part2 unit tests");
    test_part2_step.dependOn(&run_part2_tests.step);
}
