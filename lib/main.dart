import 'package:changel/Screens/Home/Home.dart';
import 'package:changel/test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'Screens/login/login.dart';
import 'mapPage.dart';
import 'provider/navigation_provider.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp( MyApp());
}

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//
//         primarySwatch: Colors.blue,
//       ),
//         routes: {
//           '/': (context) => Manager(),
//           '/ClientMap': (context) => ClientMap(),
//           '/Test': (context) => MapPage(),
//           '/LoginScreen': (context) => LoginScreen(),
//           '/MainPage': (context) => MainPage(),
//         }    );
//   }
// }
class MyApp extends StatelessWidget {
  static final String title = 'Navigation Drawer';

  @override
  Widget build(BuildContext context) =>MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => NavigationProvider()),
      ChangeNotifierProvider(create: (context) => NavigationProviderUser()),
    ],
    child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        routes: {
          '/': (context) => Manager(),
          '/ClientMap': (context) => ClientMap(),
          '/Test': (context) => MapPage(),
          '/LoginScreen': (context) => LoginScreen(),
          '/MainPage': (context) => MainPage(),
        }
        ),
  );
}
class Manager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/ClientMap');
              },
              child: Text('ClientMap')),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/LoginScreen');
              },
              child: Text('LoginScreen')
          ),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/Test');
              },
              child: Text('Test')),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/MainPage');
              },
              child: Text('MainPage')),
  
        ],
      ),
    );
  }
}
