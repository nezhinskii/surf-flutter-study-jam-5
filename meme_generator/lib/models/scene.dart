import 'package:flutter/material.dart';
import 'package:meme_generator/models/scene_object.dart';
import 'package:meme_generator/models/transform_data.dart';

class Scene{
  final List<SceneObject> _objects;
  Color backgroundColor;
  Scene(this._objects, this.backgroundColor);
  
  Scene.empty(): _objects = [], backgroundColor = Colors.black;
  
  List<SceneObject> get objects => _objects;
  
  void addNetworkImage(String url){
    _objects.add(
      SceneNetworkImage(
        transformData: const TransformData.identity(),
        url: url
      )
    );
  }

  void addLocalImage(String path) {
    _objects.add(
      SceneLocalImage(
        transformData: const TransformData.identity(),
        path: path
      )
    );
  }

  void addText(String text, Color color) {
    _objects.add(
      SceneText(
        transformData: const TransformData.identity(),
        text: text,
        color: color
      )
    );
  }

  void addShape(Color color, IconData shape) {
    _objects.add(
      SceneShape(
        transformData: const TransformData.identity(),
        shape: shape,
        color: color
      )
    );
  }

  void removeAt(int index) {
    _objects.removeAt(index);
  }

  void moveBackAt(int index) {
    final moved = _objects.removeAt(index);
    _objects.insert(0, moved);
  }

  void moveFrontAt(int index) {
    final moved = _objects.removeAt(index);
    _objects.add(moved);
  }

  void transformAt(int index, TransformData newTransformData) {
    _objects[index].transformData = newTransformData;
  }
  
}