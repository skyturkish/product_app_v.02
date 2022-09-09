import 'package:flutter/material.dart';
import 'package:onurun/models/product.dart';
import 'package:onurun/services/cloudfirestore/product/product-service.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({Key? key}) : super(key: key);

  @override
  FavoriteViewState createState() => FavoriteViewState();
}

class FavoriteViewState extends State<FavoriteView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          StreamBuilder<Iterable<Product>>(
            stream: ProductCloudFireStoreService.instance.allFavoritedProducts(),
            builder: (context, AsyncSnapshot<Iterable<Product>> snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final product = snapshot.data!.elementAt(index);
                        return Card(
                          child: ListTile(
                            title: Text(product.productName),
                            subtitle: Text(
                              product.productDescription,
                            ),
                            leading: IconButton(
                              onPressed: () {
                                ProductCloudFireStoreService.instance.changeIsFavorite(
                                    documentId: product.productId, changeBoolValue: !product.isFavorite);
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
