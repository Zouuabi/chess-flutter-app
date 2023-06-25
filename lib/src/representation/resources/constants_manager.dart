import '../../model/models.dart';

class ConstantsManager {
  static const int webScreenSize = 600;
  static const int boardLength = 64 ; 
  static const List<Move> pawnMoves = [
    Move(row: -1, col: 0),
    Move(row: -1, col: -1),
    Move(row: -1, col: 1),
  ];
  static const List<Move> nightMoves = [
    Move(row: -2, col: 1),
    Move(row: -2, col: -1),
    Move(row: 2, col: 1),
    Move(row: 2, col: -1),
    Move(row: -1, col: 2),
    Move(row: 1, col: 2),
    Move(row: -1, col: -2),
    Move(row: 1, col: -2),
  ];

  static const List<Move> bishopMoves = [
    Move(row: -1, col: -1),
    Move(row: -1, col: 1),
    Move(row: 1, col: 1),
    Move(row: 1, col: -1),
  ];
  static const List<Move> rookMoves = [
    Move(row: -1, col: 0),
    Move(row: 1, col: 0),
    Move(row: 0, col: 1),
    Move(row: 0, col: -1),
  ];
  static const List<Move> kingMoves = [
    Move(row: 1, col: 0),
    Move(row: -1, col: 0),
    Move(row: 0, col: 1),
    Move(row: 0, col: 1),
    Move(row: -1, col: -1),
    Move(row: -1, col: 1),
    Move(row: 1, col: -1),
    Move(row: 1, col: 1),
  ];
  static const List<Move> queenMoves = [
    // ** same as king moves but with loops
    Move(row: 1, col: 0),
    Move(row: -1, col: 0),
    Move(row: 0, col: 1),
    Move(row: 0, col: 1),
    Move(row: -1, col: -1),
    Move(row: -1, col: 1),
    Move(row: 1, col: -1),
    Move(row: 1, col: 1),
  ];
}
