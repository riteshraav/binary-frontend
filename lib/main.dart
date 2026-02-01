
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:windows_sample/riverpod/providers.dart';
import 'package:windows_sample/windows/home_window.dart';
import 'package:oktoast/oktoast.dart'; // ✅ add this


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final container = await initIsar();

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: OKToast(  // ✅ Wrap MyApp inside OKToast
        position: ToastPosition.bottom, // default toast position
        backgroundColor: Colors.black87,
        radius: 8.0,
        textStyle: const TextStyle(fontSize: 16, color: Colors.white),  // ✅ Wrap MyApp inside OKToast
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'File Explorer',
      navigatorKey: navigatorKey, // ✅ Add this line
      home: HomeScreen(),
    );
  }
}


