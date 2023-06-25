class Chessboard {
  Chessboard({
    required this.squares,
    required this.selectedPiece,
    required this.valideMoves,
    this.turn = 'white',
  });

  List<List<Square>> squares;
  Map<String, int?> selectedPiece;
  List<Move> valideMoves;
  String turn;
  
}

class Square {
  Square(this.row, this.col, this.color) {
    piece = Piece.empty();
  }

  int row;
  int col;
  bool isSelected = false;
  String color;
  late Piece piece;

  // Initialize a square with its position and an empty piece

  // Place a piece on the square
}

class Piece {
  String type;
  bool isWhite;
  String? imagePath;

  Piece(this.type, this.isWhite, this.imagePath);

  // Create an empty piece
  factory Piece.empty() {
    return Piece('empty', false, null);
  }
}

class Move {
  const Move({required this.row, required this.col});
  final int row;
  final int col;
}
