import 'package:chess/representation/resources/assets_manager.dart';

class Chessboard {
  // Initialize the chessboard with squares
  Chessboard();
  late List<List<Square>> _squares;
  late Map<String, int?> _selectedPiece;
  String turn = 'white';

  factory Chessboard.instance() {
    Chessboard instance = Chessboard();
    instance.intializeBoard();
    return instance;
  }
  // intialize the bord

  void intializeBoard() {
    _squares = List<List<Square>>.generate(8, (row) {
      return List<Square>.generate(8, (col) {
        bool isLight = (row + col) % 2 == 0;
        Square square = Square(row, col, isLight ? 'light' : 'dark');

        return square;
      });
    });
    _selectedPiece = {
      'currentRow': null,
      'currentCol': null,
      'nextRow': null,
      'nextCol': null,
    };

    // initialize black pieces
    for (int i = 0; i < 8; i++) {
      Square currentSquare = _squares[1][i];
      currentSquare.piece.type = 'pawn';
      currentSquare.piece.imagePath = ImageAssets.pawn;
      currentSquare.piece.isWhite = false;
    }

    Piece rook1 = _squares[0][0].piece;
    rook1.type = 'rook';
    rook1.imagePath = ImageAssets.rook;
    rook1.isWhite = false;

    Piece rook2 = _squares[0][7].piece;
    rook2.type = 'rook';
    rook2.imagePath = ImageAssets.rook;
    rook2.isWhite = false;

    Piece knight1 = _squares[0][1].piece;
    knight1.type = 'knight';
    knight1.imagePath = ImageAssets.knight;
    knight1.isWhite = false;

    Piece knight2 = _squares[0][6].piece;
    knight2.type = 'knight';
    knight2.imagePath = ImageAssets.knight;
    knight2.isWhite = false;

    Piece bishop1 = _squares[0][2].piece;
    bishop1.type = 'bishop';
    bishop1.imagePath = ImageAssets.bishop;
    bishop1.isWhite = false;

    Piece bishop2 = _squares[0][5].piece;
    bishop2.type = 'bishop';
    bishop2.imagePath = ImageAssets.bishop;
    bishop2.isWhite = false;

    Piece queen = _squares[0][3].piece;
    queen.type = 'queen';
    queen.imagePath = ImageAssets.queen;
    queen.isWhite = false;

    Piece king = _squares[0][4].piece;
    king.type = 'king';
    king.imagePath = ImageAssets.king;
    king.isWhite = false;

    // intiialize white pieces
    for (int i = 0; i < 8; i++) {
      Square currentSquare = _squares[6][i];
      currentSquare.piece.type = 'pawn';
      currentSquare.piece.imagePath = ImageAssets.pawn;
      currentSquare.piece.isWhite = true;
    }
    Piece brook1 = _squares[7][0].piece;
    brook1.type = 'rook';
    brook1.imagePath = ImageAssets.rook;
    brook1.isWhite = true;

    Piece brook2 = _squares[7][7].piece;
    brook2.type = 'rook';
    brook2.imagePath = ImageAssets.rook;
    brook2.isWhite = true;

    Piece bknight1 = _squares[7][1].piece;
    bknight1.type = 'knight';
    bknight1.imagePath = ImageAssets.knight;
    bknight1.isWhite = true;

    Piece bknight2 = _squares[7][6].piece;
    bknight2.type = 'knight';
    bknight2.imagePath = ImageAssets.knight;
    bknight2.isWhite = true;

    Piece bbishop1 = _squares[7][2].piece;
    bbishop1.type = 'bishop';
    bbishop1.imagePath = ImageAssets.bishop;
    bbishop1.isWhite = true;

    Piece bbishop2 = _squares[7][5].piece;
    bbishop2.type = 'bishop';
    bbishop2.imagePath = ImageAssets.bishop;
    bbishop2.isWhite = true;

    Piece bqueen = _squares[7][3].piece;
    bqueen.type = 'queen';
    bqueen.imagePath = ImageAssets.queen;
    bqueen.isWhite = true;

    Piece bking = _squares[7][4].piece;
    bking.type = 'king';
    bking.imagePath = ImageAssets.king;
    bking.isWhite = true;
  }

