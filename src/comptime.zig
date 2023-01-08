const print = @import("print.zig").print;

pub fn comptime_reflection() void
{
    // custom compiler error
    // @compileError("my error");

    comptime var flt: f32 = undefined;

    typeinfo(0);
    typeinfo(0.0);
    typeinfo("string");
    typeinfo(flt);
}

fn typeinfo(arg: anytype) void
{
    const ArgType = @TypeOf(arg);
    const arg_type_info = @typeInfo(ArgType);

    print("arg_type_info: {}\n", .{arg_type_info});

    // works only with switch, there seems to be no comptime if
    switch (arg_type_info)
    {
        .Float => |flt|
            print("arg_type_info(Float): bits={}\n", .{flt.bits}),
        else => {}
    }
}
