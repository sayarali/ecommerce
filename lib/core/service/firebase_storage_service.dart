import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  Future<List<String>> getProductImagesURLs(String productId) async {
    try {
      final ListResult listResult =
          await _storage.ref().child('product_images/$productId').listAll();
      final imageURLs = <String>[];
      for (final item in listResult.items) {
        final url = await item.getDownloadURL();
        imageURLs.add(url);
      }
      return imageURLs;
    } catch (e) {
      throw Exception('Resimler yüklenirken bir hata oluştus: $e');
      return [];
    }
  }
}
