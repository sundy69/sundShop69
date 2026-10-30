import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_realapp_1/Screens/bottomnavigationbar_screen.dart';
import 'package:flutter_realapp_1/Screens/cartScreen.dart';
import 'package:flutter_realapp_1/bindings/cartBinding.dart';
import 'package:flutter_realapp_1/bindings/mutiple_binding.dart';
import 'package:flutter_realapp_1/controllers/setting_controller.dart';
import 'package:flutter_realapp_1/setting/setting_translation.dart';
import 'package:get/get.dart';

// Firebase
import 'package:flutter_realapp_1/firebase_options.dart';

// Products
import 'package:flutter_realapp_1/Products/product.dart';
import 'package:flutter_realapp_1/Products/productdetail.dart';

// Screens
import 'package:flutter_realapp_1/Screens/bottomnavigatorbar.dart';
import 'package:flutter_realapp_1/Screens/create_screen.dart';
import 'package:flutter_realapp_1/Screens/forgot_password.dart';
import 'package:flutter_realapp_1/Screens/information_screen.dart';
import 'package:flutter_realapp_1/Screens/login_screen.dart';

// Bindings
import 'package:flutter_realapp_1/bindings/auth_binding.dart';
import 'package:flutter_realapp_1/bindings/bottomnavigator_binding.dart';
import 'package:flutter_realapp_1/bindings/productbinding.dart';
import 'package:flutter_realapp_1/bindings/productdetail_binding.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: SettingTranslation(),
      locale: Locale('en', 'US'),
      fallbackLocale: Locale('km', 'KH'),
      builder: (context, child) {
        final settings = Get.find<SettingController>();
        return Obx(
          () => Theme(
            data: Theme.of(context).copyWith(
              textTheme: settings.textTheme(Theme.of(context).textTheme),
              primaryTextTheme: settings.textTheme(
                Theme.of(context).primaryTextTheme,
              ),
            ),
            child: child!,
          ),
        );
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',

      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),

      // Register CartController តែមួយសម្រាប់ App ទាំងមូល
      initialRoute: '/main',
      // initialBinding: CartBinding(),
      initialBinding: AppBinding(),
      getPages: [
        // Create Account
        GetPage(
          name: '/CreateScreen',
          page: () => CreateScreen(),
          binding: AuthBinding(),
        ),

        // Login
        GetPage(
          name: '/login',
          page: () => LoginScreen(),
          binding: AuthBinding(),
        ),

        // Forgot Password
        GetPage(name: '/forgotpassword', page: () => ForgotPassword()),

        // User Information
        GetPage(
          name: '/information_Screen',
          page: () => InformationScreen(),
          binding: AuthBinding(),
        ),

        // Main Screen
        GetPage(
          name: "/main",
          page: () => BottomnavigationbarScreen(),
          binding: MainBinding(),
        ),

        // Product List
        GetPage(
          name: '/product',
          page: () => Product(),
          binding: Productbinding(),
        ),

        // Product Detail
        GetPage(
          name: '/productdetail/:id',
          page: () => Productdetail(),
          binding: ProductdetailBinding(),
        ),

        // Cart Screen
        GetPage(
          name: '/cart',
          page: () => const CartScreen(),
          binding: CartBinding(),
        ),
      ],
    );
  }
}
