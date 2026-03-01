#include <std/mem.pat>
#include <std/string.pat>

#define CLR_HEADER   "FF5555" // Red
#define CLR_HASH     "55FF55" // Green
#define CLR_STRLEN   "FF55FF" // Pink
#define CLR_STRING   "FFFF55" // Yellow
#define CLR_DATA     "000000" // Gray
#define CLR_COUNT    "223399" // Blue
#define CLR_SUBDATA  "883399" // Purple
#define CLR_SUBDATA2 "669955" // Green 2
#define CLR_LINK     "FF9900" // Orange
#define CLR_LINK2    "55FFFF" // Cyan
#define CLR_FLAGS    "999999" // Gray

u32 remaining_nodes;

enum NodeType : u32 {
    Texture         = 3671558448,
    Material        = 3899959227,
    ObjectShape     = 2724436415,
    Object          = 1142910985,
    GeneralAttributes       = 38888829,
    AnimatedObject          = 2140961626,
    Property        = 761170991,
    TextureGroup      = 1203390189,
    Unknown1        = 67242671,
    Animation            = 131162624,
    Shape2          = 4213557647,
    SpecularEnv     = 3160929782,
    Emitter        = 2485864778,
    ParticleShape   = 2499941824,
    Property2        = 3774573822,
    Property3        = 2438865836,
    Shape4          = 1028427169,
    ClusterMesh     = 1418262912,
    Cluster         = 2337873906,
    Shape3          = 3053583857,
    BlendShape           = 624797560,
    Shape5          = 4048945320,
    CollisionMesh       = 3808459748,
    CollisionBSP = 3206376836,
    Field = 2730149095,
    Material2 = 751923549
};

fn get_chunk_name(u32 id) {
    match (id) {
        (NodeType::Texture):       return "Texture";
        (NodeType::Material):      return "Material";
        (NodeType::ObjectShape):   return "ObjectShape";
        (NodeType::Object):        return "Object";
        (NodeType::GeneralAttributes):     return "GeneralAttributes";
        (NodeType::AnimatedObject):        return "AnimatedObject";
        (NodeType::Property):      return "Property";
        (NodeType::TextureGroup):    return "TextureGroup";
        (NodeType::Unknown1):      return "Unknown1";
        (NodeType::SpecularEnv):   return "SpecularEnv";
        (NodeType::Animation):          return "Animation";
        (NodeType::BlendShape):         return "BlendShape";
        (NodeType::Shape2):        return "Shape2";
        (NodeType::Emitter):      return "Emitter";
        (NodeType::ParticleShape): return "ParticleShape";
        (NodeType::Property2):      return "Property2";
        (NodeType::Property3):      return "Property3";
        (NodeType::Shape4):        return "Shape4";
        (NodeType::ClusterMesh):   return "ClusterMesh";
        (NodeType::Cluster):       return "Cluster";
        (NodeType::Shape3):        return "Shape3";
        (NodeType::Shape5):     return "Shape5";
        (NodeType::CollisionMesh): return "CollisionMesh";
        (NodeType::CollisionBSP): return "CollisionBSP";
        (NodeType::Field): return "Field";
        (NodeType::Material2): return "Material2";
        (_):                        return "Unknown ID";
    }
};

fn pad_right(str s, auto padLength) {
    auto size = std::string::length(s);
    if (size >= padLength) {
        return s;
    } else {
        str sr = s;
        for (auto i = 0, i < padLength - size, i += 1) {
            sr += " ";
        }
        return sr;
    }
};

fn prop_end() {
    u8 x @ $ - 1;       // 0
    u8 a @ $;   // 2 or 0
    u8 b @ $ + 1;   // 0
    u8 c @ $ + 2;   // 0
    u8 d @ $ + 3;   // 0
    u8 e @ $ + 4;   // 2 or 0
    u8 f @ $ + 5;   // 0
    u8 g @ $ + 6;   // 0
    u8 h @ $ + 7;   // 0
    u8 i @ $ + 8;   // 1
    return (a == 2) && b == 0 && c == 0 && d == 0 && (e == 2 || e == 0) && f == 0 && g == 0 && h == 0 && i == 1;
};

struct AlignedString {
    u32 len [[color(CLR_STRLEN)]];
    char text[len] [[color(CLR_STRING)]];
};

