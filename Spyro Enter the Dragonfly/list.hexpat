struct Entry {
    u32 hash [[color("FF00000")]];;
    u32 offset [[color("00FF00")]];;
    u32 size[[color("0000FF")]];;
    u32 unknown [[color("FFFFFF")]];;
};

struct FileList {
    padding[12];
    u32 count [[color("000000")]];;
    Entry entries[count];
};

FileList list @ 0;