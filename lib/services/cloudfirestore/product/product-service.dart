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

  Stream<Iterable<Product>> allProducts() {
    final allProduct = collection.snapshots().map((event) => event.docs.map((doc) => Product.fromSnapshot(doc)));
    return allProduct;
  }

  Stream<Iterable<Product>> allFavoritedProducts({required List<String> favorites}) {
    final allProduct = collection
        .where('favorites', arrayContainsAny: favorites)
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
