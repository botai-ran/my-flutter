import 'package:flutter/material.dart';

// 导出
export 'paint_bar.dart' show PaintBar;

class PaintBar extends StatefulWidget {
  final VoidCallback? onUndo;
  final VoidCallback? onRedo;
  final VoidCallback? onDelete;


  // 接收传入的参数
  const PaintBar({
    super.key,
    this.onUndo,
    this.onRedo,
    this.onDelete,
  });

  @override
  State<PaintBar> createState() => _PaintBarState();
}

class _PaintBarState extends State<PaintBar> {

  @override
  Widget build(BuildContext context) {
 
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // 上一步
            IconButton(
              onPressed: widget.onUndo,
              icon: const Icon(Icons.undo),
            ),
            // 下一步
            IconButton(
              onPressed: widget.onRedo,
              icon: const Icon(Icons.redo),
            ),
          ],
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 画笔
            Text('画板绘制'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // 删除
            IconButton(
              onPressed: widget.onDelete,
              icon: const Icon(Icons.delete_forever),
              iconSize: 30,
            ),
          ],
        ),
      ],
    );
  }
}
