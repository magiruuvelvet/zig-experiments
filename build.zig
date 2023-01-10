const std_build = @import("std").build;
const Builder = std_build.Builder;
const Step = std_build.Step;
const LibExeObjStep = std_build.LibExeObjStep;
const SharedLibKind = LibExeObjStep.SharedLibKind;

const c_flags = [_][]const u8{
    "-std=c11",
};

const StepType = enum {
    Executable,
    StaticLibrary,
    SharedLibrary,
};

fn create_step(b: *Builder, comptime stepType: StepType, name: []const u8, root_src: ?[]const u8, comptime kind: ?SharedLibKind) *LibExeObjStep
{
    const step = switch (stepType) {
        StepType.Executable => b.addExecutable(name, root_src),
        StepType.StaticLibrary => b.addStaticLibrary(name, root_src),
        StepType.SharedLibrary => {
            // could be forced to SharedLibKind.unversioned here, but i'm experimenting with the possibilities of Zig :)
            comptime {
                if (stepType == StepType.SharedLibrary and kind == null) {
                    @compileError("Parameter 'kind' can not be null for StepType.SharedLibrary");
                }
            }
            return b.addSharedLibrary(name, root_src, kind.?);
        },
    };

    step.setBuildMode(b.standardReleaseOptions());

    return step;
}

fn build_clib(b: *Builder) *LibExeObjStep
{
    const clib = create_step(b, StepType.StaticLibrary, "clib", null, null);

    clib.addCSourceFile("src/clib.c", &c_flags);
    clib.addIncludePath("src");
    clib.linkLibC();

    return clib;
}

fn build_test(b: *Builder, clib: *LibExeObjStep) *LibExeObjStep
{
    const exe = create_step(b, StepType.Executable, "test", "src/main.zig", null);

    exe.addIncludePath("src");
    exe.addPackage(.{ .name = "submodule-name", .source = .{ .path = "submodule/src/lib.zig" } });

    exe.linkLibC();
    exe.linkLibrary(clib);
    exe.install();

    return exe;
}

fn build_zigshared(b: *Builder) *LibExeObjStep
{
    const zigshared = create_step(b, StepType.SharedLibrary, "zigshared", "src/shared.zig", SharedLibKind.unversioned);

    zigshared.install();

    return zigshared;
}

pub fn build(b: *Builder) void
{
    const clib = build_clib(b);
    const exe = build_test(b, clib);

    _ = build_zigshared(b);

    // error: Parameter 'kind' can not be null for StepType.SharedLibrary
    // _ = create_step(b, StepType.SharedLibrary, "", "", null);

    b.default_step.dependOn(&exe.step);
}
