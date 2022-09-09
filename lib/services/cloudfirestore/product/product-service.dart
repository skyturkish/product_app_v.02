import 'package:onurun/models/product.dart';
import 'package:onurun/services/cloudfirestore/base-service.dart';

class ProductCloudFireStoreService extends CloudFireStoreBaseService {
  // Singleton pattern
  static ProductCloudFireStoreService get instance {
    _instance ??= ProductCloudFireStoreService._init(collectionName: 'products');
    return _instance!;
  }

  ProductCloudFireStoreService._init({required super.collectionName});

  static ProductCloudFireStoreService? _instance;

  Future<Product> addProduct({required String productName, required String productDescription}) async {
    final document = await collection.add(
      Product(productName: productName, productDescription: productDescription, productId: '').toMap(),
    );
    final fetchedProduct = await document.get();
    return Product(
      productId: fetchedProduct.id,
      productDescription: productDescription,
      productName: productName,
    );
  }

  Future<void> changeIsFavorite({required String documentId, required bool changeBoolValue}) async {
    final product = collection.doc(documentId);
    product.update({"isFavorite": changeBoolValue}).then((value) => print("DocumentSnapshot successfully updated!"),
        onError: (e) => print("Error updating document $e"));
  }

  Stream<Iterable<Product>> allProducts() {
    final allProduct = collection.snapshots().map((event) => event.docs.map((doc) => Product.fromSnapshot(doc)));
    return allProduct;
  }

  Stream<Iterable<Product>> allFavoritedProducts() {
    final allProduct = collection
        .where('isFavorite', isEqualTo: true)
        .snapshots()
        .map((event) => event.docs.map((doc) => Product.fromSnapshot(doc)));

    return allProduct;
  }

  Future<void> deleteProduct({required String documentId}) async {
    try {
      await collection.doc(documentId).delete();
    } catch (e) {
      throw 'aaaaaaaaaaaaa'; // TODO write exception for
    }
  }
}
