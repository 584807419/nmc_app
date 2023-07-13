import 'package:flutter/material.dart';

// 城市列表页面
class CityPage extends StatefulWidget {
  //其他页面跳转过来路由传值
  final Map arguments;
  // final String cityName;
  // final String stationId;

  const CityPage({super.key, required this.arguments});

  @override
  State<CityPage> createState() => _CityPage();
}

class _CityPage extends State<CityPage> {
  @override
  void initState() {
    super.initState();
    print(widget.arguments);
    // print(widget.stationId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("城市:${widget.arguments}列表页面"),
      ),
      body: Center(
        // child: Text("城市列表页内容:气象站id${widget.stationId}"),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){Navigator.pushNamed(context, "/station_detail");},
                child:const Text("跳转到气象站详情")
            ),
            const SizedBox(height: 20,),
            ElevatedButton(onPressed: (){Navigator.of(context).pop();},
                child:const Text("返回上一级")
            ),
          const SizedBox(height: 20,),
          ElevatedButton(onPressed: (){Navigator.of(context).pushReplacementNamed("/station_detail");},
          child:const Text("替换路由,直接替换掉当前页面"))
          ],
        ),
      ),
    );
  }
}
