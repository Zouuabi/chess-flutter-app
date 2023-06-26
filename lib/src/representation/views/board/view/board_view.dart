import 'package:chess/src/representation/views/board/view_model/view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../model/models.dart';
import '../../../resources/constants_manager.dart';
import 'components.dart';

class BoardView extends StatelessWidget {
  const BoardView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BoardViewModel(),
      child: GridView.builder(
          itemCount: ConstantsManager.boardLength,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 8),
          physics: const NeverScrollableScrollPhysics(),

          //*********************************************** */
          itemBuilder: (context, index) {
            int row = index ~/ 8;
            int col = index % 8;

            return Consumer<BoardViewModel>(
              builder: (ctx, boardViewModel, _) {
                Square square = boardViewModel.getSquare(row, col);
                return SquareWidget(
                  square: square,
                  onTap: () {
                    boardViewModel.selectPiece(
                        square: square, row: row, col: col);
                  },
                );
              },
            );
          }
          //********************************************* */

          ),
    );
  }
}
