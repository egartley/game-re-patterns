u64 ret;
u64 ret2;
u64 ret3;
u64 skyStart;

u32 vramSize = 524288;

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

struct SharedSection1SubSection {
    u32 offset;
    ret3 = $;
    $ = ret2 + offset;
    u32 num1;
    u32 num2;
    // ind count of 4-byte structs with sequential numbers
    $ = ret3;
};

struct SharedSection1 {
    ret = $;
    u32 size;
    ret2 = $;
    u32 count;
    SharedSection1SubSection subSections[count];
    $ = ret + size;
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
    u32 midColors[mdlColorCount]; // used between mdl and lod
    MDLPolygon mdlPolys[mdlPolyCount];
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
