const print = @import("print.zig").print;

pub fn main() void
{
    var a: u64 = 0;

    print("*a={}\n", .{&a});

    inc(null, 10);
    inc(&a, 10);

    print("a={}\n", .{a}); // 10

    //inc_nonull(null, 10); <-- compiler error
    inc_nonull(&a, 10);

    print("a={}\n", .{a}); // 20
}

// can pass in null
pub fn inc(v: ?*u64, inc_by: u64) void
{
    if (v != null)
    {
        v.?.* += inc_by;
    }
}

// compiler error when passing null
pub fn inc_nonull(v: *u64, inc_by: u64) void
{
    v.* += inc_by;
}
