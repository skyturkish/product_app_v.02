import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String productName;
  final String productDescription;
  final String productId;
  bool isFavorite;
  Product({
    required this.productName,
    required this.productDescription,
    required this.productId,
    this.isFavorite = false,
  });

  Product.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : productId = snapshot.id,
        productDescription = snapshot.data()['productDescription'] as String,
        productName = snapshot.data()['productName'] as String,
        isFavorite = snapshot.data()['isFavorite'];

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'productName': productName});
    result.addAll({'productDescription': productDescription});
    result.addAll({'productId': productId});
    result.addAll({'isFavorite': isFavorite});

    return result;
  }
}
