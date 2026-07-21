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
        padding[44];
        UnkSection unkSection1;
        UnkSection unkSection2;
        UnkPartsSection unkSection3;
        UnkPartsSection unkSection4;
        UnkPartsSection unkSection5;
        UnkSection unkSection6;
        UnkSection unkSection7;
        UnkSection unkSection8;
        MobyListSection mobyListSection;
        padding[10240];
        UnkSection dialogueSection;
    }
};

struct LevelFile {
    Subfile1 subfile1 @ 0x0;
    Subfile2 subfile2 @ 0x8;
    // Subfile3 subfile3 @ 0x10;
    Subfile4 subfile4 @ 0x18;
};

LevelFile file @ 0x0;
