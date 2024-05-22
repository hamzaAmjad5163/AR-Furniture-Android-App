import 'package:arshop/constants/theme.dart';
import 'package:arshop/firebase_helpers/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:arshop/provider/app_provider.dart';
import 'package:arshop/screens/custom_bottom_navbar/custom_bottom_bar.dart';
import 'package:arshop/screens/welcome/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

import 'firebase_helpers/firebase_auth_helper/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = "pk_test_51P2VIvECYWuSTnmpPjHkOXJ0tBLXJ1IXYJRaPCjBcXjx9rphfrV8GNzygoAxly5YGhPJTlqn3vBzuxD33edCuLzv00PY9o1O02";
      /*pk_test_51MWx8OAVMyklfe3CsjEzA1CiiY0XBTlHYbZ8jQlGtVFIwQi4aNeGv8J1HUw4rgSavMTLzTwgn0XRlwoTVRFXyu2h00mRUeWmAf*/

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AR Furniture App',
        theme: themeData,
        home: StreamBuilder(
          stream: FirebaseAuthHelper.instance.getAuthChange,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const CustomBottomBar();
            }
            return const Welcome();
          },
        ),
      ),
    );
  }
}
