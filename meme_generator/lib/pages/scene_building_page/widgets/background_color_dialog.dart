import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:meme_generator/common_widget/common_dialog.dart';

class BackgroundColorDialog extends StatefulWidget {
  const BackgroundColorDialog({Key? key, required this.initialColor, required this.onChange}) : super(key: key);
  final Color initialColor;
  final Function(Color) onChange;

  @override
  State<BackgroundColorDialog> createState() => _BackgroundColorDialogState();
}

class _BackgroundColorDialogState extends State<BackgroundColorDialog> {
  late Color _color = widget.initialColor;

  @override
  Widget build(BuildContext context) {
    return CommonDialog(
      title: 'Выберите цвет',
      body: BlockPicker(
        pickerColor: _color,
        onColorChanged: (Color value) {
          setState(() {
            _color = value;
          });
          widget.onChange.call(value);
        },
      ),
    );
  }
}
