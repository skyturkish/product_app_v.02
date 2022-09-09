import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:onurun/core/constants/navigation/navigation_constants.dart';
import 'package:onurun/core/init/navigation/navigation_service.dart';
import 'package:onurun/services/auth/auth_service.dart';
import 'package:onurun/view/home/favorite/view/favorite_view.dart';
import 'package:onurun/view/home/product/product_view.dart';
import 'package:onurun/view/home/search/search_view.dart';
import 'package:onurun/view/home/write_message/write_message_view.dart';

class NavigationHomeView extends StatefulWidget {
  const NavigationHomeView({Key? key}) : super(key: key);
  @override
  NavigationHomeViewState createState() => NavigationHomeViewState();
}

class NavigationHomeViewState extends State<NavigationHomeView> {
  List<String> appBarTitle = [
    'Search',
    'Your Favorite Drinks',
    'Write a message',
  ];

  List<Widget> pages = [
    const ProductView(),
    const SearchView(),
    const FavoriteView(),
    const WriteMessageView(),
  ];

  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: pageIndex == 0
          ? null
          : AppBar(
              title: Text(
                appBarTitle[pageIndex - 1],
                style: const TextStyle(color: Colors.brown),
              ),
              centerTitle: true,
              elevation: 0,
              actions: [
                IconButton(
                    onPressed: () {
                      AuthService.firebase().logOut();
                      NavigationService.instance.navigateToPageClear(path: NavigationConstants.LOGIN_VIEW);
                    },
                    icon: const Icon(Icons.logout))
              ],
            ),
      body: pages[pageIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: pageIndex,
        height: 45,
        items: const <Widget>[
          Icon(Icons.home_filled, size: 30, color: Colors.brown),
          Icon(Icons.search, size: 30, color: Colors.brown),
          Icon(Icons.favorite, size: 30, color: Colors.brown),
          Icon(Icons.message, size: 30, color: Colors.brown),
        ],
        onTap: (index) {
          setState(
            () {
              pageIndex = index;
            },
          );
        },
      ),
    );
  }
}
