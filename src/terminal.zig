//https://wiki.osdev.org/Printing_To_Screen
//
// vga col defs
const VGA_COLOR_BLACK = 0;
const VGA_COLOR_BLUE = 1;
const VGA_COLOR_GREEN = 2;
const VGA_COLOR_CYAN = 3;
const VGA_COLOR_RED = 4;
const VGA_COLOR_MAGENTA = 5;
const VGA_COLOR_BROWN = 6;
const VGA_COLOR_LIGHT_GREY = 7;
const VGA_COLOR_DARK_GREY = 8;
const VGA_COLOR_LIGHT_BLUE = 9;
const VGA_COLOR_LIGHT_GREEN = 10;
const VGA_COLOR_LIGHT_CYAN = 11;
const VGA_COLOR_LIGHT_RED = 12;
const VGA_COLOR_LIGHT_MAGENTA = 13;
const VGA_COLOR_LIGHT_BROWN = 14;
const VGA_COLOR_WHITE = 15;

const VGA_WIDTH = 80;
const VGA_HEIGHT = 25;

// vid men address
var buffer: [*]volatile u16 = @ptrFromInt(0xB8000);

//https://wiki.osdev.org/Printing_To_Screen#Basics
fn vgaEntry(char: u8, color: u8) u16 {
    const c: u16 = color;
    return char | (c << 8);
}

fn putCharAt(char: u8, color: u8, x: usize, y: usize) void {
    const index = y * VGA_WIDTH + x;
    buffer[index] = vgaEntry(char, color);
}

pub fn clearScreen() void {
    const col = VGA_COLOR_WHITE | (VGA_COLOR_BLUE << 4);
    for (0..VGA_WIDTH * VGA_HEIGHT) |i| {
        buffer[i] = vgaEntry(' ', col);
    }
}

// write to top of screen
pub fn writeString(str: []const u8) void {
    const col = VGA_COLOR_WHITE | (VGA_COLOR_BLUE << 4);
    var i: u8 = 0;
    for (str) |c| {
        putCharAt(c, col, i, 0);
        i += 1;
    }
}
