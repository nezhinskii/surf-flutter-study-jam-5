import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:meme_generator/common_widget/common_dialog.dart';

class AddShapeDialog extends StatefulWidget {
  const AddShapeDialog({Key? key}) : super(key: key);

  @override
  State<AddShapeDialog> createState() => _AddShapeDialogState();
}

class _AddShapeDialogState extends State<AddShapeDialog> {
  final _controller = TextEditingController();
  Color _color = Colors.black;
  static const _shapes = [
    Icons.circle,
    Icons.rectangle,
    Icons.square,
    Icons.play_arrow,
    Icons.close,
    Icons.add,
    Icons.ac_unit,
    Icons.adb,
    Icons.favorite,
    Icons.flutter_dash_rounded,
    Icons.house,
    Icons.bed
  ];

  @override
  Widget build(BuildContext context) {
    return CommonDialog(
      title: 'Выберите цвет, затем иконку',
      body: SizedBox(
        width: min(MediaQuery.of(context).size.width - 40, 300),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: BlockPicker(
                  pickerColor: _color,
                  onColorChanged: (Color value) {
                    setState(() {
                      _color = value;
                    });
                  },
                  availableColors: const [
                    Colors.black,
                    Colors.white,
                    Colors.grey,
                    Colors.red,
                    Colors.green,
                    Colors.blue,
                    Colors.pink,
                    Colors.purple,
                    Colors.orange,
                    Colors.yellow,
                    Colors.cyan,
                    Colors.lime,
                  ],
                )
              ),
              const SizedBox(width: 15,),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop((_color, _shapes[index]));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        _shapes[index],
                        color: _color,
                        size: 35,
                      ),
                    ),
                  );
                },
                itemCount: _shapes.length,
              )
            ],
          ),
        ),
      ),
    );
  }
}