struct Vertex {
    float x [[color(CLR_SUBDATA)]];
    float y [[color(CLR_SUBDATA2)]];
    float z [[color(CLR_STRING)]];
};

struct Attribute {
    u32 data [[color(CLR_SUBDATA)]];
    u32 data2 [[color(CLR_SUBDATA2)]];
};

struct Attribute2 {
    u32 data [[color(CLR_SUBDATA)]];
    u32 data2 [[color(CLR_SUBDATA2)]];
    u32 data3 [[color(CLR_SUBDATA)]];
    u32 data4 [[color(CLR_SUBDATA2)]];
    u32 data5 [[color(CLR_SUBDATA)]];
    u32 data6 [[color(CLR_SUBDATA2)]];
    u32 data7 [[color(CLR_SUBDATA)]];
    u32 data8 [[color(CLR_SUBDATA2)]];
};

struct GeneralAttributes {
    u8 data[9] [[color(CLR_DATA)]];
    u32 count [[color(CLR_COUNT)]];
    Attribute attributes[count];
    u32 count2 [[color(CLR_COUNT)]];
    if (count2 > 0) {
        Attribute2 attributes2[count2];
    }
    padding[4];
};

struct ObjectData {
    u32 header[11] [[color(CLR_FLAGS)]];
    u32 unknown [[color(CLR_DATA)]];
    Vertex point;
    
    Vertex point2;
    
    Vertex point3;
    u8 data[38] [[color(CLR_DATA)]];
    Vertex point4;
    Vertex point5;
    Vertex point6;
    Vertex point7;
    padding[12];
};

struct ObjectShapeData {
    Vertex points[3];
    float data [[color(CLR_DATA)]];
    u8 data2[32] [[color(CLR_DATA)]];
    u32 count [[color(CLR_COUNT)]];
    u32 geoOffset [[color(CLR_LINK)]];
    u16 data3 [[color(CLR_DATA)]];
    u16 geoChunkCount [[color(CLR_COUNT)]];
    u32 TextureGroupId [[color(CLR_LINK)]];
    if (count > 1) {
        u32 data4[count] [[color(CLR_DATA)]];
    }
}; 

struct MaterialData {
    u32 header[11] [[color(CLR_FLAGS)]];
    u32 data [[color(CLR_DATA)]];
    Vertex points[3];
    u8 data2[26] [[color(CLR_DATA)]];
};

struct TextureData {
    u8 data[63] [[color(CLR_DATA)]];
    AlignedString name2;
    u16 width [[color(CLR_SUBDATA)]];
    u16 height [[color(CLR_SUBDATA)]];
    u8 data2[93] [[color(CLR_DATA)]];
};

struct PropertySubData {
    float data [[color(CLR_SUBDATA)]];
    float data2 [[color(CLR_SUBDATA2)]];
    float data3 [[color(CLR_SUBDATA)]];
    float data4 [[color(CLR_SUBDATA2)]];
};

struct PropertyData {
    u16 data [[color(CLR_DATA)]];
    u16 check [[color(CLR_COUNT)]];
    if (data == 2 && check == 0) {
        PropertySubData subData[data];
    } else if (data == 5 && check == 0) {
        u32 subData[20] [[color(CLR_SUBDATA)]];
    } else if (check == 2 || check == 3 || (data == 1 && check == 1)) {
        u32 subData [[color(CLR_SUBDATA)]];
    } else if (data > 20) {
        PropertySubData subData[data];
    } else {
        u8 subData[while(!prop_end())] [[color(CLR_SUBDATA)]];
    }
    u8 end[9] [[color(CLR_SUBDATA)]];
};

struct AnimatedObjectData {
    u32 count [[color(CLR_COUNT)]];
    u32 count2 [[color(CLR_COUNT)]];
    u32 animationId [[color(CLR_LINK)]];
    if (count > 1) {
        if (count == 6) {
            u8 data2[38] [[color(CLR_DATA)]];
        } else if (count == 7) {
            u8 data2[45] [[color(CLR_DATA)]];
        } else if (count == 2) {
            u8 data2[10] [[color(CLR_DATA)]];
        } else {
            u8 data2[9] [[color(CLR_DATA)]];
        }
    } else {
        u8 data2[3] [[color(CLR_DATA)]];
    }
    u32 data3[count2] [[color(CLR_SUBDATA)]];
    u32 data4[count2] [[color(CLR_SUBDATA2)]];
    u32 data5[count2] [[color(CLR_SUBDATA)]];
};

