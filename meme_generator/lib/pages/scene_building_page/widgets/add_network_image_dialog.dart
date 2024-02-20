import 'dart:math';
import 'package:flutter/material.dart';
import 'package:meme_generator/common_widget/common_dialog.dart';

class AddNetworkImageDialog extends StatefulWidget {
  const AddNetworkImageDialog({Key? key}) : super(key: key);

  @override
  State<AddNetworkImageDialog> createState() => _AddNetworkImageDialogState();
}

class _AddNetworkImageDialogState extends State<AddNetworkImageDialog> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CommonDialog(
      title: 'Укажите ссылку на изображение',
      body: SizedBox(
        width: min(MediaQuery.of(context).size.width - 40, 300),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  autofocus: true,
                  onSubmitted: (value) {
                    Navigator.of(context).pop(_controller.text);
                  },
                ),
              ),
              const SizedBox(width: 15,),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  Navigator.of(context).pop(_controller.text);
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
    );
  }
}
