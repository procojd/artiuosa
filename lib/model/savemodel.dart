import 'package:artiuosa/model/colormode.dart';

class cm {
  final String name;
  final String hex;
  final List<PrismacolorPencil> pencils;

  cm({
    required this.name,
    required this.hex,
    required this.pencils,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'hex': hex,
      'pencils': pencils.map((pencil) => pencil.toMap()).toList(),
    };
  }

  factory cm.fromMap(Map<String, dynamic> map) {
    return cm(
      name: map['name'],
      hex: map['hex'],
      pencils: List<PrismacolorPencil>.from(
          map['pencils']?.map((pencil) => PrismacolorPencil.fromMap(pencil))),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'hex': hex,
      'pencils': pencils.map((pencil) => pencil.toJson()).toList(),
    };
  }

  factory cm.fromJson(Map<String, dynamic> json) {
    return cm(
      name: json['name'],
      hex: json['hex'],
      pencils: List<PrismacolorPencil>.from(
          json['pencils']?.map((pencil) => PrismacolorPencil.fromJson(pencil))),
    );
  }
}