  bool checkTurn(Square square) {
    bool ret;
    if (_selectedPiece['currentRow'] == null &&
        _selectedPiece['currentCol'] == null) {
      if (((square.piece.isWhite && turn == 'white') ||
          (!square.piece.isWhite && turn != 'white'))) {
        ret = true;
      } else {
        ret = false;
      }
    } else {
      var otherSquare = _squares[_selectedPiece['currentRow']!]
          [_selectedPiece['currentCol']!];
      if (otherSquare.piece.isWhite && turn == 'white' ||
          !otherSquare.piece.isWhite && turn != 'white') {
        ret = true;
      } else {
        ret = false;
      }
    }

    return ret;
  }

  // Select a pice
  @Deprecated("""
selectedPiece() is being deprecated 
""")
  String selectPiece(
      {required Square square, required int row, required int col}) {
    String status = 'nothing for now ';

    if (checkTurn(square)) {
      if ((_selectedPiece['currentRow'] == null &&
          _selectedPiece['currentCol'] == null)) {
        // Select taped square
        if (square.piece.type != 'empty') {
          square.isSelected = true;
          _selectedPiece['currentRow'] = row;
          _selectedPiece['currentCol'] = col;
          status = 'fresh piece';
          return status;
        }
      } else if ((_selectedPiece['nextRow'] == null &&
          _selectedPiece['nextCol'] == null)) {
        // Select another square even if it is the same one
        _selectedPiece['nextRow'] = row;
        _selectedPiece['nextCol'] = col;

        status = 'a piece already selected checking ...';
      }

      if ((_selectedPiece['currentRow'] == _selectedPiece['nextRow'] &&
          _selectedPiece['currentCol'] == _selectedPiece['nextCol'])) {
        // User taped the same square So unselcet it

        square.isSelected = false;
        _selectedPiece['currentRow'] = null;
        _selectedPiece['currentCol'] = null;
        _selectedPiece['nextRow'] = null;
        _selectedPiece['nextCol'] = null;
        status = 'check ended Same piece typed twice :unselect';
      } else {
        Square otherSquare = _squares[_selectedPiece['currentRow']!]
            [_selectedPiece['currentCol']!];
        if (otherSquare.piece.isWhite == square.piece.isWhite &&
            square.piece.type != 'empty') {
          otherSquare.isSelected = false;
          square.isSelected = true;
          _selectedPiece['currentRow'] = row;
          _selectedPiece['currentCol'] = col;
          _selectedPiece['nextRow'] = null;
          _selectedPiece['nextCol'] = null;
          status = 'Select an Other Piece';
        } else {
          status = 'movePiece';
          movePiece();
          turn = turn == 'white' ? 'black' : 'white';
          otherSquare.isSelected = false;
          _selectedPiece['currentRow'] = null;
          _selectedPiece['currentCol'] = null;
          _selectedPiece['nextRow'] = null;
          _selectedPiece['nextCol'] = null;
        }
      }
    }
    return status;
  }

  List<Move>? calculateValidMoves(
      {required Piece piece, required int row, required int col}) {
    List<Move>? moves;
    switch (piece.type) {
      case 'pawn':
        if (piece.isWhite) {
          // legal moves are constants
          moves = [
            Move(row: row - 1, col: col),
            Move(row: row - 1, col: col - 1),
            Move(row: row - 1, col: col + 1),
          ];
        } else {
          moves = [
            Move(row: row + 1, col: col),
            Move(row: row + 1, col: col - 1),
            Move(row: row + 1, col: col + 1),
          ];
        }

        break;
      default:
    }

    return moves;
  }

  void movePiece() {
    int row = _selectedPiece['currentRow']!;
    int col = _selectedPiece['currentCol']!;
    int nextRow = _selectedPiece['nextRow']!;
    int nextCol = _selectedPiece['nextCol']!;

    _squares[nextRow][nextCol].placePiece(_squares[row][col].piece);
    _squares[row][col].removePiece();
  }

  // get the information abut the selected piece in the format of a map
  Map<String, int?> get getSelectedPiece => _selectedPiece;

  // get A squares info via it's row and col values
  Square getSquare(int row, int col) {
    return _squares[row][col];
  }
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
  void placePiece(Piece newPiece) {
    piece = newPiece;
  }

  // Remove the piece from the square
  void removePiece() {
    piece = Piece.empty();
  }
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
  Move({required this.row, required this.col});
  final int row;
  final int col;
}
