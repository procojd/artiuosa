class PrismacolorPencil {
 late String name;
  final String code;
  late  String hex;
  late  List<int> rgb;

  PrismacolorPencil({
    required this.name,
    required this.code,
    required this.hex,
    required this.rgb,
  });

  factory PrismacolorPencil.fromJson(Map<String, dynamic> json) {
    return PrismacolorPencil(
      name: json['name'],
      code: json['code'],
      hex: json['hex'],
      rgb: List<int>.from(json['rgb']),
    );
  }
  

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'code': code,
      'hex': hex,
      'rgb': rgb,
    };
  }

    Map<String, dynamic> toMap() {
    return {
      'name': name,
      'code': code,
      'hex': hex,
      'rgb': rgb,
    };
  }

  // Create a PrismacolorPencil object from a Map
  factory PrismacolorPencil.fromMap(Map<String, dynamic> map) {
    return PrismacolorPencil(
      name: map['name'],
      code: map['code'],
      hex: map['hex'],
      rgb: List<int>.from(map['rgb']),
    );
  }
}

final List<PrismacolorPencil> prismacolorPencils = [
  PrismacolorPencil(name: "Apple Green", code: "PC 912", hex: "#4DAD44", rgb: [77, 173, 68]),
  PrismacolorPencil(name: "Aquamarine", code: "PC 905", hex: "#008C9E", rgb: [0, 140, 158]),
  PrismacolorPencil(name: "Artichoke", code: "PC 1098", hex: "#7F7315", rgb: [127, 115, 21]),
  PrismacolorPencil(name: "Beige", code: "PC 997", hex: "#FADDB2", rgb: [250, 221, 178]),
  PrismacolorPencil(name: "Beige Sienna", code: "PC 1080", hex: "#DDA492", rgb: [221, 164, 146]),
  PrismacolorPencil(name: "Black", code: "PC 935", hex: "#000000", rgb: [0, 0, 0]),
  PrismacolorPencil(name: "Black Cherry", code: "PC 1078", hex: "#520040", rgb: [82, 0, 64]),
  PrismacolorPencil(name: "Black Grape", code: "PC 996", hex: "#320341", rgb: [50, 3, 65]),
  PrismacolorPencil(name: "Black Raspberry", code: "PC 1095", hex: "#3B0A12", rgb: [59, 10, 18]),
  PrismacolorPencil(name: "Blue Lake", code: "PC 1102", hex: "#568BD2", rgb: [86, 139, 210]),
  PrismacolorPencil(name: "Blue Slate", code: "PC 1024", hex: "#94B2D6", rgb: [148, 178, 214]),
  PrismacolorPencil(name: "Blue Violet Lake", code: "PC 1079", hex: "#4575BF", rgb: [69, 117, 191]),
  PrismacolorPencil(name: "Blush Pink", code: "PC 928", hex: "#FFBCB8", rgb: [255, 188, 184]),
  PrismacolorPencil(name: "Bronze", code: "PC 1028", hex: "#A17315", rgb: [161, 115, 21]),
  PrismacolorPencil(name: "Burnt Ochre", code: "PC 943", hex: "#9F5215", rgb: [159, 82, 21]),
  PrismacolorPencil(name: "Cadmium Orange Hue", code: "PC 118", hex: "#E9773D", rgb: [233, 119, 61]),
  PrismacolorPencil(name: "Canary Yellow", code: "PC 916", hex: "#FFFF6A", rgb: [255, 255, 106]),
  PrismacolorPencil(name: "Caribbean Sea", code: "PC 1103", hex: "#8BBBE0", rgb: [139, 187, 224]),
  PrismacolorPencil(name: "Carmine Red", code: "PC 926", hex: "#DB3129", rgb: [219, 49, 41]),
  PrismacolorPencil(name: "Celadon Green", code: "PC 1020", hex: "#ACBD9D", rgb: [172, 189, 157]),
  PrismacolorPencil(name: "Cerulean Blue", code: "PC 103", hex: "#005895", rgb: [0, 88, 149]),
  PrismacolorPencil(name: "Chartreuse", code: "PC 989", hex: "#C7D35C", rgb: [199, 211, 92]),
  PrismacolorPencil(name: "Chestnut", code: "PC 1081", hex: "#672F17", rgb: [103, 47, 23]),
  PrismacolorPencil(name: "China Blue", code: "PC 1100", hex: "#315AC7", rgb: [49, 90, 199]),
  PrismacolorPencil(name: "Chocolate", code: "PC 1082", hex: "#481B0F", rgb: [72, 27, 15]),
  PrismacolorPencil(name: "Clay Rose", code: "PC 1017", hex: "#C2A9AE", rgb: [194, 169, 174]),
  PrismacolorPencil(name: "Cloud Blue", code: "PC 1023", hex: "#C7DDEA", rgb: [199, 221, 234]),
  PrismacolorPencil(name: "Cobalt Blue Hue", code: "PC 133", hex: "#32358B", rgb: [50, 53, 139]),
  PrismacolorPencil(name: "Cobalt Turquoise", code: "PC 105", hex: "#006769", rgb: [0, 103, 105]),
  PrismacolorPencil(name: "Copenhagen Blue", code: "PC 906", hex: "#005B8E", rgb: [0, 91, 142]),
  PrismacolorPencil(name: "Cream", code: "PC 914", hex: "#FFF4C8", rgb: [255, 244, 200]),
  PrismacolorPencil(name: "Crimson Lake", code: "PC 925", hex: "#880503", rgb: [136, 5, 3]),
  PrismacolorPencil(name: "Crimson Red", code: "PC 924", hex: "#B42830", rgb: [180, 40, 48]),
  PrismacolorPencil(name: "Dahlia Purple", code: "PC 1009", hex: "#8D007B", rgb: [141, 0, 123]),
  PrismacolorPencil(name: "Dark Brown", code: "PC 946", hex: "#431F16", rgb: [67, 31, 22]),
  PrismacolorPencil(name: "Dark Green", code: "PC 908", hex: "#00512D", rgb: [0, 81, 45]),
  PrismacolorPencil(name: "Dark Purple", code: "PC 931", hex: "#652B84", rgb: [101, 43, 132]),
  PrismacolorPencil(name: "Dark Umber", code: "PC 947", hex: "#422B20", rgb: [66, 43, 32]),
  PrismacolorPencil(name: "Deco Peach", code: "PC 1013", hex: "#FEE3E4", rgb: [254, 227, 228]),
  PrismacolorPencil(name: "Deco Pink", code: "PC 1014", hex: "#FFD5E3", rgb: [255, 213, 227]),
  PrismacolorPencil(name: "Deco Yellow", code: "PC 1011", hex: "#FFF1AB", rgb: [255, 241, 171]),
  PrismacolorPencil(name: "Denim Blue", code: "PC 1101", hex: "#004993", rgb: [0, 73, 147]),
  PrismacolorPencil(name: "Dioxazine Purple Hue", code: "PC 132", hex: "#2B1A68", rgb: [43, 26, 104]),
  PrismacolorPencil(name: "Eggshell", code: "PC 140", hex: "#FFEAC6", rgb: [255, 234, 198]),
  PrismacolorPencil(name: "Electric Blue", code: "PC 1040", hex: "#008ACF", rgb: [0, 138, 207]),
  PrismacolorPencil(name: "Espresso", code: "PC 1099", hex: "#533D2E", rgb: [83, 61, 46]),
  PrismacolorPencil(name: "Ginger Root", code: "PC 1084", hex: "#E7CEB1", rgb: [231, 206, 177]),
  PrismacolorPencil(name: "Goldenrod", code: "PC 1034", hex: "#FFB92B", rgb: [255, 185, 43]),
  PrismacolorPencil(name: "Grass Green", code: "PC 909", hex: "#4CAF50", rgb: [76, 175, 80]),
  PrismacolorPencil(name: "Grayed Lavender", code: "PC 1026", hex: "#AC96A4", rgb: [172, 150, 164]),
  PrismacolorPencil(name: "Green Ochre", code: "PC 1091", hex: "#A68E5A", rgb: [166, 142, 90]),
  PrismacolorPencil(name: "Greyed Lavender", code: "PC 1026", hex: "#B7A2B1", rgb: [183, 162, 177]),
  PrismacolorPencil(name: "Henna", code: "PC 1031", hex: "#6A2722", rgb: [106, 39, 34]),
  PrismacolorPencil(name: "Indigo Blue", code: "PC 901", hex: "#242664", rgb: [36, 38, 100]),
  PrismacolorPencil(name: "Jade Green", code: "PC 1021", hex: "#6AB68A", rgb: [106, 182, 138]),
  PrismacolorPencil(name: "Jasmine", code: "PC 1012", hex: "#FFEBAD", rgb: [255, 235, 173]),
  PrismacolorPencil(name: "Kelp Green", code: "PC 1090", hex: "#415D18", rgb: [65, 93, 24]),
  PrismacolorPencil(name: "Lavender", code: "PC 934", hex: "#B5A8C7", rgb: [181, 168, 199]),
  PrismacolorPencil(name: "Lemon Yellow", code: "PC 915", hex: "#FFF44A", rgb: [255, 244, 74]),
  PrismacolorPencil(name: "Light Aqua", code: "PC 992", hex: "#90D4E8", rgb: [144, 212, 232]),
  PrismacolorPencil(name: "Light Cerulean Blue", code: "PC 904", hex: "#A9E5FC", rgb: [169, 229, 252]),
  PrismacolorPencil(name: "Light Green", code: "PC 920", hex: "#9ED59A", rgb: [158, 213, 154]),
  PrismacolorPencil(name: "Light Peach", code: "PC 927", hex: "#FFD7C7", rgb: [255, 215, 199]),
  PrismacolorPencil(name: "Light Umber", code: "PC 941", hex: "#AD6E41", rgb: [173, 110, 65]),
  PrismacolorPencil(name: "Lilac", code: "PC 956", hex: "#D3BBE2", rgb: [211, 187, 226]),
  PrismacolorPencil(name: "Limepeel", code: "PC 1005", hex: "#929D3E", rgb: [146, 157, 62]),
  PrismacolorPencil(name: "Magenta", code: "PC 930", hex: "#B2006A", rgb: [178, 0, 106]),
  PrismacolorPencil(name: "Marine Green", code: "PC 988", hex: "#1E5A46", rgb: [30, 90, 70]),
  PrismacolorPencil(name: "Mauve", code: "PC 1049", hex: "#D3B8B6", rgb: [211, 184, 182]),
  PrismacolorPencil(name: "Mediterranean Blue", code: "PC 1022", hex: "#0072A9", rgb: [0, 114, 169]),
  PrismacolorPencil(name: "Mineral Orange", code: "PC 1033", hex: "#F6791A", rgb: [246, 121, 26]),
  PrismacolorPencil(name: "Mulberry", code: "PC 995", hex: "#60023A", rgb: [96, 2, 58]),
  PrismacolorPencil(name: "Muted Turquoise", code: "PC 1088", hex: "#0C8B8F", rgb: [12, 139, 143]),
  PrismacolorPencil(name: "Non-Photo Blue", code: "PC 919", hex: "#84D2D8", rgb: [132, 210, 216]),
  PrismacolorPencil(name: "Olive Green", code: "PC 911", hex: "#607A3C", rgb: [96, 122, 60]),
  PrismacolorPencil(name: "Orange", code: "PC 918", hex: "#FF6F1F", rgb: [255, 111, 31]),
  PrismacolorPencil(name: "Orange Ochre", code: "PC 1037", hex: "#B3541E", rgb: [179, 84, 30]),
  PrismacolorPencil(name: "Palett Viridian", code: "PC 1109", hex: "#01857F", rgb: [1, 133, 127]),
  PrismacolorPencil(name: "Pale Vermilion", code: "PC 921", hex: "#EB7351", rgb: [235, 115, 81]),
  PrismacolorPencil(name: "Pale Yellow", code: "PC 1018", hex: "#FFF2B2", rgb: [255, 242, 178]),
  PrismacolorPencil(name: "Parma Violet", code: "PC 1008", hex: "#AE82E6", rgb: [174, 130, 230]),
  PrismacolorPencil(name: "Peacock Blue", code: "PC 1027", hex: "#2A64A1", rgb: [42, 100, 161]),
  PrismacolorPencil(name: "Peach", code: "PC 939", hex: "#FFC4B2", rgb: [255, 196, 178]),
  PrismacolorPencil(name: "Peacock Green", code: "PC 909", hex: "#00A64A", rgb: [0, 166, 74]),
  PrismacolorPencil(name: "Pewter Grey", code: "PC 1028", hex: "#A5A49F", rgb: [165, 164, 159]),
  PrismacolorPencil(name: "Pink", code: "PC 929", hex: "#FF9FCC", rgb: [255, 159, 204]),
  PrismacolorPencil(name: "Pink Rose", code: "PC 1018", hex: "#FFC0CB", rgb: [255, 192, 203]),
  PrismacolorPencil(name: "Pompeian Red", code: "PC 922", hex: "#7E2430", rgb: [126, 36, 48]),
  PrismacolorPencil(name: "Process Red", code: "PC 994", hex: "#FF5685", rgb: [255, 86, 133]),
  PrismacolorPencil(name: "Pumpkin Orange", code: "PC 1032", hex: "#FF7722", rgb: [255, 119, 34]),
  PrismacolorPencil(name: "Raspberry", code: "PC 1030", hex: "#B00053", rgb: [176, 0, 83]),
  PrismacolorPencil(name: "Raw Umber", code: "PC 942", hex: "#54301A", rgb: [84, 48, 26]),
  PrismacolorPencil(name: "Red", code: "PC 924", hex: "#FF2A2A", rgb: [255, 42, 42]),
  PrismacolorPencil(name: "Red Violet", code: "PC 922", hex: "#7A2F8E", rgb: [122, 47, 142]),
  PrismacolorPencil(name: "Rosy Beige", code: "PC 1019", hex: "#F7C6D2", rgb: [247, 198, 210]),
  PrismacolorPencil(name: "Royal Blue", code: "PC 901", hex: "#0E4984", rgb: [14, 73, 132]),
  PrismacolorPencil(name: "Salmon Pink", code: "PC 1003", hex: "#FFAD8A", rgb: [255, 173, 138]),
  PrismacolorPencil(name: "Sand", code: "PC 940", hex: "#E9CF94", rgb: [233, 207, 148]),
  PrismacolorPencil(name: "Sienna Brown", code: "PC 945", hex: "#6C4C2F", rgb: [108, 76, 47]),
  PrismacolorPencil(name: "Silver", code: "PC 949", hex: "#C0C0C0", rgb: [192, 192, 192]),
    PrismacolorPencil(name: "Sky Blue Light", code: "PC 1086", hex: "#94D9E5", rgb: [148, 217, 229]),
  PrismacolorPencil(name: "Slate Grey", code: "PC 936", hex: "#7E8387", rgb: [126, 131, 135]),
  PrismacolorPencil(name: "Spring Green", code: "PC 913", hex: "#A1CD52", rgb: [161, 205, 82]),
  PrismacolorPencil(name: "Sunburst Yellow", code: "PC 917", hex: "#FFC82A", rgb: [255, 200, 42]),
  PrismacolorPencil(name: "Terra Cotta", code: "PC 944", hex: "#C66B40", rgb: [198, 107, 64]),
  PrismacolorPencil(name: "True Blue", code: "PC 903", hex: "#0074A2", rgb: [0, 116, 162]),
  PrismacolorPencil(name: "True Green", code: "PC 910", hex: "#008E48", rgb: [0, 142, 72]),
  PrismacolorPencil(name: "Tuscan Red", code: "PC 937", hex: "#66413A", rgb: [102, 65, 58]),
  PrismacolorPencil(name: "Ultramarine", code: "PC 902", hex: "#1E497A", rgb: [30, 73, 122]),
  PrismacolorPencil(name: "Vermilion", code: "PC 921", hex: "#F34338", rgb: [243, 67, 56]),
  PrismacolorPencil(name: "Violet", code: "PC 932", hex: "#402282", rgb: [64, 34, 130]),
  PrismacolorPencil(name: "Warm Grey 10%", code: "PC 1050", hex: "#EDE4D7", rgb: [237, 228, 215]),
  PrismacolorPencil(name: "Warm Grey 20%", code: "PC 1051", hex: "#D8CEC4", rgb: [216, 206, 196]),
  PrismacolorPencil(name: "Warm Grey 30%", code: "PC 1052", hex: "#C4B4A3", rgb: [196, 180, 163]),
  PrismacolorPencil(name: "Warm Grey 50%", code: "PC 1054", hex: "#9D8D7B", rgb: [157, 141, 123]),
  PrismacolorPencil(name: "Warm Grey 70%", code: "PC 1056", hex: "#7B6A5A", rgb: [123, 106, 90]),
  PrismacolorPencil(name: "Warm Grey 90%", code: "PC 1058", hex: "#564B42", rgb: [86, 75, 66]),
  PrismacolorPencil(name: "White", code: "PC 938", hex: "#FFFFFF", rgb: [255, 255, 255]),
  PrismacolorPencil(name: "Yellowed Orange", code: "PC 1002", hex: "#FFB347", rgb: [255, 179, 71]),
];
