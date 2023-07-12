import 'package:flutter/material.dart';
import '../city.dart';

// 自定义组件
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> list = [];

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
      body: Center(child: Column(
        // 使其位于正中位置
        mainAxisAlignment: MainAxisAlignment.center,
        children: [ElevatedButton(onPressed: () {
          // 跳转路由
          Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) {
                return CityPage();
              })
          );
        }, child: Text("跳转到城市页面"))
        ],
      ),),
    );
  }
}
