struct UnkSection {
    u32 size;
    if (size > 4) {
        padding[size - 4];
    }
};

struct SoundEffect {
    u32 offset;
    u8 data[16];
};

struct ParticleEffect {
    u8 data[12]; // something to do with textures, cannot be swapped out
};

struct ParticleEffectSection {
    u32 size;
    u32 count;
    ParticleEffect effects[count];
};

struct MDLPolygon {
    u8 data[16];
};

struct LODPolygon {
    u8 data[8];
};

struct TextureHeader {
    u8 data[8];
};

struct GroundPart {
    padding[8]; // unknown
    s16 y;
    s16 x;
    u16 i0;
    s16 z;
    u8 lodVertexCount;
    u8 lodColorCount;
    u8 lodPolyCount;
    u8 i1;
    u8 mdlVertexCount;
    u8 mdlColorCount;
    u8 mdlPolyCount;
    u8 water;
    u32 flags;
    u32 lodVertices[lodVertexCount];
    u32 lodColors[lodColorCount];
    LODPolygon lodPolys[lodPolyCount];
    u32 mdlVertices[mdlVertexCount];
    u32 mdlColors[mdlColorCount];
    u32 unkColors[mdlColorCount];
    MDLPolygon mdlPolys[mdlPolyCount];
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

struct MobyInstance {
    padding[12]; // unknown
    u32 x;
    u32 y;
    u32 z;
    padding[30]; // unknown
    u8 classId;
    padding[15]; // unknown
    s8 yaw;
    padding[17]; // unknown
};

struct MobyListSection {
    u32 size;
    u32 count;
    MobyInstance instances[count];
};
