import 'package:flutter/material.dart';
import 'package:movie_app/Constants/Colors.dart';

import '../Constants/Strings.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  final Function func;
  const TitleWidget(this.title, this.func, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: ColorConstants.blue,
              fontSize: 20,
              fontWeight: FontWeight.w600
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: (){
              func();
            },
            child: Text(
              Strings.viewAll,
              style: TextStyle(
                  color: ColorConstants.blue.withOpacity(0.6),
                  fontSize: 16,
                  fontWeight: FontWeight.w600
              ),
            ),
          ),
          Icon(Icons.arrow_forward_ios_sharp, color: ColorConstants.blue.withOpacity(0.6), size: 16)
        ],
      ),
    );
  }
}
