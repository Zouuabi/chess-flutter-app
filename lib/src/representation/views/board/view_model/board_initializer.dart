import '../../../../model/models.dart';
import '../../../resources/assets_manager.dart';

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