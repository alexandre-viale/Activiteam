import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tp2_dev_mobile/firebase_options.dart';
import 'package:tp2_dev_mobile/providers/activities_notifier.dart';
import 'package:tp2_dev_mobile/providers/cart_notifier.dart';
import 'package:tp2_dev_mobile/screens/home_screen/home_screen.dart';
import 'package:tp2_dev_mobile/screens/login_screen.dart';
import 'package:tp2_dev_mobile/screens/register_screen.dart';
import 'package:tp2_dev_mobile/theme/theme.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ActivitiesNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartNotifier(),
        )
      ],
      child: const ActiviTeam(),
    ),
  );
}

class ActiviTeam extends StatefulWidget {
  const ActiviTeam({super.key});

  @override
  State<ActiviTeam> createState() => _ActiviTeamState();
}

class _ActiviTeamState extends State<ActiviTeam> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: const CupertinoScrollBehavior(),
      title: 'Activiteam',
      theme: appTheme(),
      home: FutureBuilder(
        future: FirebaseAuth.instance.authStateChanges().first,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (snapshot.hasData) {
            return const HomeScreen();
          }

          return const LoginScreen();
        },
      ),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
