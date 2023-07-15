import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert' show json;

// 自定义组件
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> provinceList = [];

  void getHttp() async {
    if (kDebugMode) {
      print("发送请求 http://localhost:81/province");
    }
    Response response = await Dio().get('http://localhost:81/province');
    List tempList = [];

    tempList = json.decode(response.toString())["data"]["list"];
    for (var i = 0; i < tempList.length; i++) {
      provinceList.add(
        Container(
          margin: EdgeInsets.all(5),
          child: ElevatedButton(
              onPressed: () {
                // 跳转路由
                Navigator.pushNamed(context, "/city_list",
                    arguments: {"name": "${tempList[i]["name"]}", "stationid": 2000000});
              },
              style:ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.lightBlueAccent,
                shadowColor: Colors.blueAccent,
                elevation: 10,
              ),
              child: Text(
                "${tempList[i]["name"]}",
                style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),)),
        )
        );
    }
    setState(() {

    });
  }

  @override
  void initState() {
    getHttp();
    super.initState();
    // print(widget.arguments);
    // print(widget.stationId);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // 左侧按钮图标
        leading: IconButton(
          icon: const Icon(Icons.sunny),
          onPressed: () {
            print("返回首页");
          },
        ),
        // 导航背景颜色
        backgroundColor: Colors.lightBlueAccent,
        title: const Text("免费天气数据"),
        // 右侧按钮图标
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              print("搜索");
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_horiz),
            onPressed: () {
              print("更多");
            },
          ),
        ],
      ),
      body: GridView.extent(
        maxCrossAxisExtent: 110.0,
        childAspectRatio: 1.0,
        children: provinceList.isNotEmpty?provinceList:[const Icon(Icons.not_interested)],
      ),
      // body: Center(
      //   child: Column(
      //     // 使其位于正中位置
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       // ElevatedButton(
      //       //     onPressed: () {
      //       //       // 跳转路由
      //       //       Navigator.of(context)
      //       //           .push(MaterialPageRoute(builder: (BuildContext context) {
      //       //         return const CityPage(cityName: "上海", stationId: "11111111111");
      //       //       }));
      //       //     },
      //       //     child: Text("基本路由跳转")),
      //       const SizedBox(
      //         height: 20,
      //       ),
      //       ElevatedButton(
      //           onPressed: () {
      //             // 跳转路由
      //             Navigator.pushNamed(context, "/city_list",arguments: {"name":"兴城","stationid":111});
      //           },
      //           child: const Text("命名路由跳转")),
      //       const SizedBox(
      //         height: 20,
      //       ),
      //       ElevatedButton(
      //           onPressed: () {
      //             // 跳转路由
      //             Navigator.pushNamed(context, "/city_list",arguments: {"name":"新乡","stationid":2000000});
      //           },
      //           child: const Text("命名路由传值")),
      //     ],
      //   ),
      // ),
    );
  }
}
