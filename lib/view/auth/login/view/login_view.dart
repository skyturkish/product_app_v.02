// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:onurun/core/constants/navigation/navigation_constants.dart';
import 'package:onurun/core/init/navigation/navigation_service.dart';
import 'package:onurun/product/widget/textformfield/custom_text_form_field.dart';
import 'package:onurun/services/auth/auth_exceptions.dart';
import 'package:onurun/services/auth/auth_service.dart';
import 'package:onurun/utilities/dialogs/error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  var formKey = GlobalKey<FormState>();
  // late final yapıyoruz controlleri' initState anında (sayfa kurulurken) değerlerini atıyoruz
  // dispose kısmında siliyoruz. hafızada yer kaplamasın
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  bool passwordHidden = true;

  IconData passwordIcon = Icons.remove_red_eye_rounded;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.only(left: 30, top: 80, right: 30),
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.brown.withOpacity(0.8),
                      radius: 40,
                      child: Icon(Icons.person, color: Colors.white, size: 40),
                    ),
                    CustomTextFormField(
                      controller: emailController,
                      labelText: 'email',
                      prefix: Icon(Icons.mail),
                    ),
                    CustomTextFormField(
                      controller: passwordController,
                      labelText: 'password',
                      prefix: Icon(Icons.lock),
                      passwordTextFormField: true,
                    ),
                    Container(
                      height: 50,
                      width: 225,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.brown.withOpacity(1),
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: MaterialButton(
                        onPressed: () async {
                          // assert(emailController != null && passwordController != null);
                          if (formKey.currentState!.validate()) {
                            try {
                              await AuthService.firebase()
                                  .logIn(email: emailController.text, password: passwordController.text);

                              if (AuthService.firebase().currentUser != null) {
                                NavigationService.instance
                                    .navigateToPageClear(path: NavigationConstants.NAVIGATION_BAR_HOME);
                              } // TODO burası block gibi state maangement ile düzeltilebilir
                            } on UserNotFoundAuthException catch (_) {
                              await showErrorDialog(context, 'Cannot find a user with the entered credentials!');
                            } on WrongPasswordAuthExpection catch (_) {
                              await showErrorDialog(context, 'Wrong credentials');
                            } on GenericAuthException catch (_) {
                              await showErrorDialog(context, 'Authentication error');
                            }
                          }
                        },
                        splashColor: Colors.white,
                        highlightColor: Colors.white,
                        child: Text(
                          'Sign in',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forget Password ?',
                        style: TextStyle(
                          color: Colors.grey.withOpacity(0.6),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account?',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            NavigationService.instance.navigateReplace(path: NavigationConstants.REGISTER_VIEW);
                          },
                          child: Text(
                            'SIGN UP',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.withOpacity(0.6),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      child: Text(
                        'Login to Admin Panel',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        // TODO admin paneline el at
                        if (emailController.text == 'admin@gmail.com' && passwordController.text == 'test1234') {
                          // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AdminPanel()));
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
