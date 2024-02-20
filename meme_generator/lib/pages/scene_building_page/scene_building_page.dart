import 'package:circular_menu/circular_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meme_generator/models/scene.dart';
import 'package:meme_generator/pages/scene_building_page/cubit/scene_building_cubit.dart';
import 'package:meme_generator/common_widget/common_dialog.dart';
import 'package:meme_generator/pages/scene_building_page/widgets/add_network_image_dialog.dart';
import 'package:meme_generator/pages/scene_building_page/widgets/scene_object_widget.dart';
import 'package:meme_generator/pages/scene_building_page/widgets/scene_widget.dart';
import 'package:meme_generator/services/network_service.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

part 'widgets/tool_bar_menu.dart';

class MemeGeneratorScreen extends StatelessWidget {
  const MemeGeneratorScreen({Key? key}) : super(key: key);
  static const _toolBarHeight = 60.0;

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return BlocProvider(
      create: (context) => SceneBuildingCubit(Scene.empty(), NetworkService(), WidgetsToImageController()),
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(_toolBarHeight + topPadding),
            child: Padding(
              padding:  EdgeInsets.only(top: topPadding),
              child: Builder(
                builder: (context) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.read<SceneBuildingCubit>().updateBackgroundColor(context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(Icons.palette, size: 35,),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.read<SceneBuildingCubit>().share();
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(Icons.share, size: 35,),
                        ),
                      )
                    ],
                  );
                }
              ),
            ),
          ),
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .background,
          body: Stack(
            fit: StackFit.expand,
            children: [
              BlocBuilder<SceneBuildingCubit, SceneBuildingState>(
                builder: (context, state) => Align(
                  alignment: Alignment.topCenter,
                  child: SceneWidget(
                    bottomPadding: _toolBarHeight,
                    scene: state.scene,
                    widgetsToImageController: context.read<SceneBuildingCubit>().widgetsToImageController,
                  )
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Theme.of(context).colorScheme.background,
                  height: _toolBarHeight,
                  child: const _ToolBar(),
                ),
              ),
              BlocConsumer<SceneBuildingCubit, SceneBuildingState>(
                listener: (context, state) {
                  if (state is SceneBuildingError){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Theme.of(context).colorScheme.error,
                        content: Text(state.message),
                      )
                    );
                  }
                },
                builder: (context, state) => switch(state){
                  SceneBuildingLoading() => ColoredBox(
                    color: Theme.of(context).colorScheme.background.withOpacity(0.4),
                    child: const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                      ),
                    ),
                  ),
                  _ => const SizedBox.shrink(),
                },
              )
            ],
          )
      ),
    );
  }
}