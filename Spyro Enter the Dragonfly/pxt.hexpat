#include <std/mem.pat>

u32 clutSize;

fn next_texture() {
    u32 check @ $;
    u32 check2 @ $ + 4;
    u32 check3 @ $ + 8;
    u32 check4 @ $ + 12;
    return check == 4 && check2 == 268435456 && check3 == 14 && check4 == 0;
};

struct Header {
    padding[48];
    u32 width [[color("FFFFFF")]];
    u32 height [[color("FFFFFF")]];
    padding[40];
};

struct Color {
    u8 r [[color("FF0000")]];
    u8 g [[color("00FF00")]];
    u8 b [[color("0000FF")]];
    u8 a [[color("000000")]];
};

struct CLUT {
    Header header;
    Color colors[header.width * header.height];
};

struct Texture {
    Header header;
    if (clutSize >= 256) {
        u8 indices[header.width * header.height] [[color("112255")]];
    } else {
        // should be if clut size is 16
        u8 indices[header.width * header.height * 0.5] [[color("112255")]];
    }
    
};

struct PXT {
    padding[12];
    u16 unknown [[color("FFFFFF")]];
    u16 unknown2 [[color("FFFFFF")]];
    CLUT clut;
    clutSize = clut.header.width * clut.header.height;
    Texture texture[while(next_texture())];
    if (!std::mem::eof()) {
        padding[16];
    }
};

PXT chunks[while(!std::mem::eof())] @ 0;