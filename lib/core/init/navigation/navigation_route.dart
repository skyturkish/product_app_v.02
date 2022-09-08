import 'package:flutter/material.dart';
import 'package:onurun/core/constants/navigation/navigation_constants.dart';
import 'package:onurun/view/auth/login/view/login_view.dart';
import 'package:onurun/view/auth/register/view/register_view.dart';
import 'package:onurun/view/home/navigation_home_view.dart';

class NavigationRoute {
  static final NavigationRoute _instance = NavigationRoute._init();
  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      case NavigationConstants.LOGIN_VIEW:
        return normalNavigate(const LoginView());
      case NavigationConstants.NAVIGATION_BAR_HOME:
        return normalNavigate(const NavigationHomeView());
      case NavigationConstants.REGISTER_VIEW:
        return normalNavigate(const RegisterView());

      // case NavigationConstants.WRITE_MESSAGE_VIEW:
      //   return normalNavigate(WriteMessageView());

      // case NavigationConstants.ADMIN_VIEW:
      //   return normalNavigate(AdminView());

      // case NavigationConstants.ADD_PRODUCT_VIEW:
      //   return normalNavigate(AddNewProductView());
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('page is not found'),
            ),
          ), // not found page
        );
    }
  }

  MaterialPageRoute normalNavigate(Widget widget, {String? pageName}) {
    return MaterialPageRoute(
        builder: (context) => widget,
        //analytciste görülecek olan sayfa ismi için pageName veriyoruz
        settings: RouteSettings(name: pageName));
  }
}
