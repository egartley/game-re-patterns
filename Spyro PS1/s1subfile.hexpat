#include <subfilecommon>

u32 isStandardLevel = 1; // whether the current level is not a cutscene/credits flyover

struct UnkPartsSection {
    // ground "regions"? affects how ground parts are loaded or not based on position
    // has two sub-sections
    ret = $;
    u32 size;
    ret2 = $;
    u32 subSize;
    u32 count; // might affect mdl parts? this section is bigger than the second one
    u32 offsets[count];
    $ = ret2 + subSize;
    u32 count2; // might affect lod parts? always same as count
    u32 offsets2[count2];
    $ = ret + size;
};

struct UnkDataSection {
    u32 count;
    u32 pointers[count]; // can affect portal text in homeworlds and dragon replays
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

bitfield FrameBits {
    unsigned vertexOffset: 21 [[color("FFFFFF")]];
    unsigned collisionModelIndex: 3 [[color("FFFFFF")]];
    unsigned frameSound: 8 [[color("FFFFFF")]];
};

struct Frame {
    FrameBits bits;
    u16 vertexColorOffset [[color("888888")]];
    u8 shadow [[color("555555")]];
    u8 shortOffset [[color("222222")]];
};

struct Animation {
    u16 frameCount [[color("FF0000")]];
    u16 colorCount [[color("FF1111")]];
    u8 isSpyroAnimation [[color("FF2222")]];
    u8 scale [[color("FF3333")]];
    u8 shortEncodeShift [[color("FF4444")]];
    u8 radius [[color("FF5555")]];
    u8 vertexCount [[color("FF6666")]];
    u8 lowVertexCount [[color("FF7777")]];
    padding[1];
    u8 depthScale [[color("FF8888")]];
    u8 progressPerTick [[color("FF9999")]];
    padding[3];
    u32 animationVerticesOffset [[color("FF9999")]]; // ignored unless isSpyroAnimation is 1
    u32 facesOffset [[color("FF9999")]];
    u32 colorsOffset [[color("FF9999")]];
    u32 lowFacesOffset [[color("FF9999")]];
    u32 lowColorsOffset [[color("FF9999")]];
    Frame frames[frameCount];
};

struct MobyAnimationPack {
    u32 count [[color("DD1199")]];
    padding[48];
    u32 dataOffset [[color("FF55DD")]];
    if (dataOffset < 100000) {
        u32 animationOffsets[count] [[color("0000FF")]];
        Animation animations[count];
        u32 dataSize;
        u8 facesData[dataSize];
        u32 lowDataSize;
        u8 lowFacesData[lowDataSize];
        u8 colors[animations[0].colorCount * 4];
        u8 lowColors[animations[0].colorCount * 4];
        // remaining data is supposed vertex data
    } else {
        // unknown format when number at data offset is huge
    }
};

struct AnimationPointer {
    u32 offset;
    if (offset > 0) {
        MobyAnimationPack pack @ offset;
    }
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
    if (isStandardLevel == 1) {
        padding[136];
        UnkSection unkSection1;
        SharedSection1 unkSection2;
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
    }
};

Subfile1 subfile1 @ 0x0;
Subfile2 subfile2 @ 0x8;
Subfile3 subfile3 @ 0x10;
Subfile4 subfile4 @ 0x18;