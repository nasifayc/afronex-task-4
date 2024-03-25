
import 'package:afronex_shop_app/models/user_model.dart';
import 'package:afronex_shop_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      body: Center(
        child: Text('Welcome ${user.username} Your Email: ${user.email}',style: const TextStyle(
          fontSize: 25, fontWeight: FontWeight.bold
        ),),
      ),
    );
  }
}