const std = @import("std");
const print = @import("print.zig").print;
const errors = @import("errors.zig");
const pointers = @import("pointers.zig").main;

// const c = @cImport({
//     @cInclude("./clib.h");
// });

// function return types:
//   - datatype (function must not have an error condition or handle all possible errors internally)
//   - error!datatype (function can have an error condition which must be handled with catch)
//

fn throw_error_test(is_error: bool) errors.InheritedError!void
{
    if (is_error)
    {
        return errors.InheritedError.ErrorCode1;
    }
}

fn handle_error_test(e: errors.InheritedError) void
{
    print("Error: {}\n", .{e});
}

const builtin_panic = std.builtin.default_panic;

pub fn panic(msg: []const u8, error_return_trace: ?*std.builtin.StackTrace, ret_addr: ?usize) noreturn
{
    print("PANIC\n", .{});
    builtin_panic(msg, error_return_trace, ret_addr);

    // _ = msg;
    // _ = error_return_trace;
    // _ = ret_addr;
    // std.os.exit(255);
}

fn test_panic_handler() void
{
    var x: u8 = 255;
    x += 1;
}

pub fn main() u8
{
    print("Hello, {s}!\n", .{"world"});
    print("{d}\n", .{
        [_]u16{1,2,3},
    });

    // should print error.ErrorCode1
    throw_error_test(true) catch |e| handle_error_test(e);
    // should print nothing
    throw_error_test(false) catch |e| handle_error_test(e);

    // ignore errors by providing empty catch body
    throw_error_test(true) catch {};

    //c.add(1, 2);

    //test_panic_handler();

    pointers();

    // import module in middle of code
    @import("comptime.zig").comptime_reflection();

    @import("struct.zig").main();
    @import("loops.zig").main();

    return 0;
}
