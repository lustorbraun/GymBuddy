import 'dart:typed_data';

class ItemModel {
  ItemModel({
    this.date,
    this.bodyPart,
    this.image,
  });
  ItemModel.withID({
    this.id,
    this.date,
    this.bodyPart,
    this.image,
  });

  int id;
  final String date;
  final String bodyPart;
  final Uint8List image;

  factory ItemModel.fromMap(Map<String, dynamic> json) {
    return ItemModel.withID(
      id: json["id"],
      date: json["date"],
      bodyPart: json["bodyPart"],
      image: json["imageData"],
    );
  }

  Map<String, dynamic> toMap() {
    final map = Map<String,dynamic>();
    map['date'] = date;
    map["bodyPart"] = bodyPart;
    map["imageData"] = image;
    return map;
  }
}