import 'package:afronex_shop_app/providers/user_controller.dart';
import 'package:afronex_shop_app/screens/users/signup.dart';
import 'package:afronex_shop_app/services/firebase_auth_services.dart';
import 'package:afronex_shop_app/widgets/buttons.dart';
import 'package:afronex_shop_app/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthServices services = AuthServices();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late bool isLogging;

  @override
  void initState() {
    super.initState();
    isLogging = false;
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  // Future<void> _loginWithEmailAndPassword() async {
  //   setState(() {
  //     isLogging = true;
  //   });

  //   User? user = await services.logIn(
  //       _emailController.text.trim(), _passwordController.text.trim());
  //   if (user != null) {
  //     setState(() {
  //       isLogging = false;
  //     });
  //     Navigator.pushAndRemoveUntil(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => const LandingPage(),
  //         ),
  //         (route) => false);
  //   } else {
  //     setState(() {
  //       isLogging = false;
  //     });
  //     showToast(message: 'No User Found');
  //   }
  // }
  UserController controller = Get.put(UserController());
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
              const Text('Welcom Back!',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 20,
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
                  bool isSigned = controller.isSignedIn;
                  return isSigned
                      ? CircularProgressIndicator(
                          color: Theme.of(context).primaryColor)
                      : GestureDetector(
                          onTap: () {
                            controller.loginWithEmailAndPassword(
                                _emailController.text.trim(),
                                _passwordController.text.trim());
                          },
                          child: Button(
                            title: 'Login',
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
                  const Text('Don\'t have an account?'),
                  const SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(const SignUpPage());
                    },
                    child: const Text(
                      'Sign Up',
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
