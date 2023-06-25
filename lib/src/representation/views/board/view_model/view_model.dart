import 'package:flutter/foundation.dart';

import '../../../../model/models.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/constants_manager.dart';

void intializeBoard(Chessboard chessBoard) {
  chessBoard.squares = List<List<Square>>.generate(8, (row) {
    return List<Square>.generate(8, (col) {
      bool isLight = (row + col) % 2 == 0;
      Square square = Square(row, col, isLight ? 'light' : 'dark');

      return square;
    });
  });
  chessBoard.selectedPiece = {
    'currentRow': null,
    'currentCol': null,
    'nextRow': null,
    'nextCol': null,
  };

  // initialize black pieces
  for (int i = 0; i < 8; i++) {
    Square currentSquare = chessBoard.squares[1][i];
    currentSquare.piece.type = 'pawn';
    currentSquare.piece.imagePath = ImageAssets.pawn;
    currentSquare.piece.isWhite = false;
  }

  Piece rook1 = chessBoard.squares[0][0].piece;
  rook1.type = 'rook';
  rook1.imagePath = ImageAssets.rook;
  rook1.isWhite = false;

  Piece rook2 = chessBoard.squares[0][7].piece;
  rook2.type = 'rook';
  rook2.imagePath = ImageAssets.rook;
  rook2.isWhite = false;

  Piece knight1 = chessBoard.squares[0][1].piece;
  knight1.type = 'knight';
  knight1.imagePath = ImageAssets.knight;
  knight1.isWhite = false;

  Piece knight2 = chessBoard.squares[0][6].piece;
  knight2.type = 'knight';
  knight2.imagePath = ImageAssets.knight;
  knight2.isWhite = false;

  Piece bishop1 = chessBoard.squares[0][2].piece;
  bishop1.type = 'bishop';
  bishop1.imagePath = ImageAssets.bishop;
  bishop1.isWhite = false;

  Piece bishop2 = chessBoard.squares[0][5].piece;
  bishop2.type = 'bishop';
  bishop2.imagePath = ImageAssets.bishop;
  bishop2.isWhite = false;

  Piece queen = chessBoard.squares[0][3].piece;
  queen.type = 'queen';
  queen.imagePath = ImageAssets.queen;
  queen.isWhite = false;

  Piece king = chessBoard.squares[0][4].piece;
  king.type = 'king';
  king.imagePath = ImageAssets.king;
  king.isWhite = false;

  // intiialize white pieces
  for (int i = 0; i < 8; i++) {
    Square currentSquare = chessBoard.squares[6][i];
    currentSquare.piece.type = 'pawn';
    currentSquare.piece.imagePath = ImageAssets.pawn;
    currentSquare.piece.isWhite = true;
  }
  Piece brook1 = chessBoard.squares[7][0].piece;
  brook1.type = 'rook';
  brook1.imagePath = ImageAssets.rook;
  brook1.isWhite = true;

  Piece brook2 = chessBoard.squares[7][7].piece;
  brook2.type = 'rook';
  brook2.imagePath = ImageAssets.rook;
  brook2.isWhite = true;

  Piece bknight1 = chessBoard.squares[7][1].piece;
  bknight1.type = 'knight';
  bknight1.imagePath = ImageAssets.knight;
  bknight1.isWhite = true;

  Piece bknight2 = chessBoard.squares[7][6].piece;
  bknight2.type = 'knight';
  bknight2.imagePath = ImageAssets.knight;
  bknight2.isWhite = true;

  Piece bbishop1 = chessBoard.squares[7][2].piece;
  bbishop1.type = 'bishop';
  bbishop1.imagePath = ImageAssets.bishop;
  bbishop1.isWhite = true;

  Piece bbishop2 = chessBoard.squares[7][5].piece;
  bbishop2.type = 'bishop';
  bbishop2.imagePath = ImageAssets.bishop;
  bbishop2.isWhite = true;

  Piece bqueen = chessBoard.squares[7][3].piece;
  bqueen.type = 'queen';
  bqueen.imagePath = ImageAssets.queen;
  bqueen.isWhite = true;

  Piece bking = chessBoard.squares[7][4].piece;
  bking.type = 'king';
  bking.imagePath = ImageAssets.king;
  bking.isWhite = true;
}

