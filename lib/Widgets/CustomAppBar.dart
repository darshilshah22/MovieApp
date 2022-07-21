import 'package:flutter/material.dart';
import 'package:movie_app/Constants/Colors.dart';

import '../Constants/Strings.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const Icon(Icons.menu),
      title: const Text(Strings.hello),
      actions: [
        Image.asset("assets/icons/search.png", height: 20, color: ColorConstants.blue),
      ],
    );
  }
}
