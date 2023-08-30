import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      title: Text(
        title,
        semanticsLabel: title,
        style: const TextStyle(
          fontFamily: 'NanumGothic',
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      leading: onBack != null
          ? IconButton(
              icon: const Icon(Icons.arrow_back,
                  semanticLabel: '뒤로 가기', color: Colors.white),
              onPressed: onBack,
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
