import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// 导出
export 'request_page.dart' show RequestPage;

class RequestPage extends StatefulWidget {
  const RequestPage({super.key});

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {

  @override
  Widget build(BuildContext context) {

    String str = '';
 
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.tertiaryFixedDim,
        // 设置居中
        centerTitle: true,
        title: const Text('请求'),
      ),
      body: Column(
        children: [
          Text(str),
          GestureDetector(
            child: const Text('点击发送请求'),
            // 点击
            onTap: () async {
              // 获取数据
              var res = await http.Client().get(Uri.parse('http://localhost:3000/'));
              // 显示数据
              setState(() {
                str = res.body;
              });
            },
          )
        ],
      )
    );
  }
}
