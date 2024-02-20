part of '../scene_building_page.dart';

class _ToolBar extends StatelessWidget {
  const _ToolBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _ToolBarItem(
          iconData: Icons.bolt,
          onTap: () {
            context.read<SceneBuildingCubit>().addShape(context);
          },
        ),
        _ToolBarItem(
          iconData: Icons.cloud_download_outlined,
          onTap: () {
            context.read<SceneBuildingCubit>().addNetworkImage(context);
          }
        ),
        _ToolBarItem(
          iconData: Icons.photo_library_outlined,
          onTap: () {
            context.read<SceneBuildingCubit>().addLocalImage();
          }
        ),
        _ToolBarItem(
          iconData: Icons.text_fields,
          onTap: () {
            context.read<SceneBuildingCubit>().addText(context);
          }
        )
      ],
    );
  }
}

class _ToolBarItem extends StatelessWidget {
  const _ToolBarItem({
    Key? key,
    required this.iconData,
    this.onTap,
  }) : super(key: key);
  final Function()? onTap;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(iconData, size: 35,),
      ),
    );
  }
}

