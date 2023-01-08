const print = @import("print.zig").print;

pub fn main() void
{
    var i: u64 = 0;
    while (i != 10)
    {
        print("{}", .{i});
        i += 1;
    }
    print("\n", .{});

    i = 0;
    while (i != 10) : (i += 1)
    {
        print("{}", .{i});
    }
    print("\n", .{});

    const items = [_]i32{-1, 0, 1, 2};
    for (items) |*item|
    {
        print("{}", .{item.*});
    }
    print("\n", .{});

    var modify = [_]i32{1,2,3,4,5};
    for (modify) |*mod|
    {
        mod.* += 10;
    }
    print("{d}\n", .{modify});

    const MyType = struct {
        val: u8,
    };

    const structs = [_]MyType{
        MyType{.val=20},
        MyType{.val=20},
    };

    // structs={ loops.main.MyType{ .val = 20 }, loops.main.MyType{ .val = 20 } }
    print("structs={any}\n", .{structs});
}
