import 'package:afronex_shop_app/controller/user/user_controller.dart';
import 'package:afronex_shop_app/screens/users/login.dart';
import 'package:afronex_shop_app/services/authentication/firebase_auth_services.dart';
import 'package:afronex_shop_app/widgets/buttons.dart';
import 'package:afronex_shop_app/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  AuthServices services = AuthServices();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late bool isSigning;

  @override
  void initState() {
    super.initState();
    isSigning = false;
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  // Future<void> _signUpWithEmailAndPassword() async {
  //   setState(() {
  //     isSigning = true;
  //   });

  //   User? user = await services.signUp(_usernameController.text.trim(),
  //       _emailController.text.trim(), _passwordController.text.trim());

  //   if (user != null) {
  //     setState(() {
  //       isSigning = false;
  //     });
  //     Navigator.pushAndRemoveUntil(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => const LoginPage(),
  //         ),
  //         (route) => false);
  //     showToast(message: 'User Created Successfuly');
  //   } else {
  //     setState(() {
  //       isSigning = false;
  //     });
  //     showToast(message: 'Some error occurred');
  //   }
  // }
  UserController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Create New Account!',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 20,
              ),
              FormContainer(
                controller: _usernameController,
                labelText: 'Username',
                inputType: TextInputType.text,
                isPasswordField: false,
              ),
              const SizedBox(
                height: 10,
              ),
              FormContainer(
                controller: _emailController,
                labelText: 'Email',
                inputType: TextInputType.emailAddress,
                isPasswordField: false,
              ),
              const SizedBox(
                height: 10,
              ),
              FormContainer(
                controller: _passwordController,
                labelText: 'Password',
                inputType: TextInputType.text,
                isPasswordField: true,
              ),
              const SizedBox(
                height: 20,
              ),
              GetBuilder<UserController>(
                builder: (_) {
                  return controller.isSignedIn
                      ? CircularProgressIndicator(
                          color: Theme.of(context).primaryColor)
                      : GestureDetector(
                          onTap: () {
                            controller.signUpWithEmailAndPassword(
                                _usernameController.text.trim(),
                                _emailController.text.trim(),
                                _passwordController.text.trim());
                          },
                          child: Button(
                            title: 'Sign Up',
                            width: size.width * 0.5,
                            color: Theme.of(context).primaryColor,
                          ),
                        );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  const SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(const LoginPage());
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
