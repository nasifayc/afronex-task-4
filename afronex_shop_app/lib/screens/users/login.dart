import 'package:afronex_shop_app/screens/users/signup.dart';
import 'package:afronex_shop_app/services/firebase_auth_services.dart';
import 'package:afronex_shop_app/services/utils/toast_message.dart';
import 'package:afronex_shop_app/widgets/buttons.dart';
import 'package:afronex_shop_app/widgets/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

  Future<void> _loginWithEmailAndPassword() async {
    setState(() {
      isLogging = true;
    });

    User? user = await services.logIn(
        _emailController.text.trim(), _passwordController.text.trim());
    if (user != null) {
      setState(() {
        isLogging = false;
      });
      Navigator.pushNamed(context, '/landing');
    } else {
      setState(() {
        isLogging = false;
      });
      showToast(message: 'No User Found');
    }
  }

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
              isLogging
                  ? CircularProgressIndicator(
                      color: Theme.of(context).primaryColor)
                  : GestureDetector(
                      onTap:_loginWithEmailAndPassword,
                      child: Button(
                        title: 'Login',
                        width: size.width * 0.5,
                        color: Theme.of(context).primaryColor,
                      ),
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
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpPage(),
                          ),
                          (route) => false);
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
