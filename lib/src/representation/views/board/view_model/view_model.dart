import 'package:flutter/foundation.dart';

import '../../../../model/models.dart';

import '../../../resources/constants_manager.dart';
import 'board_initializer.dart';

class BoardViewModel with ChangeNotifier {
  late Chessboard chessboard;

  BoardViewModel() {
    chessboard = Chessboard(
      squares: [],
      selectedPiece: {},
      valideMoves: [],
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

          unmarkCondiateMoves(chessboard.valideMoves);
          chessboard.valideMoves =
              calculateValidMoves(piece: square.piece, row: row, col: col);
          markSquaresAsCondidateMove(chessboard.valideMoves);
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

        unmarkCondiateMoves(chessboard.valideMoves);
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

          unmarkCondiateMoves(chessboard.valideMoves);
          chessboard.valideMoves =
              calculateValidMoves(piece: square.piece, row: row, col: col);
          markSquaresAsCondidateMove(chessboard.valideMoves);
        } else {
          bool checker = false;
          looping:
          for (Move move in chessboard.valideMoves) {
            if (move.row == chessboard.selectedPiece['nextRow'] &&
                move.col == chessboard.selectedPiece['nextCol']) {
              checker = true;
              break looping;
            }
          }
          if (checker) {
            movePiece();
            chessboard.turn = chessboard.turn == 'white' ? 'black' : 'white';
          }
          otherSquare.isSelected = false;
          chessboard.selectedPiece['currentRow'] = null;
          chessboard.selectedPiece['currentCol'] = null;
          chessboard.selectedPiece['nextRow'] = null;
          chessboard.selectedPiece['nextCol'] = null;
          unmarkCondiateMoves(chessboard.valideMoves);
        }
      }
      notifyListeners();
    }
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

  void removePiece(Piece piece) {
    piece = Piece.empty();
  }

  bool checkAnalyzer() {
    
    for (int i = 0; i < 8; ++i) {
      for (int j = 0; j < 8; ++j) {}
    }

    for (int i = 0; i < 8; ++i) {
      for (int j = 0; j < 8; ++j) {
        Square currentSquare = chessboard.squares[i][j];
        if ((currentSquare.piece.isWhite && chessboard.turn == 'white') ||
            (!currentSquare.piece.isWhite && chessboard.turn != 'white')) {
          // ignore: unused_local_variable
          List<Move> validemoves = calculateValidMoves(
              piece: chessboard.squares[i][j].piece, row: i, col: j);
        }
      }
    }
    return true;
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

  bool isSquareOnBoard(int row, int col) {
    //? checks if the given row and col are not outside the board
    if (row < 8 && col < 8 && row >= 0 && col >= 0) {
      return true;
    }
    return false;
  }

  bool isSquareEmpty(int row, int col) {
    if (chessboard.squares[row][col].piece.type == 'empty') {
      return true;
    } else {
      return false;
    }
  }

  bool isTeammateHere(Piece piece, int row, int col) {
    Piece positionPiece = chessboard.squares[row][col].piece;
    if (piece.isWhite == positionPiece.isWhite &&
        positionPiece.type != 'empty') {
      return true;
    } else {
      return false;
    }
  }

  bool isEnemieHere(Piece piece, int row, int col) {
    Piece positionPiece = chessboard.squares[row][col].piece;
    if (piece.isWhite != positionPiece.isWhite &&
        positionPiece.type != 'empty') {
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
        // todo: en passant feature
        int blackOrWhite = piece.isWhite ? -1 : 1;
        List<Move> pawnmoves = [];
        // move forward one step
        pawnmoves.add(Move(row: row + blackOrWhite, col: col));
        // move forward 2 steps if it is your first time
        if ((piece.isWhite && row == 6) ||
            (!piece.isWhite && row == 1) &&
                isSquareEmpty(row + blackOrWhite, col)) {
          pawnmoves.add(Move(row: row + 2 * blackOrWhite, col: col));
        }
        for (Move move in pawnmoves) {
          if (isSquareOnBoard(move.row, move.col) &&
              !isTeammateHere(piece, move.row, move.col) &&
              !isEnemieHere(piece, move.row, move.col)) {
            moves.add(move);
          }
        }
        // move diagnolly if there is enemy to capture
        tr = row + blackOrWhite;
        tl = col - 1;
        if (isSquareOnBoard(tr, tl)) {
          if (isEnemieHere(piece, tr, tl)) {
            moves.add(Move(row: tr, col: tl));
          }
        }
        tl = col + 1;
        if (isSquareOnBoard(tr, tl)) {
          if (isEnemieHere(piece, tr, tl)) {
            moves.add(Move(row: tr, col: tl));
          }
        }

        break;
      case 'knight':
        for (Move move in ConstantsManager.nightMoves) {
          tr = row + move.row;
          tl = col + move.col;
          if (isSquareOnBoard(tr, tl)) {
            if (isSquareEmpty(tr, tl) || isEnemieHere(piece, tr, tl)) {
              moves.add(Move(row: tr, col: tl));
            }
          }
        }
        break;
      case 'bishop':
        for (var move in ConstantsManager.bishopMoves) {
          tr = row;
          tl = col;

          looping:
          for (int i = 0; i < 8; i++) {
            tr += move.row;
            tl += move.col;
            if (isSquareOnBoard(tr, tl)) {
              if (isSquareEmpty(tr, tl)) {
                moves.add(Move(row: tr, col: tl));
              } else if (isEnemieHere(piece, tr, tl)) {
                // place move as condidate move and stop looping
                // squares after the enemie are not legal
                moves.add(Move(row: tr, col: tl));
                break looping;
              } else {
                // square contain teamate piece
                // any square behind our piece is illegal to move on
                break looping;
              }
            } else {
              break looping; // there is no need to loop squares outside the board
            }
          }
        }
        break;
      case 'rook':
        for (var move in ConstantsManager.rookMoves) {
          tr = row;
          tl = col;

          looping:
          for (int i = 0; i < 8; i++) {
            tr += move.row;
            tl += move.col;
            if (isSquareOnBoard(tr, tl)) {
              if (isSquareEmpty(tr, tl)) {
                moves.add(Move(row: tr, col: tl));
              } else if (isEnemieHere(piece, tr, tl)) {
                // place move as condidate move and stop looping
                // squares after the enemie are not legal
                moves.add(Move(row: tr, col: tl));
                break looping;
              } else {
                // square contain teamate piece
                // any square behind our piece is illegal to move on
                break looping;
              }
            } else {
              break looping; // there is no need to loop squares outside the board
            }
          }
        }
        break;
      case 'queen':
        for (var move in ConstantsManager.queenMoves) {
          tr = row;
          tl = col;

          looping:
          for (int i = 0; i < 8; i++) {
            tr += move.row;
            tl += move.col;
            if (isSquareOnBoard(tr, tl)) {
              if (isSquareEmpty(tr, tl)) {
                moves.add(Move(row: tr, col: tl));
              } else if (isEnemieHere(piece, tr, tl)) {
                // place move as condidate move and stop looping
                // squares after the enemie are not legal
                moves.add(Move(row: tr, col: tl));
                break looping;
              } else {
                // square contain teamate piece
                // any square behind our piece is illegal to move on
                break looping;
              }
            } else {
              break looping; // there is no need to loop squares outside the board
            }
          }
        }
        break;
      case 'king':
        for (Move move in ConstantsManager.kingMoves) {
          tr = row + move.row;
          tl = col + move.col;
          if (isSquareOnBoard(tr, tl)) {
            if (isSquareEmpty(tr, tl) || isEnemieHere(piece, tr, tl)) {
              moves.add(Move(row: tr, col: tl));
            }
          }
        }
        break;
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