class BoardViewModel with ChangeNotifier {
  late Chessboard chessboard;

  BoardViewModel() {
    chessboard = Chessboard(
      squares: [],
      selectedPiece: {},
      condidateMovesForCurrentSelectedPiece: [],
    );
    intializeBoard(chessboard);
  }

  void selectPiece(
      {required Square square, required int row, required int col}) {
    if (checkTurn(square)) {
      if ((chessboard.selectedPiece['currentRow'] == null &&
          chessboard.selectedPiece['currentCol'] == null)) {
        // Select taped square
        if (square.piece.type != 'empty') {
          square.isSelected = true;
          chessboard.selectedPiece['currentRow'] = row;
          chessboard.selectedPiece['currentCol'] = col;

          unmarkCondiateMoves(chessboard.condidateMovesForCurrentSelectedPiece);
          chessboard.condidateMovesForCurrentSelectedPiece =
              calculateValidMoves(piece: square.piece, row: row, col: col);
          markSquaresAsCondidateMove(
              chessboard.condidateMovesForCurrentSelectedPiece);
        }
      } else if ((chessboard.selectedPiece['nextRow'] == null &&
          chessboard.selectedPiece['nextCol'] == null)) {
        // Select another square even if it is the same one
        chessboard.selectedPiece['nextRow'] = row;
        chessboard.selectedPiece['nextCol'] = col;
      }

      if ((chessboard.selectedPiece['currentRow'] ==
              chessboard.selectedPiece['nextRow'] &&
          chessboard.selectedPiece['currentCol'] ==
              chessboard.selectedPiece['nextCol'])) {
        // User taped the same square So unselcet it

        square.isSelected = false;
        chessboard.selectedPiece['currentRow'] = null;
        chessboard.selectedPiece['currentCol'] = null;
        chessboard.selectedPiece['nextRow'] = null;
        chessboard.selectedPiece['nextCol'] = null;

        unmarkCondiateMoves(chessboard.condidateMovesForCurrentSelectedPiece);
      } else {
        Square otherSquare =
            chessboard.squares[chessboard.selectedPiece['currentRow']!]
                [chessboard.selectedPiece['currentCol']!];
        if (otherSquare.piece.isWhite == square.piece.isWhite &&
            square.piece.type != 'empty') {
          otherSquare.isSelected = false;
          square.isSelected = true;
          chessboard.selectedPiece['currentRow'] = row;
          chessboard.selectedPiece['currentCol'] = col;
          chessboard.selectedPiece['nextRow'] = null;
          chessboard.selectedPiece['nextCol'] = null;

          unmarkCondiateMoves(chessboard.condidateMovesForCurrentSelectedPiece);
          chessboard.condidateMovesForCurrentSelectedPiece =
              calculateValidMoves(piece: square.piece, row: row, col: col);
          markSquaresAsCondidateMove(
              chessboard.condidateMovesForCurrentSelectedPiece);
        } else {
          movePiece();
          chessboard.turn = chessboard.turn == 'white' ? 'black' : 'white';
          otherSquare.isSelected = false;
          chessboard.selectedPiece['currentRow'] = null;
          chessboard.selectedPiece['currentCol'] = null;
          chessboard.selectedPiece['nextRow'] = null;
          chessboard.selectedPiece['nextCol'] = null;
          unmarkCondiateMoves(chessboard.condidateMovesForCurrentSelectedPiece);
        }
      }
    }
    notifyListeners();
  }

  void markSquaresAsCondidateMove(List<Move> condidateMoves) {
    for (Move move in condidateMoves) {
      chessboard.squares[move.row][move.col].isSelected = true;
    }
  }

  void unmarkCondiateMoves(List<Move> condidateMoves) {
    for (Move move in condidateMoves) {
      chessboard.squares[move.row][move.col].isSelected = false;
    }
  }

