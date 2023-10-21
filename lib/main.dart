import 'package:e_commerce/provider/address_provider.dart';
import 'package:e_commerce/provider/cart_provider.dart';
import 'package:e_commerce/pages/main_page.dart';
import 'package:e_commerce/pages/welcome_page.dart';
import 'package:e_commerce/provider/favorite_provider.dart';
import 'package:e_commerce/provider/notification_provider.dart';
import 'package:e_commerce/services/stripe_service.dart';
import 'package:e_commerce/themes/light_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:e_commerce/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load();

  StripeService.init();

  runApp(EasyLocalization(
    supportedLocales: const [Locale('en')],
    path: 'assets/translations',
    fallbackLocale: const Locale('en'),
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  Widget getHomePage() {
    if (FirebaseAuth.instance.currentUser != null) {
      return const MainPage();
    }

    return const WelcomePage();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => FavoriteProvider()),
        ChangeNotifierProvider(create: (context) => NotificationProvider()),
        ChangeNotifierProvider(create: (context) => AddressProvider()),
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: lightTheme,
        darkTheme: lightTheme,
        home: getHomePage(),
      ),
    );
  }
}
