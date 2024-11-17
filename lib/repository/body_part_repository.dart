import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_body_parts/models/body_part_model.dart';
import 'package:flutter_body_parts/models/sub_body_part_model.dart';

class BodyPartRepository {
  FirebaseFirestore db = FirebaseFirestore.instance;

  //ref titles
  String bodyPartCollection = 'bodyParts';
  String subPartCollection = 'subBodyParts';

  //create new body part to firestore
  Future<void> addBodyPartToFirestore(BodyPartModel bodyPart) async {
    // Get the last document ID
    final bodyParts = db.collection(bodyPartCollection);
    final lastDocumentSnapshot =
        await bodyParts.orderBy('id', descending: true).limit(1).get();
    final lastId = lastDocumentSnapshot.docs.isNotEmpty
        ? lastDocumentSnapshot.docs.first.id
        : '0';

    // Increment the ID and set it on the BodyPartModel
    final newId = int.parse(lastId) + 1;
    bodyPart.id = newId.toString();

    // Add data to Firestore
    await bodyParts.doc(newId.toString()).set(bodyPart.toFirestore());
  }

  //update body part
  Future<void> updateBodyPart(BodyPartModel bodyPart) async {
    // Get the last document ID
    final bodyParts = db.collection(bodyPartCollection);
    // update
    await bodyParts.doc(bodyPart.id.toString()).set(bodyPart.toFirestore());
  }

  //image upload
  Future<String> uploadImage(File imageFile, String fileName) async {
    Reference ref = FirebaseStorage.instance.ref().child('images/$fileName');
    UploadTask uploadTask = ref.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

    String downloadURL = await taskSnapshot.ref.getDownloadURL();

    return downloadURL;
  }

  String getFileNameFromPath(String filePath) {
    final fileName = filePath.split('/').last;
    return fileName;
  }

  //get all obdy part list
  Future<List<BodyPartModel>> fetchBodyPartList() async {
    final querySnapshot = await db
        .collection(bodyPartCollection)
        .orderBy('id', descending: false)
        .get();
    final bodyPartList = querySnapshot.docs
        .map((doc) => BodyPartModel.fromFirestore(doc, null))
        .toList();
    return bodyPartList;
  }

  //create new sub body part to firestore
  Future<void> addSubBodyPart(SubBodyPartModel bodyPart) async {
    // Get the last document ID
    final bodyParts = db.collection(subPartCollection);
    final lastDocumentSnapshot =
        await bodyParts.orderBy('id', descending: true).limit(1).get();
    final lastId = lastDocumentSnapshot.docs.isNotEmpty
        ? lastDocumentSnapshot.docs.first.id
        : '0';

    // Increment the ID and set it on the BodyPartModel
    final newId = int.parse(lastId) + 1;
    bodyPart.id = newId.toString();

    // Add data to Firestore
    await bodyParts.doc(newId.toString()).set(bodyPart.toFirestore());
  }

  Future<void> updateSubBodyPart(SubBodyPartModel bodyPart) async {
    final bodyParts = db.collection(subPartCollection);
    //update
    await bodyParts.doc(bodyPart.id.toString()).set(bodyPart.toFirestore());
  }

  //fatch subbody parts by id
  Future<List<SubBodyPartModel>> fetchSubBodyPartsByParentId(
      String parentId) async {
    final CollectionReference subBodyParts = db.collection(subPartCollection);

    // Query subbodyParts by parantId
    final querySnapshot =
        await subBodyParts.where('parantId', isEqualTo: parentId).get();

    final subBodyPartList = querySnapshot.docs
        .map((doc) => SubBodyPartModel.fromFirestore3(doc, null))
        .toList();
    return subBodyPartList;
  }

  //delete sub body part
  Future<void> deleteBodyPart(String id) async {
    final subBodyParts = db.collection(bodyPartCollection);
    await subBodyParts.doc(id).delete();
  }

  //delete sub body part
  Future<void> deleteSubBodyPart(String subBodyPartId) async {
    final subBodyParts = db.collection(subPartCollection);
    await subBodyParts.doc(subBodyPartId).delete();
  }
}
