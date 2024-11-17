import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_body_parts/models/sub_body_part_model.dart';

class BodyPartModel {
  String? id;
  String? title;
  String? description;
  String? img;
  List<SubBodyPartModel>? subBodyPartList;

  BodyPartModel({
    this.id,
    this.title,
    this.description = '',
    this.img,
    this.subBodyPartList,
  });

  factory BodyPartModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    final list = data?['subBodyPartList'] as List<dynamic>? ?? [];
    return BodyPartModel(
        id: data?['id'],
        title: data?['title'],
        description: data?['description'],
        img: data?['img'],
        // subBodyPartList: data?['subBodyPartList'] is Iterable
        //     ? List.from(data?['subBodyPartList'])
        //     : null,
        subBodyPartList: list
            .map(
              (sub) => SubBodyPartModel.fromFirestore2(sub),
            )
            .toList());
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      if (title != null) "title": title,
      if (description != null) "description": description,
      if (img != null) "img": img,
      if (subBodyPartList != null)
        "subBodyPartList":
            subBodyPartList?.map((sub) => sub.toFirestore()).toList(),
    };
  }
}
