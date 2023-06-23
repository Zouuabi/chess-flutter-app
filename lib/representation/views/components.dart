import 'package:chess/representation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../model/models.dart';
import '../resources/assets_manager.dart';

AppBar getAppBar() {
  return AppBar(
    elevation: 4,
    backgroundColor: Colors.teal,
    title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      SvgPicture.asset(
        ImageAssets.queen,
        width: 50,
        height: 50,
      ),
      SvgPicture.asset(
        ImageAssets.king,
        width: 50,
        height: 50,
      ),
    ]),
  );
}

class SquareWidget extends StatelessWidget {
  const SquareWidget({
    super.key,
    required this.square,
    required this.onTap,
  });

  final Square square;

  final VoidCallback onTap;

  Color _getSquareColor() {
    Color color;
    if (square.isSelected) {
      color = Colors.blue;
    } else if (square.color == 'light') {
      color = AppColors.secondaryColor;
    } else {
      color = AppColors.primaryColor;
    }
    return color;
  }

  Widget? _getSquarechild() {
    if (square.piece.type == 'empty') {
      return null;
    } else {
      return SvgPicture.asset(square.piece.imagePath!,
          color: square.piece.isWhite
              ? AppColors.lightPiecesColor
              : AppColors.darkPiecesColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        
          decoration: BoxDecoration(color: _getSquareColor()),
          child: _getSquarechild()),
    );
  }
}

class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //! you have to remove the const keyword
    return const Row(
      children: [
        Card(
          color: AppColors.lightPiecesColor,
          child: Icon(
            Icons.person,
            size: 60,
          ),
        ),
        Text(
          'openent',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

class TimeIndicator extends StatelessWidget {
  const TimeIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //! remove const
    return const Card(
      elevation: 4,
      color: AppColors.primaryColor,
      child: Text('10:00',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
    );
  }
}
