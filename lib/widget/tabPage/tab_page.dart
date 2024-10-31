import 'package:flutter/material.dart';

import '../../view/guess/guess_number_page.dart';
import '../../view/home/home_page.dart';
import '../../view/paint/paint_page.dart';
import '../../view/request/request_page.dart';

class TabPage extends StatefulWidget {
  const TabPage({super.key});

  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  final List<BottomNavigationBarItem> tabItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
    const BottomNavigationBarItem(icon: Icon(Icons.numbers), label: '猜数字'),
    const BottomNavigationBarItem(icon: Icon(Icons.piano), label: '画图'),
    const BottomNavigationBarItem(icon: Icon(Icons.request_page), label: '请求'),
  ];

  final List tabPages = [
    const MyHomePage(),
    const GuessNumberPage(),
    const PaintPage(),
    const RequestPage(),
  ];
  int currentIndex = 0;
  var currentPage;
  @override
  void initState() {
    super.initState();
    currentPage = tabPages[currentIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: tabItems,
        onTap: (index) {
          setState(() {
            currentIndex = index;
            currentPage = tabPages[index];
          });
        },
      ),
      body: currentPage,
    );
  }
}