  void movePiece() {
    int row = chessboard.selectedPiece['currentRow']!;
    int col = chessboard.selectedPiece['currentCol']!;
    int nextRow = chessboard.selectedPiece['nextRow']!;
    int nextCol = chessboard.selectedPiece['nextCol']!;
    placePiece(chessboard.squares[row][col].piece, nextRow, nextCol);
    chessboard.squares[row][col].piece = Piece.empty();
  }

  void placePiece(Piece piece, int row, int col) {
    chessboard.squares[row][col].piece = piece;
  }

  // Remove the piece from the square
  void removePiece(Piece piece) {
    piece = Piece.empty();
  }

  bool checkTurn(Square square) {
    bool ret;
    if (chessboard.selectedPiece['currentRow'] == null &&
        chessboard.selectedPiece['currentCol'] == null) {
      if (((square.piece.isWhite && chessboard.turn == 'white') ||
          (!square.piece.isWhite && chessboard.turn != 'white'))) {
        ret = true;
      } else {
        ret = false;
      }
    } else {
      var otherSquare =
          chessboard.squares[chessboard.selectedPiece['currentRow']!]
              [chessboard.selectedPiece['currentCol']!];
      if (otherSquare.piece.isWhite && chessboard.turn == 'white' ||
          !otherSquare.piece.isWhite && chessboard.turn != 'white') {
        ret = true;
      } else {
        ret = false;
      }
    }

    return ret;
  }

  bool isPositionIsInBoard(int row, int col) {
    //? checks if the given row and col are not outside the board
    if (row < 8 && col < 8 && row >= 0 && col >= 0) {
      return true;
    }
    return false;
  }

  bool isPositionContainTeammate(Piece piece, int row, int col) {
    //? check if the postion containes a piece from the same team

    Piece positionPiece = chessboard.squares[row][col].piece;
    if (positionPiece.type == 'empty') {
      return false;
    } else if (piece.isWhite == positionPiece.isWhite) {
      return true;
    } else {
      return false;
    }
  }

  List<Move> calculateValidMoves(
      {required Piece piece, required int row, required int col}) {
    List<Move> moves = [];
    int tr;
    int tl;
    // if pawn
    switch (piece.type) {
      case 'pawn':
        for (Move move in ConstantsManager.pawnMoves) {
          tr = row + move.row;
          tl = col + move.col;
          if (isPositionIsInBoard(tr, tl)) {
            if (!isPositionContainTeammate(piece, tr, tl)) {
              // paww can one square diagnolly only if there is a piece to capture
              if (chessboard.squares[tr][tl].piece.isWhite !=
                  chessboard.squares[row][col].piece.isWhite) {
                moves.add(Move(row: tr, col: tl));
              }
            }
          }
        }
        break;
      case 'knight':
        for (Move move in ConstantsManager.nightMoves) {
          tr = row + move.row;
          tl = col + move.col;
          if (isPositionIsInBoard(tr, tl)) {
            if (!isPositionContainTeammate(piece, tr, tl)) {
              moves.add(Move(row: tr, col: tl));
            }
          }
        }
        break;
      // case 'bishop':
      //   for (var move in ConstantsManager.bishopMoves) {
      //     tr = row;
      //     tl = col;
      //     theWhile:
      //     while ((tr*-1)<8 &&(tl*-1)<8
      //         ) {
      //       tr += move.row;
      //       tl += move.col;
      //       if (isPositionIsInBoard(tr, tl)) {
      //         if (!isPositionContainTeammate(piece, tr, tl)) {
      //           moves.add(Move(row: tr, col: tl));
      //         } else {
      //           // there is a teamate blocking
      //           break theWhile;
      //         }
      //       } else {
      //         // on edge of the bord
      //         break theWhile;
      //       }
      //       tr = row;
      //       tl = col;
      //     }
      //   }
      //   break;
        

    }
        return moves;
  }

  // get the information abut the selected piece in the format of a map
  Map<String, int?> get getSelectedPiece => chessboard.selectedPiece;

  // get A _chessboard.squares info via it's row and col values
  Square getSquare(int row, int col) {
    return chessboard.squares[row][col];
  }
}
