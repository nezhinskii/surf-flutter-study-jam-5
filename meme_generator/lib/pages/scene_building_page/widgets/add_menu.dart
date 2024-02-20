part of '../scene_building_page.dart';

class _AddMenu extends StatelessWidget {
  const _AddMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _MenuItem(
          iconData: Icons.cloud_download_outlined,
          onTap: () {
            context.read<SceneBuildingCubit>().addNetworkImage(context);
          }
        ),
        _MenuItem(
          iconData: Icons.photo_library_outlined,
          onTap: () {
            context.read<SceneBuildingCubit>().addLocalImage();
          }
        ),
        _MenuItem(
          iconData: Icons.text_fields,
          onTap: () {
            context.read<SceneBuildingCubit>().addText(context);
          }
        )
      ],
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({
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