struct AnimationData {
    u16 frameCount [[color(CLR_COUNT)]];
    u16 data2 [[color(CLR_DATA)]];
    u32 data3[frameCount] [[color(CLR_SUBDATA)]];
    u32 data4[frameCount] [[color(CLR_SUBDATA2)]];
    padding[4];
    u32 common [[color(CLR_LINK)]];
    u8 data5[9] [[color(CLR_DATA)]];
};

struct TextureRef {
    u8 data[4] [[color(CLR_SUBDATA)]];
    u32 textureId [[color(CLR_LINK)]];
    u8 data2[122] [[color(CLR_SUBDATA)]];
};

struct TextureGroupData {
    u8 data[88] [[color(CLR_DATA)]];
    u32 textureCount [[color(CLR_COUNT)]];
    TextureRef textureRefs[textureCount] [[color(CLR_SUBDATA)]];
    u32 textureId [[color(CLR_LINK)]];
    u8 end[6] [[color(CLR_DATA)]];
};

struct Unknown1Data {
    u32 header[11] [[color(CLR_FLAGS)]];
    u8 data[68] [[color(CLR_DATA)]];
};

struct Shape2Data {
    u8 data[80] [[color(CLR_DATA)]];
    u32 geoOffset [[color(CLR_LINK)]];
    u16 data2 [[color(CLR_DATA)]];
    u16 geoChunkCount [[color(CLR_COUNT)]];
    u32 textureGroupId [[color(CLR_LINK)]];
};

struct SpecularEnvSubData {
    u32 data [[color(CLR_SUBDATA)]];
    u32 data2 [[color(CLR_SUBDATA2)]];
};

struct SpecularEnvData {
    u32 header[11] [[color(CLR_FLAGS)]];
    u8 data[66] [[color(CLR_DATA)]];
    u32 count [[color(CLR_COUNT)]];
    SpecularEnvSubData subData[count];
    u8 end [[color(CLR_DATA)]];
};

struct BlendShapeData {
    u32 shape2Id [[color(CLR_LINK)]];
    u8 data[6] [[color(CLR_DATA)]];
    u32 count [[color(CLR_COUNT)]];
    u32 subData[count] [[color(CLR_SUBDATA)]];
};

struct EmitterData {
    u8 data[182] [[color(CLR_DATA)]];
};

struct ParticleShapeSubData {
    u8 data[48] [[color(CLR_SUBDATA)]];
};

struct ParticleShapeData {
    u8 data[136] [[color(CLR_DATA)]];
    u32 count [[color(CLR_COUNT)]];
    if (count > 0) {
        ParticleShapeSubData subData[count];
    } else {
        u32 data3 [[color(CLR_DATA)]];
    }
    u8 data2[90] [[color(CLR_DATA)]];
};

struct Property2SubData {
    float data [[color(CLR_SUBDATA)]];
    float data2 [[color(CLR_SUBDATA2)]];
};

struct Property2Data {
    u32 data [[color(CLR_DATA)]];
    u32 count [[color(CLR_COUNT)]];
    Property2SubData subData[count];
};

struct Property3SubData {
    float data [[color(CLR_SUBDATA)]];
    float data2 [[color(CLR_SUBDATA2)]];
    float data3 [[color(CLR_SUBDATA2)]];
    float data4 [[color(CLR_SUBDATA2)]];
};

struct Property3Data {
    u32 data [[color(CLR_DATA)]];
    u32 count [[color(CLR_COUNT)]];
    Property3SubData subData[count];
};

struct Shape4Data {
    u32 header[11] [[color(CLR_FLAGS)]];
    u8 data[126] [[color(CLR_DATA)]];
};

struct ClusterMeshData {
    Vertex points[3];
    float number [[color(CLR_DATA)]];
    u32 data[9] [[color(CLR_DATA)]];
    u32 geoOffset [[color(CLR_LINK)]];
    u16 data2 [[color(CLR_DATA)]];
    u16 geoChunkCount [[color(CLR_COUNT)]];
    u32 textureGroupId [[color(CLR_LINK)]];
};

struct ClusterVertexData {
    padding[48];
    Vertex vertex;
    padding[4];
};

