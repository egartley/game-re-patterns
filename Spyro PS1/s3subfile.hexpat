#include <subfilecommon>
#include <subfilecommon2>

u32 isFlyoverLevel = 0;

struct Subfile2 {
    u32 offset;
    u32 size;
    $ = offset;
    TextureHeaderSection textureHeaders;
    GroundSection ground;
    UnkSection unkSection3;
    UnkSection unkSection4;
    if (isFlyoverLevel == 0) {
        padding[12];
        CollisionDataSection collisionDataSection;
    }
    SkySection sky;
    if (isFlyoverLevel == 0) {
        UnkSection unkSection9;
        ParticleEffectSection particleEffectSection;
        UnkSection eggSection; // has egg names
        UnkSection unkSection12;
        SoundEffectSection soundEffectSection;
    }
};

struct Subfile4 {
    u32 offset;
    u32 size;
    $ = offset;
    if (isFlyoverLevel == 0) {
        padding[48];
        UnkSection unkSection1;
        UnkSection unkSection2;
        SharedSection1 unkSection3;
        UnkPartsSection unkSection4;
        UnkPartsSection unkSection5;
        UnkPartsSection unkSection6;
        UnkSection unkSection7;
        UnkSection unkSection8;
        UnkSection helpTextSection;
        UnkSection unkSection10;
        UnkSection unkSection11; // possibly texture headers? ind count
        UnkSection unkSection12;
        MobyListSection mobyListSection;
        padding[10240];
        UnkSection dialogueSection;
    }
};

struct SublevelSubfile1 {
    u32 offset;
    u32 size;
    $ = offset;
    if (offset > 0) {
        UnkSection unkSection1;
        padding[384]; // some pointers, other unknown
        GroundSection ground;
        UnkSection unkSection3;
        UnkSection unkSection4;
        UnkSection unkSection5;
        CollisionDataSection collisionDataSection;
    }
};

struct SublevelSubfile2 {
    u32 offset;
    u32 size;
    $ = offset;
    if (offset > 0) {
        padding[48];
        SkySection sky;
        UnkSection unkSection2;
        SharedSection1 unkSection3;
        UnkSection unkSection4;
        UnkSection unkSection5;
        UnkSection unkSection6;
        UnkSection unkSection7;
        UnkSection unkSection8;
        UnkSection unkSection9; // help text
        UnkSection unkSection10;
        UnkSection unkSection11;
        UnkSection unkSection12;
        MobyListSection mobyListSection;
    }
};

struct LevelFile {
    Subfile1 subfile1 @ 0x0;
    Subfile2 subfile2 @ 0x8;
    // Subfile3 subfile3 @ 0x10;
    Subfile4 subfile4 @ 0x18;
    SublevelSubfile1 subfile5 @ 0x20;
    SublevelSubfile2 subfile6 @ 0x28;
    SublevelSubfile1 subfile7 @ 0x30;
    SublevelSubfile2 subfile8 @ 0x38;
    SublevelSubfile1 subfile9 @ 0x40;
    SublevelSubfile2 subfile10 @ 0x48;
};

LevelFile file @ 0x0;
