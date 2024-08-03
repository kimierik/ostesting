const std = @import("std");
const terminal = @import("terminal.zig");

export fn kmain() void {
    terminal.clearScreen();
    terminal.writeString("hello fucker");
}
