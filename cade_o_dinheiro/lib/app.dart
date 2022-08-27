import 'package:cade_o_dinheiro/pages/tabs_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Cade o dinheiro?',
      debugShowCheckedModeBanner: false,
      home: TabsPage(),
    );
  }
}