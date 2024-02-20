import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:meme_generator/common_widget/common_dialog.dart';

class AddTextDialog extends StatefulWidget {
  const AddTextDialog({Key? key}) : super(key: key);

  @override
  State<AddTextDialog> createState() => _AddTextDialogState();
}

class _AddTextDialogState extends State<AddTextDialog> {
  final _controller = TextEditingController();
  Color _color = Colors.black;

  @override
  Widget build(BuildContext context) {
    return CommonDialog(
      title: 'Введите текст',
      body: SizedBox(
        width: min(MediaQuery.of(context).size.width - 40, 300),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: SingleChildScrollView(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        maxLines: null,
                        controller: _controller,
                        autofocus: true,
                        onSubmitted: (value) {
                          Navigator.of(context).pop((_controller.text, _color));
                        },
                      ),
                      const SizedBox(height: 20,),
                      SizedBox(
                        height: 170,
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
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 15,),
                GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Navigator.of(context).pop((_controller.text, _color));
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(left: 8, top: 8, bottom: 8),
                      child: Icon(Icons.arrow_forward_ios, size: 25,),
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
