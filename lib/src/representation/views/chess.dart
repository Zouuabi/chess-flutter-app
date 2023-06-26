import 'package:chess/src/representation/views/responsive_view.dart';
import 'package:flutter/material.dart';

class Chess extends StatelessWidget {
  const Chess({super.key});

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
