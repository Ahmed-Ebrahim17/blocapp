import 'package:blocapp/constants/my_colors.dart';
import 'package:blocapp/data/models/character.dart';
import 'package:flutter/material.dart';

class CharacterItem extends StatelessWidget {
  const CharacterItem({super.key, required this.result, required this.index});

  final Result result;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: MyColors.myWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: GridTile(
        footer: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          color: MyColors.myBlack,
          alignment: Alignment.bottomCenter,
          child: Text(
            result.name,
            style: const TextStyle(
              color: MyColors.myWhite,
              height: 1.3,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ),
        child: Container(
          color: MyColors.myGrey,
          child: result.image.isNotEmpty
              ? FadeInImage.assetNetwork(
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: "assets/images/loading-3.gif",
                  image: result.image,
                )
              : Image.asset("assets/images/emma_1.jpg"),
        ),
      ),
    );
  }
}
