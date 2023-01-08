const std = @import("std");
const stdout = std.io.getStdOut().writer();

pub fn library_function() void
{
    stdout.print("library_function\n", .{}) catch {};
}
