#include <std/string.pat>

u16 innerChunkCount;
u32 chunkSize;
u64 chunkStart;

fn until(u8 n) {
    u8 check @ $;
    return check != n;
};

struct TextureHeader {
    u16 data[20];
    char name[32] [[color("FFFF55")]];
};

struct TextureChunk {
    u32 count;
    padding[20];
    char name[32] [[color("FFFF55")]];
    TextureHeader headers[count];
};

struct SubObject {
    u16 info[6];
    char name[32] [[color("FFFF55")]];
};

struct Object {
    padding[4];
    u32 count;
    SubObject subObjects[count];
};

struct ObjectChunk {
    u16 count;
    padding[2];
    u32 offsets[count];
    Object objects[count];
};

// struct SubData1 {
//     float a [[color("FF0000")]];
//     float b [[color("BB0000")]];
//     float c [[color("880000")]];
//     float d [[color("660000")]];
// };

// struct SubData2 {
//     u16 a [[color("00FF00")]];
//     u16 b [[color("00BB00")]];
//     u16 c [[color("008800")]];
// };

struct DataBlock {
    u8 flags[4];
    if ((flags[0] > 0) && flags[0] != 0xDD && flags[1] == 0x80) {
        padding[6 * flags[2]];
        if (flags[0] == 0x74 || flags[0] == 0x76 || flags[0] == 0x72 || flags[0] == 0x59) {
            padding[2];
        }
    } else {
        if (flags[0] == 0 && flags[1] == 0x80 && flags[2] == 2) {
            padding[36];
        } else if (flags[0] == 0xDD && flags[1] == 0x80 && flags[2] == 0x0F) {
            padding[4];
            break;
        } else if ((flags[0] == 9 || flags[0] == 2) && flags[1] == 0xC0) {
            padding[16 * flags[2]];
        }
    }
};

struct SubData3 {
    u8 flags[4];
    if ((flags[0] == 0x09 || flags[0] == 0x02) && flags[1] == 0x80) {
        padding[flags[2] * 16];
        break;
    } else if (flags[3] == 0x6C) {
        u32 offset;
        if (flags[0] == 0) {
            padding[offset - 4];
        } else if (offset > 0) {
            padding[4 + offset];
        } else {
            padding[8];
        }
    }
};

struct SubData4 {
    padding[172];
    char name[16] [[color("FFFF55")]];
    padding[48];
    u32 check2;
    if (check2 == 3574563037) {
        break;
    }
};

struct DataBlock2 {
    u32 unk[3];
    u32 check;
    if (check >= 1065353210 && check <= 1065353216) {
        SubData4 subData3[while(true)];
        break;
    }
    u32 unk2[6];
    u8 unk3[8];
    SubData3 subData[while(true)];
    u8 flags[4];
    padding[16 * flags[2]];
};

struct SubData5 {
    float u [[color("0000EE")]];
    float v [[color("0000AA")]];
};

struct DataBlock3 {
    u8 flags[4];
    if ((flags[0] > 0) && flags[0] != 0xDD && flags[1] == 0x80 && flags[3] != 0x80) {
        padding[6 * flags[2]];
        if (flags[0] == 0x74 || flags[0] == 0x60 || flags[0] == 0x62 || flags[0] == 0x5E || flags[0] == 0x18 || flags[0] == 0x4F || flags[0] == 0x42 || flags[0] == 0x13|| flags[0] == 0x15) {
            padding[2];
        }
    } else {
        if (flags[0] == 0 && flags[1] == 0x80 && flags[2] == 2) {
            padding[36];
        } else if (flags[0] == 0xDD && (flags[1] == 0x80 || flags[1] == 0x90) && flags[2] == 0x0F) {
            padding[4];
            break;
        } else if ((flags[0] == 9 || flags[0] == 2) && flags[1] == 0xC0) {
            padding[16 * flags[2]];
        }
    }
};

struct SubData6 {
    u8 check[4];
    if (check[0] == 0xDD && check[1] == 0x80 && check[2] == 0x0F) {
        padding[4];
        break;
    }
    padding[236];
};

struct GeometryBlock {
    padding[48];
    char name[32] [[color("FFFF55")]];
    padding[56];
    u32 head;
    u32 headCount;
    if (headCount > 0) {
        u32 size[headCount];
        u32 count;  
        u8 unk1[count] [[color("FFFFFF")]];
        u32 data[2];
        padding[8];
        if (data[0] == 196610) {
            DataBlock2 blocks[while(true)];
        } else if (data[0] == 0) {
            u32 offset;
            padding[offset - 12];
            u8 flags[4];
            padding[16 * flags[2]];
            DataBlock blocks[while(true)];
        } else if (data[0] == 65537) {
            u32 offset;
            padding[offset - 20];
            u8 flags[4];
            padding[16 * flags[2]];
            DataBlock3 blocks[while(true)];
        }
    } else {
        padding[8];
        SubData6 subData[while(true)];
    }
} [[name(name)]];

struct GeometryChunk {
    u16 count;
    padding[2];
    u32 offsets[count];
    GeometryBlock blocks[count];
};

struct Material {
    u32 index;
    char name[while(until(0))];
};

struct MaterialChunk {
    u16 count;
    padding[2];
    u32 size;
    padding[size - 8];
    Material materials[count];
};

struct Chunk {
    u32 typeId;
    u32 size;
    padding[56];
    chunkSize = size;
    chunkStart = $;

    match(typeId) {
        (917634): TextureChunk textures;
        (917607): ObjectChunk object;
        (917544): GeometryChunk chunk;
        (917764): MaterialChunk chunk;
    }
    
    $ = chunkStart + size;
} [[name(std::string::to_string(typeId))]];

struct DBL {
    padding[24];
    u16 count;
    padding[6];
    Chunk chunks[count];
};

char sizeText[4] @ 0x0;
u32 skip = std::string::parse_int(sizeText, 10);
DBL file @ skip;