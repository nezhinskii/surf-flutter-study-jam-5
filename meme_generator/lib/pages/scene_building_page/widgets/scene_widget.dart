import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meme_generator/models/scene.dart';
import 'package:meme_generator/pages/scene_building_page/cubit/scene_building_cubit.dart';
import 'package:meme_generator/pages/scene_building_page/widgets/scene_object_widget.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class SceneWidget extends StatelessWidget {
  const SceneWidget({
    Key? key,
    required this.scene,
    required this.bottomPadding,
    required this.widgetsToImageController
  }) : super(key: key);
  final Scene scene;
  final WidgetsToImageController widgetsToImageController;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            height: constraints.maxHeight - bottomPadding,
            child: WidgetsToImage(
              controller: widgetsToImageController,
              child: ColoredBox(
                color: scene.backgroundColor,
                child: Stack(
                  fit: StackFit.expand,
                  children: List.generate(
                    scene.objects.length,
                    (index) {
                      return SceneObjectWidget(
                        key: ValueKey(scene.objects[index]),
                        object: scene.objects[index],
                        onDelete: () {
                          context.read<SceneBuildingCubit>().removeAt(index);
                        },
                        onMoveBack: () {
                          context.read<SceneBuildingCubit>().moveBackAt(index);
                        },
                        onMoveFront: () {
                          context.read<SceneBuildingCubit>().moveFrontAt(index);
                        },
                        onTransformEnd: (newTransformData) {
                          context.read<SceneBuildingCubit>().transformAt(index, newTransformData);
                        },
                      );
                    }
                  )
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
