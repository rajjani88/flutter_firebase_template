import 'package:cloud_firestore/cloud_firestore.dart';

class SubBodyPartModel {
  String? id;
  String? title;
  String? description;
  String? img;
  String? parantId;

  SubBodyPartModel({
    this.id,
    this.title,
    this.description = '',
    this.img,
    this.parantId,
  });

  factory SubBodyPartModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return SubBodyPartModel(
      id: data?['id'],
      title: data?['title'],
      description: data?['description'],
      img: data?['img'],
      parantId: data?['parantId'],
    );
  }

  factory SubBodyPartModel.fromFirestore3(
    QueryDocumentSnapshot<Object?> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data() as Map;
    return SubBodyPartModel(
      id: data?['id'],
      title: data?['title'],
      description: data?['description'],
      img: data?['img'],
      parantId: data?['parantId'],
    );
  }

  factory SubBodyPartModel.fromFirestore2(
    Map<String, dynamic> snapshot,
  ) {
    final data = snapshot;
    return SubBodyPartModel(
        id: data?['id'],
        title: data?['title'],
        description: data?['description'],
        img: data?['img'],
        parantId: data?['parantId']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      if (title != null) "title": title,
      if (description != null) "description": description,
      if (img != null) "img": img,
      if (parantId != null) "parantId": parantId
    };
  }
}
