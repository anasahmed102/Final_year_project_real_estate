import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:real_estaye_app/features/posts/data/model/real_estate.dart';

final collectionReference =
    FirebaseFirestore.instance.collection('Real_Estate').snapshots();
final storageReference = FirebaseStorage.instance.ref();
Reference storageRef = FirebaseStorage.instance.ref();

abstract class RealEstateRemoteDataSource {
  Future<Unit> addProperty(RealEstateModel realEstateModel);
  Stream<List<RealEstateModel>> getAllPosts();
}

class RealEstateRemoteDataSourceImpl extends RealEstateRemoteDataSource {
  @override
  Stream<List<RealEstateModel>> getAllPosts() {
    return collectionReference.map((snapshot) {
      final List<RealEstateModel> realEstateList = snapshot.docs
          .map((doc) => RealEstateModel.fromSnapshot(doc))
          .toList();

      return realEstateList;
    });
  }

  @override
  Future<Unit> addProperty(RealEstateModel realEstateModel) async {
    try {
      final CollectionReference realEstateCollection =
          FirebaseFirestore.instance.collection('Real_Estate');
      final storage = FirebaseStorage.instance;

      if (realEstateModel.imageFile != null) {
        final String imageName = basename(realEstateModel.imageFile!.path);
        final Reference storageImage =
            storage.ref().child('property_images/$imageName');
        final UploadTask uploadTask =
            storageImage.putFile(realEstateModel.imageFile!);

        await uploadTask;
        final String imageUrl = await storageImage.getDownloadURL();
        realEstateModel.photo = imageUrl;
      }

      final Map<String, dynamic> data = realEstateModel.toMap();

      await realEstateCollection.add(data);

      return unit;
    } catch (e) {
      throw Exception('Failed to add the property: $e');
    }
  }
}
