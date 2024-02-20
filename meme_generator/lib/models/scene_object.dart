import 'dart:ui';

import 'package:meme_generator/models/transform_data.dart';

sealed class SceneObject{
  TransformData get transformData;
  set transformData(TransformData newTransformData);
}

class SceneNetworkImage extends SceneObject{
  @override
  TransformData transformData;
  final String url;

  SceneNetworkImage({
    required this.transformData,
    required this.url
  });
}

class SceneLocalImage extends SceneObject{
  @override
  TransformData transformData;
  final String path;

  SceneLocalImage({
    required this.transformData,
    required this.path
  });
}

class SceneText extends SceneObject{
  @override
  TransformData transformData;
  final String text;
  final Color color;

  SceneText({
    required this.transformData,
    required this.text,
    required this.color
  });
}