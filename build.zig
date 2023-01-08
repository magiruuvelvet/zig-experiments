const Builder = @import("std").build.Builder;

pub fn build(b: *Builder) void
{
    // const c_flags = [_][]const u8{
    //     "-std=c11",
    // };

    // const clib = b.addStaticLibrary("clib", null);
    // clib.addCSourceFile("src/clib.c", &c_flags);
    // clib.setBuildMode(b.standardReleaseOptions());
    // clib.linkLibC();

    const exe = b.addExecutable("test", "src/main.zig");
    exe.setBuildMode(b.standardReleaseOptions());

    exe.addPackage(.{ .name = "submodule-name", .source = .{ .path = "submodule/src/lib.zig" } });

    // exe.linkLibC();
    // exe.setOutputDir(".");
    // exe.linkLibrary(clib);
    exe.install();

    b.default_step.dependOn(&exe.step);
}
