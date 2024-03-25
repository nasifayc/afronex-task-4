import 'package:afronex_shop_app/firebase_options.dart';
import 'package:afronex_shop_app/providers/user_provider.dart';
import 'package:afronex_shop_app/screens/landing.dart';
import 'package:afronex_shop_app/screens/users/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  } catch (e) {
    print('Firebase Intialization Error: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UserProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Afronex Shop',
        initialRoute: '/',
        routes: {
          '/': (context) => const LoginPage(),
          '/landing': (context) => const LandingPage(),
        },
        theme: ThemeData(
          primaryColor: Colors.teal,
          useMaterial3: true,
        ),
      ),
    );
  }
}
