const std_build = @import("std").build;
const Builder = std_build.Builder;
const Step = std_build.Step;
const LibExeObjStep = std_build.LibExeObjStep;
const SharedLibKind = LibExeObjStep.SharedLibKind;

pub fn build(b: *Builder) void
{
    const c_flags = [_][]const u8{
        "-std=c11",
    };

    const clib = b.addStaticLibrary("clib", null);
    clib.addCSourceFile("src/clib.c", &c_flags);
    clib.setBuildMode(b.standardReleaseOptions());
    clib.addIncludePath("src");
    clib.linkLibC();

    const exe = b.addExecutable("test", "src/main.zig");
    exe.setBuildMode(b.standardReleaseOptions());

    exe.addIncludePath("src");
    exe.addPackage(.{ .name = "submodule-name", .source = .{ .path = "submodule/src/lib.zig" } });

    exe.linkLibC();
    exe.linkLibrary(clib);
    exe.install();

    const shared_lib = b.addSharedLibrary("zigshared", "src/shared.zig", SharedLibKind.unversioned);
    shared_lib.setBuildMode(b.standardReleaseOptions());
    //shared_lib.linkLibC();

    //===
    // const zigshared_install = try b.allocator.create(RemoveLibPrefixInstallStep);
    // zigshared_install.* = .{
    //     .builder = b,
    //     .step = Step.init(.Custom, "install zigshared.so", b.allocator, RemoveLibPrefixInstallStep.make),
    //     .install_dir = shared_lib,
    // };
    // zigshared_install.step.dependOn(&shared_lib.step);
    // b.getInstallStep().dependOn(&zigshared_install.step);
    //===
    shared_lib.install();

    b.default_step.dependOn(&exe.step);
}

// const RemoveLibPrefixInstallStep = struct {
//     builder: *Builder,
//     step: Step,
//     pam_rundird: *LibExeObjStep,

//     fn make(step: *Step) !void
//     {
//         const self = @fieldParentPtr(RemoveLibPrefixInstallStep, "step", step);
//         const builder = self.builder;

//         const full_dest_path = builder.getInstallPath(.{}, "zigshared.so");
//         try builder.updateFile(self.install_dir.getOutputPath(), full_dest_path);
//     }
// };
