const std = @import("std");
const stdout = std.io.getStdOut().writer();

pub fn print(comptime fmt: []const u8, args: anytype) void
{
    stdout.print(fmt, args) catch {};
}
