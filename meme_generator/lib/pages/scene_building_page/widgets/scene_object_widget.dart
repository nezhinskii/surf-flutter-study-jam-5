import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meme_generator/models/scene_object.dart';
import 'package:meme_generator/models/transform_data.dart';

class SceneObjectWidget extends StatefulWidget {
  const SceneObjectWidget({
    Key? key,
    required this.object,
    required this.onMoveBack,
    required this.onMoveFront,
    required this.onDelete,
    required this.onTransformEnd
  }) : super(key: key);
  final SceneObject object;
  final Function() onDelete;
  final Function() onMoveFront;
  final Function() onMoveBack;
  final Function(TransformData) onTransformEnd;

  @override
  State<SceneObjectWidget> createState() => _SceneObjectWidgetState();
}

class _SceneObjectWidgetState extends State<SceneObjectWidget> {
  late final ValueNotifier<TransformData> _transformNotifier = ValueNotifier(widget.object.transformData);
  late TransformData _startTransform = widget.object.transformData;
  Offset _startFocalPoint = Offset.zero;

  void _onScaleStart(ScaleStartDetails details) {
    _startFocalPoint = details.focalPoint;
    _startTransform = _transformNotifier.value;
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    final translation = details.focalPoint - _startFocalPoint;
    _transformNotifier.value = _startTransform.copyWithDelta(
      translation: translation,
      rotation: details.rotation,
      scale: details.scale
    );
  }

  void _onScaleEnd(ScaleEndDetails details) {
    widget.onTransformEnd(_transformNotifier.value);
  }

  @override
  void didUpdateWidget(covariant SceneObjectWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _startTransform = widget.object.transformData;
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _transformNotifier,
        builder: (context, child) {
          return Transform.translate(
            offset: _transformNotifier.value.translation,
            child: Transform.rotate(
                angle: _transformNotifier.value.rotation,
                child: Transform.scale(
                    scale: _transformNotifier.value.scale,
                    child: child
                )
            ),
          );
        },
        child: GestureDetector(
          onLongPress: () {
            showModalBottomSheet(
              constraints: const BoxConstraints(
                maxHeight: 180
              ),
              context: context,
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            widget.onMoveFront.call();
                          },
                          behavior: HitTestBehavior.translucent,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Icon(Icons.layers_outlined, size: 30,),
                                const SizedBox(width: 15,),
                                Text('На передний план', style: Theme.of(context).textTheme.bodyLarge,),
                              ],
                            ),
                          )
                        ),
                        const Divider(height: 1,),
                        GestureDetector(
                          onTap:  () {
                            Navigator.of(context).pop();
                            widget.onMoveBack.call();
                          },
                          behavior: HitTestBehavior.translucent,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Icon(Icons.layers_clear_outlined, size: 30,),
                                const SizedBox(width: 15,),
                                Text('На задний план', style: Theme.of(context).textTheme.bodyLarge,),
                              ],
                            ),
                          )
                        ),
                        const Divider(height: 1,),
                        GestureDetector(
                          onTap:  () {
                            Navigator.of(context).pop();
                            widget.onDelete.call();
                          },
                          behavior: HitTestBehavior.translucent,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Icon(Icons.delete_outline, size: 30,),
                                const SizedBox(width: 15,),
                                Text('Удалить', style: Theme.of(context).textTheme.bodyLarge,),
                              ],
                            ),
                          )
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          onScaleStart: _onScaleStart,
          onScaleUpdate: _onScaleUpdate,
          onScaleEnd: _onScaleEnd,
          child: switch (widget.object){
            SceneNetworkImage(url: final url) => Image.network(url,),
            SceneLocalImage(path: final path) => Image.file(File(path)),
            SceneText(text: final text, color: final color) => Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
                color: color
              ),
            ),
            SceneShape(shape: final shape, color: final color) => Icon(
              shape,
              color: color,
              size: 80,
            ),
          }
        ),
      ),
    );
  }
}
