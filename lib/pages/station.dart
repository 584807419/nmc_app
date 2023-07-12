import 'package:flutter/material.dart';
// 气象站详细数据页面,接收城市列表页传来的气象站id参数
class StationPage extends StatefulWidget {
  final String station_id;
  const StationPage({super.key, this.station_id="54511"});

  @override
  State<StationPage> createState() => _StationPage();
}

class _StationPage extends State<StationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("气象站id${widget.station_id}详细数据页面"), // 获取station_id
      ),
      body: const Center(child: Text("城市列表页内容"),),
    );
  }
}