import 'package:afronex_shop_app/controller/other/textfield_controller.dart';
import 'package:afronex_shop_app/controller/user/login_controller.dart';
import 'package:afronex_shop_app/controller/user/profile_controller.dart';
import 'package:afronex_shop_app/controller/user/signup_controller.dart';
import 'package:afronex_shop_app/firebase_options.dart';
import 'package:afronex_shop_app/controller/payement_controller/payment_controller.dart';
import 'package:afronex_shop_app/controller/user/user_controller.dart';
import 'package:afronex_shop_app/screens/splash/splash_screen.dart';
import 'package:afronex_shop_app/screens/splash/welcome_screen.dart';
import 'package:afronex_shop_app/screens/users/login.dart';
import 'package:afronex_shop_app/widgets/text_field.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

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
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Afronex Shop',
      home: const WelcomeScreen(),
      initialBinding: BindingsBuilder(() {
        Get.put(UserController());
        Get.put(PaymentController());
        Get.put(SignUpController());
        Get.put(LoginController());
        Get.put(TextFieldController());
      }),
      theme: ThemeData(
        primaryColor: Colors.teal,
        useMaterial3: true,
      ),
    );
  }
}
