import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/paint/paint_bar.dart';
import 'package:flutter_application_1/view/paint/paper_painter.dart';

import 'color_selector.dart';
import 'model.dart';
import 'stork_width_selector.dart';

// 导出
export 'paint_page.dart' show PaintPage;

class PaintPage extends StatefulWidget {
  const PaintPage({super.key});

  @override
  State<PaintPage> createState() => _PaintPageState();
}

class _PaintPageState extends State<PaintPage> {
  List<Line> _lines = []; // 线列表
  int _currentIndex = -1;
  // 支持的颜色
  final List<Color> supportColors = [
    Colors.black,
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ];

  int colorActiveIndex = 0;

  // 支持的线粗
  final List<double> supportStorkWidths = [1, 2, 4, 6, 8, 10];

  int storkWidthActiveIndex = 0;


  @override
  Widget build(BuildContext context) {
final screenSize = MediaQuery.of(context).size;
    void _onPressed() {
      // 消息提示
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('点击了按钮'),
          action: SnackBarAction(
            label: '关闭',
            onPressed: () {
              // 关闭消息提示
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ),
      );

    }

    void _onPanStart(DragStartDetails details) {
      setState(() {
        if (_lines.isNotEmpty && _lines.length != _currentIndex + 1) {
          _lines = _lines.sublist(0, _currentIndex + 1);
        }
        _lines.add(Line(points: [details.localPosition], color: supportColors[colorActiveIndex], strokeWidth: supportStorkWidths[storkWidthActiveIndex]));
        _currentIndex = _lines.length - 1;
      });
    }
    void _onPanUpdate(DragUpdateDetails details) {
      if (_lines.isEmpty) {
        // 处理 _lines 为空或 _lines.last 为 null 的情况
        print('Error: _lines is empty or _lines.last is null');
        return;
      }
      setState(() {
        _lines[_lines.length - 1].points.add(details.localPosition);
      });
    }
    
    void handleDelete() {
      setState(() {
        _lines = [];
      });
    }
    void handleUndo() {
      setState(() {
        if (_lines.isEmpty) {
          return;
        }
        _currentIndex = _currentIndex - 1 < -1 ? -1 : _currentIndex - 1;
      });
    }

    void handleRedo() {
      setState(() {
        // _lines.removeLast();
        _currentIndex = _currentIndex + 1 > _lines.length - 1 ? _lines.length - 1 : _currentIndex + 1;
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.tertiaryFixedDim,
        // 设置居中
        centerTitle: true,
        title: PaintBar(
          onDelete: handleDelete,
          onUndo: _lines.isEmpty || _currentIndex < 0 ? null : handleUndo,
          onRedo: _lines.isEmpty || _currentIndex >= _lines.length - 1 ? null : handleRedo
        ),
      ),
      body: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: GestureDetector(
                // 设置高度
                onPanStart: _onPanStart,
                onPanUpdate: _onPanUpdate,
                child: CustomPaint(
                    // 设置宽高
                    size: Size(screenSize.width, screenSize.height - 80),
                    painter: PaperPainter(lines: _lines.isNotEmpty ? _lines.sublist(0, _currentIndex + 1) : []),
                  ), 
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: Container(
                // 设置背景颜色
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiaryFixedDim,
                ),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ColorSelector(
                  supportColors: supportColors,
                  activeIndex: colorActiveIndex,
                  onSelect: (index) {
                    setState(() {
                      colorActiveIndex = index;
                    });
                  },
                ),
                StorkWidthSelector(
                  activeIndex: storkWidthActiveIndex,
                  supportStorkWidths: supportStorkWidths,
                  color: supportColors[colorActiveIndex],
                  onSelect: (index) {
                    setState(() {
                      storkWidthActiveIndex = index;
                    });
                  },
                )
                ],
              )
              ),
            )
          ],
        ),
      )
    );
  }
}

