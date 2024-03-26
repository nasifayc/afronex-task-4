import 'package:afronex_shop_app/models/user_model.dart';
import 'package:afronex_shop_app/providers/user_provider.dart';
import 'package:afronex_shop_app/screens/users/login.dart';
import 'package:afronex_shop_app/services/firebase_auth_services.dart';
import 'package:afronex_shop_app/services/utils/toast_message.dart';
import 'package:afronex_shop_app/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSignOut = false;
  UserProvider provider = UserProvider();

  Future<void> _signOut() async {
    AuthServices services = AuthServices();

    setState(() {
      isSignOut = true;
    });
    try {
      await services.signOut();
      setState(() {
        isSignOut = false;
      });
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
          (route) => false);
    } catch (e) {
      setState(() {
        isSignOut = false;
      });
      showToast(message: "$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    UserModel user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Welcome ${user.username} Your Email: ${user.email}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            isSignOut
                ? CircularProgressIndicator(
                    color: Theme.of(context).primaryColor)
                : GestureDetector(
                    onTap: _signOut,
                    child: Button(
                        title: 'Sign out',
                        width: _size.width * 0.5,
                        color: Theme.of(context).primaryColor)),
          ],
        ),
      ),
    );
  }
}
