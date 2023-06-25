import 'package:flutter/material.dart';

import 'package:chess/src/representation/responsive_view.dart';



//// todo : implement pinned to king 
//// todo : implement check to king 
//// todo : implement dead pices place next to player car
//// todo : implement checkmate 
/// todo : staleMate 
/// todo : mutliplayer and online , rooms


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chess ',
        theme: ThemeData(
          
          useMaterial3: true,
        ),
        home: const ResponsiveView());
  }
}
