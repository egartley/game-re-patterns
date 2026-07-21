struct UnkPart {
    u32 offset;
    ret3 = $;
    $ = ret2 + offset;
    u8 unk[8];
    u32 dataOffset;
    // ind count of 8-byte structs with sequential numbers
    $ = ret3;
};

struct UnkPartsSection {
    ret = $;
    u32 size;
    if (size > 8) {
        ret2 = $;
        u32 count;
        UnkPart parts[count];
    }
    $ = ret + size;
};

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
    padding[292]; // back-filled with 0xFF
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
    padding[8];
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
    if (size > 4) {
        skyStart = $;
        u32 clearColor;
        u32 partCount;
        SkyPartPointer parts[partCount];
        $ = skyStart + size - 4;
    }
};

struct Subfile1 {
    u32 offset;
    u32 size;
    u32 vramStart @ offset;
    u32 vagStart @ offset + vramSize;
};