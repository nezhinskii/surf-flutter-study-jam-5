part of 'scene_building_cubit.dart';

@immutable
sealed class SceneBuildingState {
  const SceneBuildingState({
    required this.scene
  });
  final Scene scene;
}

class SceneBuildingCommon extends SceneBuildingState {
  const SceneBuildingCommon({
    required super.scene
  });
}

class SceneBuildingLoading extends SceneBuildingState {
  const SceneBuildingLoading({
    required super.scene
  });
}

class SceneBuildingError extends SceneBuildingState {
  final String message;
  const SceneBuildingError({
    required this.message,
    required super.scene
  });
}
