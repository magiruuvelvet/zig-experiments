const std = @import("std");
const print = @import("print.zig").print;

// '[*:0]const u8' (Zig) == 'const char*' (C)

export fn zig_print(ptr: [*:0]const u8) void
{
    //defer std.heap.page_allocator.free(ptr);
    const name: []const u8 = std.mem.span(ptr);

    print("{s}\n", .{name});
}
