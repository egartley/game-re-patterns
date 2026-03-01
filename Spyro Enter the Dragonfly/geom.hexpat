#include <std/mem.pat>
#pragma pattern_limit 2548576

fn check_header() {
    u8 check @ $ + 1;
    u8 check2 @ $ + 2;
    u8 check3 @ $ + 3;
    u8 check4 @ $ + 4;
    u8 check5 @ $ + 5;
    u8 check6 @ $ + 6;
    u8 check7 @ $ + 7;
    return check == 0x20 && check2 == 0x40 && check3 == 0x40 && check4 == 0x40
        && check5 == 0x40 && check6 == 0x01 && check7 == 0x80;
};

fn check_header2() {
    u8 check @ $ + 1;
    u8 check2 @ $ + 2;
    u8 check3 @ $ + 3;
    u8 check4 @ $ + 4;
    u8 check5 @ $ + 5;
    u8 check6 @ $ + 6;
    u8 check7 @ $ + 7;
    return check == 0x20 && check2 == 0x54 && check3 == 0x54 && check4 == 0x54
        && check5 == 0x54 && check6 == 0xC1 && check7 == 0x80;
};

fn check_header3() {
    u8 check @ $ + 1;
    u8 check2 @ $ + 2;
    u8 check3 @ $ + 3;
    u8 check4 @ $ + 4;
    u8 check5 @ $ + 5;
    u8 check6 @ $ + 6;
    u8 check7 @ $ + 7;
    return check == 0x20 && check2 == 0x40 && check3 == 0x40 && check4 == 0x40
        && check5 == 0x40 && check6 == 0xB8 && check7 == 0x02;
};

fn check_header4() {
    u8 check @ $ + 1;
    return check == 0x40;
};


struct Vertex {
    float x [[color("EE0000")]];
    float y [[color("00EE00")]];
    float z [[color("0000EE")]];
};

struct Normal {
    u16 x [[color("EE0000")]];
    u16 y [[color("00EE00")]];
    u16 z [[color("0000EE")]];
};

struct Color {
    u8 r [[color("EE0000")]];
    u8 g [[color("00EE00")]];
    u8 b [[color("0000EE")]];
    u8 a [[color("555555")]];
};

struct Unknown2 {
    float x [[color("888888")]];
    float y [[color("888888")]];
    float z [[color("888888")]];
};

struct Unknown {
    padding[6];
    u8 count [[color("888888")]];
    padding[1];
    Unknown2 unknowns[count];
};

struct UV {
    float u [[color("EEEE00")]];
    float v [[color("EE00EE")]];
};

struct LevelChunk {
    padding[while(!check_header())];
    padding[8];
    u8 vertexCount [[color("FFFFFF")]];
    padding[1];
    Vertex vertices[vertexCount];
    padding[14];
    u8 normalCount [[color("FFFFFF")]];
    u8 normalCheck [[color("FFFFFF")]];
    Normal normals[normalCount];
    if (normalCheck == 0x78) {
        Normal normals2[normalCount];
    }
    padding[while(!check_header2())] [[color("000000")]];
    padding[8];
    u8 unknownCount [[color("FFFFFF")]];
    padding[1];
    u32 unknown [[color("FFFFFF")]];
    padding[42];
    u8 colorCount [[color("FFFFFF")]];
    padding[1];
    if (normalCheck == 0x78) {
        Color colors[colorCount * 4];
    } else {
        Color colors[colorCount];
    }
    padding[14];
    u8 uvCount [[color("FFFFFF")]];
    padding[1];
    UV uvs[uvCount];
    padding[15];
    u8 type [[color("FFFFFF")]];
};

LevelChunk chunks[while(!std::mem::eof())] @ 0x10;