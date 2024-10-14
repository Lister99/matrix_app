import 'package:flutter/material.dart';

class MatrixContainer extends StatelessWidget {
  const MatrixContainer({
    super.key,
    required this.matrix,
  });

  final List<List<dynamic>> matrix;

  @override
  Widget build(BuildContext context) {
    int gridStateLength = matrix.length;
    return AspectRatio(
      aspectRatio: 1.0,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: gridStateLength,
        ),
        itemBuilder: _buildGridItems,
        itemCount: gridStateLength * gridStateLength,
      ),
    );
  }

  Widget _buildGridItems(BuildContext context, int index) {
    int gridLength = matrix.length;
    int x, y = 0;
    x = (index / gridLength).floor();
    y = (index % gridLength);
    return GridTile(
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.black, width: .5)),
        child: Center(
          child: Text(matrix[x][y].toString()),
        ),
      ),
    );
  }
}
