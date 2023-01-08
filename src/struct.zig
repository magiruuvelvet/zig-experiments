const print = @import("print.zig").print;

pub const Geometry = struct {
    x: u64 = 0,
    y: u64 = 0,
    width: u64 = 0,
    height: u64 = 0,
};

pub fn main() void
{
    var g = Geometry{
        .x = 1,
    };

    // g=struct.Geometry{ .x = 1, .y = 0, .width = 0, .height = 0 }
    print("g={}\n", .{g});

    g = Geometry{};
    // g=struct.Geometry{ .x = 0, .y = 0, .width = 0, .height = 0 }
    print("g={}\n", .{g});

    g.width = 1920;
    g.height = 1080;
    print("g={}\n", .{g});
}
