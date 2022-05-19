import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomappkoray/modals/Product.dart';

class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> UploadProduct(Product product) async {
    try {
      await _firestore.collection("Products").add(product.ToMap());
      return true;
    } catch (error) {
      print("Upload Product Error" + error.toString());
      return false;
    }
  }
}
