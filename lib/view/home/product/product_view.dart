import 'package:flutter/material.dart';
import 'package:onurun/core/constants/navigation/navigation_constants.dart';
import 'package:onurun/core/init/navigation/navigation_service.dart';
import 'package:onurun/models/product.dart';
import 'package:onurun/services/cloudfirestore/product/product-service.dart';

import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

class ProductView extends StatefulWidget {
  const ProductView({Key? key}) : super(key: key);

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: const [],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ElevatedButton(
            onPressed: () {
              NavigationService.instance.navigateToPage(path: NavigationConstants.ADD_PRODUCT_VIEW);
            },
            child: const Text('add product'),
          ),
          StreamBuilder<Iterable<Product>>(
            stream: ProductCloudFireStoreService.instance.allProducts(),
            builder: (context, AsyncSnapshot<Iterable<Product>> snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final product = snapshot.data!.elementAt(index);
                        return ProductCard(product: product);
                      }),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(product.productName),
        subtitle: Text(
          product.productDescription,
        ),
        leading: IconButton(
          onPressed: () {
            ProductCloudFireStoreService.instance
                .changeIsFavorite(documentId: product.productId, changeBoolValue: !product.isFavorite);
          },
          icon: Icon(
            Icons.favorite,
            color: product.isFavorite ? Colors.red : Colors.black,
          ),
        ),
        trailing: IconButton(
          onPressed: () {
            ProductCloudFireStoreService.instance.deleteDocument(
              docName: product.productId,
            );
          },
          icon: const Icon(
            Icons.delete,
          ),
        ),
      ),
    );
  }
}
