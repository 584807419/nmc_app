import 'package:flutter/material.dart';
import './routers/routers.dart';
import 'package:yako_theme_switch/yako_theme_switch.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {


  const MainApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData(scaffoldBackgroundColor: Colors.black),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      //去掉debug图标
      title: '天气app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(centerTitle: true) // 标题全局居中
      ),
      // home: const HomePage(),

      // 命名路由
      initialRoute: "/", // 初始化路由,表示默认加载什么
      onGenerateRoute: onGenerateRoute,
      // routes: {"/":(context)=>const HomePage(),
      //           "/city_list":(context)=>const CityPage(),
      //           "/station_detail":(context)=>const StationPage(),},
    );
  }
}
