import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomappkoray/modals/Product.dart';
import 'package:ecomappkoray/modals/Note.dart';


class FirebaseRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Future<void> AddProduct(Product product) async {
    _firebaseFirestore.collection("Products").doc(product.ProductID).set(product.ToMap());
  }
  
}


// String ProductID;
//   String ProductName;
//   int? Amount;
//   double? Weight;
//   String ImageURL;
//   double Price;
//   String Explanation;