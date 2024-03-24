import 'package:afronex_shop_app/screens/users/signup.dart';
import 'package:afronex_shop_app/widgets/buttons.dart';
import 'package:afronex_shop_app/widgets/text_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Center(
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
              isPasswordField: false,
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/home');
              },
              child: Button(
                title: 'Login',
                width: size.width * 0.3,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
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
    );
  }
}
