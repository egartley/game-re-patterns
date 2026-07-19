#include <subfilecommon>

u64 ret;
u64 ret2;
u64 skyStart;

u32 vramSize = 524288;
u32 isFlyoverLevel = 0;
u32 gameNumber = 2;

struct GroundSection {
    u32 size;
    ret = $;
    u32 table;
    $ = ret + table;
    u32 partCount;
    u32 partOffsets[partCount];
    GroundPart parts[partCount];
};

struct SoundEffectSection {
    padding[292]; // unknown, back-filled with 0xFF
    u32 count;
    SoundEffect sounds[count];
};

struct CollisionDataSection {
    ret = $;
    u32 size;
    u8 header[12];
    u32 offsets[6]; // offsets from after reading size
    $ = ret + size;
};

struct TextureHeaderSection {
    u32 size;
    u32 count;
    TextureHeader headers[count * 6];
};

struct SkyPart {
    padding[8]; // unknown
    s16 globalY;
    s16 globalZ;
    u8 vertexCount;
    u8 colorCount;
    s16 globalX;
    s16 dataBytes;
    u16 polyBytes;
    u8 packedVertices[vertexCount * 4];
    u8 colors[colorCount * 4];
    u8 packedIndices[polyBytes];
    u8 packedData[dataBytes];
};

struct SkyPartPointer {
    u32 offset;
    SkyPart part @ skyStart + offset;
};

struct SkySection {
    u32 size;
    skyStart = $;
    u32 clearColor;
    u32 partCount;
    SkyPartPointer parts[partCount];
    $ = skyStart + size - 4;
};

struct Subfile1 {
    u32 offset;
    u32 size;
    u32 vramStart @ offset;
    u32 vagStart @ offset + vramSize;
};

struct Subfile2 {
    u32 offset;
    u32 size;
    $ = offset;
    TextureHeaderSection textureHeaders;
    GroundSection ground;
    UnkSection unkSection3;
    UnkSection unkSection4;
    if (isFlyoverLevel == 0) {
        UnkSection unkSection5;
        UnkSection unkSection6;
        padding[12];
        CollisionDataSection collisionDataSection;
    }
    SkySection sky;
    if (isFlyoverLevel == 0) {
        UnkSection unkSection9;
        ParticleEffectSection particleEffectSection;
        UnkSection unkSection11;
        SoundEffectSection soundEffectSection;
    }
};

struct Subfile4 {
    u32 offset;
    u32 size;
    $ = offset;
    if (isFlyoverLevel == 0) {
        if (gameNumber == 2) {
            padding[44];
        } else {
            padding[48];
        }
        UnkSection unkSection1;
        UnkSection unkSection2;
        UnkSection unkSection3;
        UnkSection unkSection4;
        UnkSection unkSection5;
        UnkSection unkSection6;
        UnkSection unkSection7;
        UnkSection unkSection8;
        if (gameNumber == 3) {
            UnkSection unkSection9;
            UnkSection unkSection10;
            UnkSection unkSection11;
            UnkSection unkSection12;
        }
        MobyListSection mobyListSection;
    } else {
        // possible sound data
    }
};

Subfile1 subfile1 @ 0x0;
Subfile2 subfile2 @ 0x8;
// Subfile3 subfile3 @ 0x10;
Subfile4 subfile4 @ 0x18;