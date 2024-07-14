import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_a_z/db/db_helper.dart';
import 'package:shop_a_z/models/telescope.dart';
import 'package:shop_a_z/utils/constants.dart';
import '../models/brand.dart';
import '../models/image_model.dart';

class TelescopeProvider with ChangeNotifier {
  List<Brand> brandList = [];

  Future<void> addBrand(String name) {
    final brand = Brand(name: name);
    return DbHelper.addBrand(brand);
  }

  getAllBrands() {
    DbHelper.getAllBrands().listen((snapshot) {
      brandList = List.generate(snapshot.docs.length,
          (index) => Brand.fromJson(snapshot.docs[index].data()));
      notifyListeners();
    });
  }

  Future<ImageModel> uploadImage(String imageLocalPath) async {
    final String imageName = 'image_${DateTime.now().millisecondsSinceEpoch}';

    final photoRef = FirebaseStorage.instance
        .ref()
        .child('$telescopeImageDirectory$imageName');

    final uploadTask = photoRef.putFile(File(imageLocalPath));
    final snapshot = await uploadTask.whenComplete(() => null);
    final url = await snapshot.ref.getDownloadURL();
    return ImageModel(
        imageName: imageName,
        directoryName: telescopeImageDirectory,
        downloadUrl: url);
  }

  Future<void>addTelescope(Telescope telescope)async {
    return DbHelper.addTelescope(telescope);
  }
}
