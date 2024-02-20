import 'dart:math';

import 'package:flutter/material.dart';

class CommonDialog extends StatelessWidget {
  const CommonDialog({
    Key? key,
    required this.title,
    required this.body
  }) : super(key: key);
  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            body
          ],
        ),
      ),
    );
  }
}
