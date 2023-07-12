import 'package:flutter/material.dart';

class CityPage extends StatefulWidget {
  const CityPage({super.key});

  @override
  State<CityPage> createState() => _CityPage();
}

class _CityPage extends State<CityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("城市列表页面"),
      ),
      body: const Center(child: Text("城市列表页内容"),),
    );
  }
}