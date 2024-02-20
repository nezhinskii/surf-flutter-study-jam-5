import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meme_generator/models/scene.dart';
import 'package:meme_generator/pages/scene_building_page/widgets/add_network_image_dialog.dart';
import 'package:meme_generator/pages/scene_building_page/widgets/add_text_dialog.dart';
import 'package:meme_generator/services/interfaces/i_network_service.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

part 'scene_building_state.dart';

class SceneBuildingCubit extends Cubit<SceneBuildingState> {
  SceneBuildingCubit(Scene initialScene, this._networkService, this._widgetsToImageController) : super(SceneBuildingCommon(scene: initialScene));
  final INetworkService _networkService;
  final WidgetsToImageController _widgetsToImageController;

  WidgetsToImageController get widgetsToImageController => _widgetsToImageController;

  static const _errorNetworkImage = 'Не удалось найти картинку по указанной ссылке';
  static const _errorSharing = 'Не удалось экспортировать изображение, попробуйте еще раз';

  void addNetworkImage(BuildContext context) async {
    final url = await showDialog<String>(
      context: context,
      builder: (context) {
        return const AddNetworkImageDialog();
      },
    );
    if (url == null || url.isEmpty){
      return;
    }
    emit(SceneBuildingLoading(scene: state.scene));
    final isImage = await _networkService.isImageUrl(url);
    if (isImage){
      state.scene.addNetworkImage(url);
      emit(SceneBuildingCommon(scene: state.scene));
    } else {
      emit(SceneBuildingError(message: _errorNetworkImage, scene: state.scene));
    }
  }

  void addLocalImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null){
      state.scene.addLocalImage(image.path);
      emit(SceneBuildingCommon(scene: state.scene));
    }
  }

  void addText(BuildContext context) async {
    final result = await showDialog<(String, Color)>(
      context: context,
      builder: (context) {
        return const AddTextDialog();
      },
    );
    if (result == null || result.$1.isEmpty){
      return;
    }
    state.scene.addText(result.$1, result.$2);
    emit(SceneBuildingCommon(scene: state.scene));
  }

  void removeAt(int index){
    state.scene.removeAt(index);
    emit(SceneBuildingCommon(scene: state.scene));
  }

  void moveBackAt(int index) {
    state.scene.moveBackAt(index);
    emit(SceneBuildingCommon(scene: state.scene));
  }

  void moveFrontAt(int index) {
    state.scene.moveFrontAt(index);
    emit(SceneBuildingCommon(scene: state.scene));
  }

  void transformAt(int index, newTransformData) {
    state.scene.transformAt(index, newTransformData);
  }

  void share() async {
    emit(SceneBuildingLoading(scene: state.scene));
    try{
      final bytes = await _widgetsToImageController.capture();
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/meme.png');
      await file.writeAsBytes(bytes!);
      Share.shareXFiles([XFile(file.path)]);
      emit(SceneBuildingCommon(scene: state.scene));
    } catch (e){
      emit(SceneBuildingError(message: _errorSharing, scene: state.scene));
    }
  }
}
