import 'package:flutter/gestures.dart';

class TransformData{
  final Offset translation;
  final double rotation;
  final double scale;

  const TransformData({
    required this.rotation,
    required this.translation,
    required this.scale,
  });

  TransformData copyWithDelta({
    double? rotation,
    Offset? translation,
    double? scale,
  }) => TransformData(
    rotation: this.rotation + (rotation ?? 0.0),
    translation: this.translation + (translation ?? Offset.zero),
    scale: this.scale * (scale ?? 1.0) ,
  );

  const TransformData.identity(): translation = Offset.zero, rotation = 0, scale = 1.0;
}