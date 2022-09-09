import 'package:flutter/material.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// import 'package:flutter/material.dart';
// import 'package:onurun/models/product.dart';
// import 'package:onurun/services/cloudfirestore/product/product-service.dart';

// class SearchView extends StatefulWidget {
//   const SearchView({Key? key}) : super(key: key);



//   @override
//   SearchViewState createState() => SearchViewState();
// }

// class SearchViewState extends State<SearchView> {
//   List<Product> allDrinks = [];
//   List<Product> searchDrinks = [];

//   TextEditingController searchController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//         stream: ProductCloudFireStoreService.instance.allProducts(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (!snapshot.hasData) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }

//           allDrinks = snapshot.data!.docs.map((document) {
//             return  Drink(
//               uId: document.id,
//               name: document['name'],
//               ingredients: document['ingredients'],

//             );
//           }).toList();

//           return SingleChildScrollView(
//             padding: const EdgeInsets.all(15),
//             child: Container(
//               height: MediaQuery.of(context).size.height,
//               child: Column(
//                 children: [
//                   TextFormField(
//                     controller: searchController,
//                     onChanged: (String? value) {
//                       print(value);
//                       setState(() {
//                         searchDrinks.clear();
//                         for (int i = 0; i < allDrinks.length; i++) {
//                           if (allDrinks[i]
//                                   .name
//                                   .toLowerCase()
//                                   .startsWith(value!) &&
//                               value != '') {
//                             searchDrinks.add(allDrinks[i]);
//                           }
//                         }
//                         // allDrinks.forEach((element) {
//                         //
//                         // });
//                       });
//                     },
//                     style: TextStyle(color: Colors.white),
//                     decoration: InputDecoration(
//                       labelText: 'Search',
//                       labelStyle: TextStyle(color: Colors.white),
//                       prefixIcon: Icon(
//                         Icons.search,
//                         color: Colors.white,
//                       ),
//                       border: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.white, width: 1),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.white),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Expanded(
//                     child: myConditionalBuilder(
//                       condition: (searchDrinks.isNotEmpty),
//                       builder: ListView.separated(
//                         itemBuilder: (BuildContext context, int index) {
//                           return searchItem(
//                               searchDrinks[index], widget.user, index);
//                         },
//                         separatorBuilder: (BuildContext context, int index) =>
//                             Divider(),
//                         itemCount: searchDrinks.length,
//                       ),
//                       fallback: Center(
//                         child: searchDrinks.length == 0
//                             ? Text(
//                                 'Enter value to search for',
//                                 style: TextStyle(color: Colors.white),
//                               )
//                             : CircularProgressIndicator(
//                                 color: Colors.white,
//                               ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//   }

//   Widget searchItem(Drink drink, UserModel user, int index) {
//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context).unfocus();
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => SpecificDrinkDetailsScreen(drink, user)));
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(25),
//           color: Colors.white,
//         ),
//         margin: const EdgeInsets.all(5),
//         padding: const EdgeInsets.only(bottom: 10),
//         child: Row(
//           mainAxisSize: MainAxisSize.max,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Container(
//               width: 130,
//               height: 130,
//               color: Colors.yellow,
             
//             ),
//             SizedBox(
//               width: 15,
//             ),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     drink.name,
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.brown[700],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Text(
//                     drink.ingredients,
//                     maxLines: 3,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.brown[600],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

