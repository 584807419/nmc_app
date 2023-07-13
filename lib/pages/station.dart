import 'package:flutter/material.dart';
import '../pages/tabs/home.dart';

// 气象站详细数据页面,接收城市列表页传来的气象站id参数
class StationPage extends StatefulWidget {
  final String station_id;

  const StationPage({super.key, this.station_id = "54511"});

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
      body: Center(
        // child: Text("城市列表页内容:气象站id${widget.stationId}"),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (BuildContext context) {
                    return HomePage();
                  }), (route) => false);
                },
                child: const Text("返回到根路由/根页面"))
          ],
        ),
      ),
    );
  }
}
