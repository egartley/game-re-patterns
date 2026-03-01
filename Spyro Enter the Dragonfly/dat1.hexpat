struct Chunk {
    u8 flags[4] [[color("224488")]];
    padding[60];
    u32 data1 [[color("00AAAA")]];
    u32 data2 [[color("00AAAA")]];
    u32 data3 [[color("661108")]];
    u32 data4 [[color("221188")]];
    u32 data5 [[color("006688")]];
    padding[12];
    u32 data6 [[color("888888")]];
};

u32 count @ 0;
Chunk chunks[count] @ 0x04;