import 'dart:math';
import 'package:flutter/material.dart';

// 导出
export 'guess_number_page.dart' show GuessNumberPage;

class GuessNumberPage extends StatefulWidget {
  const GuessNumberPage({super.key});

  @override
  State<GuessNumberPage> createState() => _GuessNumberPageState();
}

class _GuessNumberPageState extends State<GuessNumberPage> {
  // 随机的数字
  int _randomCounter = Random().nextInt(100);
  // 比较的数字
  int? _counter;
  // 输入的数字
  String? inputCounter;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // 确定按钮的点击事件
    void handlePressedSure() {
      if (inputCounter != null && inputCounter!.isNotEmpty) {
        setState(() {
          _counter = int.parse(inputCounter!);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('请输入数字')),
        );
      }
    }

    void handlePressedReset() {
      setState(() {
        // 生成随机数字
        _randomCounter = Random().nextInt(100);
        _counter = null;
        // 清除TextField的值
        _controller.clear();
        inputCounter = null;
      });
    }

    String getResult() {
      if (_counter == null) {
        return '';
      }
      if (_randomCounter == _counter) {
        return '恭喜你，猜对了，数字就是$_counter';
      }
      return '数字猜${_counter! > _randomCounter ? '大' : '小'}了';
    }

    void handleChange(value) {
      setState(() {
        inputCounter = value;
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.tertiaryFixedDim,
        // 设置居中
        centerTitle: true,
        title: const Text('猜数字'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              onChanged: handleChange,
              decoration: const InputDecoration(hintText: '请输入数字'),
            ),
            const Text('猜一下这个数字是多少吧(100以内哦):'),
            Text(
              _randomCounter == _counter ? '$_counter' : '**',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              getResult(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                onPressed: handlePressedSure,
                child: const Text('确定'),
              ),
              ElevatedButton(
                onPressed: handlePressedReset,
                child: const Text('重新生成'),
              )
            ])
          ],
        ),
      ),
    );
  }
}
