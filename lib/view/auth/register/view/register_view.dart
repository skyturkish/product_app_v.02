// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:onurun/core/constants/navigation/navigation_constants.dart';
import 'package:onurun/core/init/navigation/navigation_service.dart';
import 'package:onurun/product/widget/textformfield/custom_text_form_field.dart';
import 'package:onurun/services/auth/auth_exceptions.dart';
import 'package:onurun/services/auth/auth_service.dart';
import 'package:onurun/utilities/dialogs/error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  RegisterViewState createState() => RegisterViewState();
}

class RegisterViewState extends State<RegisterView> {
  final formKey = GlobalKey<FormState>();

  late final TextEditingController usernameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  @override
  void initState() {
    usernameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            // TODO padding
            // TODO dışarıdan belirlenmeye okay ama textformfield'ın bir standartı olması lazım düzelt bunu onura atmadan önce
// TODO Center ve Containerler birbirine girmiş düzelt onları
            padding: const EdgeInsets.all(30.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.brown.withOpacity(0.8),
                      radius: 40,
                      child: Icon(Icons.person, color: Colors.white, size: 40),
                    ),
                  ),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.brown.withOpacity(0.8),
                      ),
                      width: 250,
                      height: 50,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: CustomTextFormField(
                        controller: usernameController,
                        labelText: 'username',
                        prefix: Icon(Icons.person, color: Colors.white, size: 20.0),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0), color: Colors.brown.withOpacity(0.8)),
                      width: 250.0,
                      height: 50.0,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: CustomTextFormField(
                        controller: emailController,
                        labelText: 'email',
                        prefix: Icon(Icons.email, color: Colors.white),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0), color: Colors.brown.withOpacity(0.8)),
                      width: 250,
                      height: 50,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: CustomTextFormField(
                        controller: passwordController,
                        labelText: 'password',
                        prefix: Icon(Icons.lock, color: Colors.white),
                        passwordTextFormField: true,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0), color: Colors.brown.withOpacity(0.8)),
                        width: 250,
                        height: 50,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: CustomTextFormField(
                          controller: confirmPasswordController,
                          labelText: 'Confirm password',
                          prefix: Icon(Icons.lock, color: Colors.white),
                          passwordTextFormField: true,
                        )),
                  ),
                  Center(
                    child: Container(
                      width: 180.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.brown,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: MaterialButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            try {
                              AuthService.firebase().createUser(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            } on WeakPasswordAuthException catch (_) {
                              await showErrorDialog(context, 'Weak password');
                            } on EmailAlreadyInUseAuthException catch (_) {
                              await showErrorDialog(context, 'Emais is already in use ');
                            } on InvalidEmailAuthException catch (_) {
                              await showErrorDialog(context, 'Invalid Email');
                            } on GenericAuthException catch (_) {
                              await showErrorDialog(context, 'A error is apperad ');
                            }
                          }
                        },
                        child: Text(
                          // TODO style  theme'den alınmalı
                          'Register',
                          style: TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?', style: TextStyle(fontSize: 15.0, color: Colors.white)),
                      TextButton(
                        onPressed: () {
                          NavigationService.instance.navigateReplace(path: NavigationConstants.LOGIN_VIEW);
                        },
                        child: Text(
                          'SIGN IN',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