struct ClusterData {
    u32 meshId [[color(CLR_LINK)]];
    u8 data[6] [[color(CLR_DATA)]];
    u32 vertexCount [[color(CLR_COUNT)]];
    ClusterVertexData vertices[vertexCount];
    padding[64];
    u32 data2[vertexCount] [[color(CLR_SUBDATA2)]];
};

struct Shape3Data {
    u8 data[88] [[color(CLR_DATA)]];
};

struct Shape5Data {
    u32 header[11] [[color(CLR_FLAGS)]];
    u8 data[20] [[color(CLR_DATA)]];
    float x [[color(CLR_SUBDATA)]];
    float y [[color(CLR_SUBDATA)]];
    float z [[color(CLR_SUBDATA)]];
    u8 data2[76] [[color(CLR_DATA)]];
};

struct CollisionMeshSubData2 {
    float a [[color(CLR_STRING)]];
    float b [[color(CLR_SUBDATA)]];
    float c [[color(CLR_SUBDATA2)]];
};

struct CollisionMeshIndices {
    u16 i1 [[color(CLR_STRING)]];
    u16 i2 [[color(CLR_SUBDATA)]];
    u16 i3 [[color(CLR_SUBDATA2)]];
};

struct CollisionMeshData {
    padding[49];
    u32 vertexCount [[color(CLR_COUNT)]];
    u32 faceCount [[color(CLR_COUNT)]];
    Vertex vertices[vertexCount];
    CollisionMeshSubData2 subData[faceCount];
    CollisionMeshIndices indices[faceCount];
};

struct CollisionBSPData {
    Vertex boundMin;
    Vertex boundMax;
    Vertex origin;
    padding[8];
};

struct FieldData {
    u32 header[11] [[color(CLR_FLAGS)]];
    u8 data[134] [[color(CLR_DATA)]];
};

struct Material2Data {
    u32 header[11] [[color(CLR_FLAGS)]];
    u8 data[94] [[color(CLR_DATA)]];
};

struct Node {
    u32 typeId [[color(CLR_HEADER), name(get_chunk_name(this))]];
    if (typeId == 0) {
        continue;
    }
    u32 instanceId [[color(CLR_HASH)]];
    AlignedString name;
    u8 unknown[4] [[color(CLR_LINK2)]];
    u32 common [[color(CLR_LINK2)]];

    match (typeId) {
        (NodeType::Texture):       TextureData data;
        (NodeType::Material):      MaterialData data;
        (NodeType::ObjectShape):   ObjectShapeData data;
        (NodeType::Object):        ObjectData data;
        (NodeType::GeneralAttributes):     GeneralAttributes data;
        (NodeType::AnimatedObject):        AnimatedObjectData data;
        (NodeType::Property):      PropertyData data;
        (NodeType::TextureGroup):  TextureGroupData data;
        (NodeType::SpecularEnv):   SpecularEnvData data;
        (NodeType::Animation):     AnimationData data;
        (NodeType::BlendShape):         BlendShapeData data;
        (NodeType::Unknown1):      Unknown1Data data;
        (NodeType::Shape2):        Shape2Data data;
        (NodeType::Emitter):      EmitterData data;
        (NodeType::ParticleShape): ParticleShapeData data;
        (NodeType::Property2):      Property2Data data;
        (NodeType::Property3):      Property3Data data;
        (NodeType::Shape4):        Shape4Data data;
        (NodeType::ClusterMesh):  ClusterMeshData data;
        (NodeType::Cluster):       ClusterData data;
        (NodeType::Shape3):        Shape3Data data;
        (NodeType::Shape5):        Shape5Data data;
        (NodeType::CollisionMesh): CollisionMeshData data;
        (NodeType::CollisionBSP):      CollisionBSPData data;
        (NodeType::Field): FieldData data;
        (NodeType::Material2): Material2Data data;
    }

    remaining_nodes -= 1;
} [[name(pad_right(get_chunk_name(typeId), 18) + pad_right(std::string::to_string(instanceId), 16) + name.text)]];

struct MRBFile {
    u32 check [[color(CLR_STRLEN)]];
    if (check > 0) {
        char name[check] [[color(CLR_STRING)]];
    }
    u32 count [[color(CLR_COUNT)]];
    remaining_nodes = count;
    Node nodes[while(remaining_nodes > 0 && !std::mem::eof())];
};

MRBFile files[while(!std::mem::eof())] @ 0x0;
