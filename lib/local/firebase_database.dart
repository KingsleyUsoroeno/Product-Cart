import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_course/models/productPojo.dart';

class FirebaseDatabaseService {
  // create a collection reference
  final CollectionReference productsCollection = Firestore.instance.collection("products");
  final databaseReference = Firestore.instance;

  Future addProduct(ProductPoJo poJo) async {
//    AppModel model = new AppModel();
//    User currentUser = await model.getCurrentUser("user");
//    await databaseReference.collection("products").document(currentUser.id).updateData(poJo.toJson());
    //await databaseReference.collection("products").document(currentUser.id).setData(poJo.toJson(), merge: true);
  }

  Future updateProduct(ProductPoJo product) async {
//    AppModel model = new AppModel();
//    User currentUser = await model.getCurrentUser("user");
//    print("inside FirebaseDatabaseService currentUser is $currentUser");
//    return await productsCollection.document(currentUser.id).setData(product.toJson());
  }

  // get  brews stream
  Stream<QuerySnapshot> get products {
    return productsCollection.snapshots();
  }
}
