import 'package:chess/model/models.dart';
import 'package:flutter/material.dart';

import 'components.dart';

class BoardView extends StatefulWidget {
  const BoardView({super.key});

  @override
  State<BoardView> createState() => _BoardViewState();
}

class _BoardViewState extends State<BoardView> {
  final _chessboard = Chessboard.instance();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: 64,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),
        physics: const NeverScrollableScrollPhysics(),

        //*********************************************** */
        itemBuilder: (context, index) {
          int row = index ~/ 8;
          int col = index % 8;

          Square square = _chessboard.getSquare(row, col);

          return SquareWidget(
            square: square,
            onTap: () {
              setState(() {
                _chessboard.selectPiece(square: square, row: row, col: col);

              
              });
            },
          );
        }
        //********************************************* */

        );
  }
}
