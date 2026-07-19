#include <subfilecommon>

u64 ret;
u64 ret2;

u32 vramSize = 524288;
u32 isStandardLevel = 1; // whether the current level is not a cutscene/credits flyover

struct UnkPartsSection {
    ret = $;
    u32 size;
    ret2 = $;
    u32 subSize;
    u32 count;
    u32 offsets[count];
    $ = ret2 + subSize;
    u32 count2;
    u32 offsets2[count2];
    $ = ret + size;
};

struct UnkDataSection {
    u32 count;
    u32 pointers[count]; // can effect portal text in homeworlds and dragon replays
    // sometimes can also be u8 data[16 * count] afterwards
};

struct SoundEffectSection {
    u32 size;
    padding[256]; // unknown
    u32 count;
    SoundEffect sounds[count];
};

struct TextureHeaderSection {
    u32 size;
    u32 count;
    TextureHeader headers[count * 23];
};

struct SkyPart {
    padding[8]; // unknown
    s16 globalY;
    s16 globalZ;
    u16 vertexCount;
    s16 globalX;
    u16 polyCount;
    u16 colorCount;
    padding[4]; // unknown, presumably flags
    u32 vertices[vertexCount];
    u32 colors[colorCount]; // alpha always = 0x30
    u8 polygons[polyCount * 8];
};

struct SkySection {
    u32 size;
    u32 clearColor;
    u32 partCount;
    u32 partOffsets[partCount];
    SkyPart parts[partCount];
};

struct PortalSkySection {
    padding[4];
    u32 structCount;
    padding[24]; // unknown
    padding[12 * structCount]; // unknown 12-byte structures
    padding[20]; // always zero?
    SkySection sky;
};

struct GroundSection {
    u32 size;
    u32 partCount;
    u32 partOffsets[partCount];
    GroundPart parts[partCount];
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
    if (isStandardLevel == 1) {
        UnkPartsSection unkPartsSection;
        UnkSection unkSection4; // can make portals in homeworlds non-enterable
        UnkSection collisionData;
    }
    SkySection sky;
    if (isStandardLevel == 1) {
        u32 portalSkyCount;
        if (portalSkyCount > 0) {
            PortalSkySection portalSkies[portalSkyCount];
        }
        ParticleEffectSection particleEffectSection;
        SoundEffectSection soundEffectSection;
    }
};

struct Subfile3 {
    u32 offset;
    u32 size;
    AnimationPointer animations[64] @ 0x50;
};

struct Subfile4 {
    u32 offset;
    u32 size;
    $ = offset;
    padding[136];
    UnkSection unkSection1;
    UnkSection unkSection2;
    UnkSection unkSection3;
    UnkSection unkSection4;
    UnkSection unkSection5;
    UnkSection unkSection6;
    UnkSection unkSection7;
    MobyListSection mobyListSection;
    padding[10240];
    UnkSection unkSection9;
    UnkSection unkSection10;
    UnkSection unkSection11;
    UnkDataSection unkSection12;
};

Subfile1 subfile1 @ 0x0;
Subfile2 subfile2 @ 0x8;
Subfile3 subfile3 @ 0x10;
Subfile4 subfile4 @ 0x18;