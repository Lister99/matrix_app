class MatrixAppUtils {
  static List<List<dynamic>> rotateMatrix(List<List<dynamic>> mat){
    final n = mat.length;
    for (int i = 0; i < n / 2; i++) {
      for (int j = i; j < n - i - 1; j++) {
        dynamic temp = mat[i][j];//1//
        mat[i][j] = mat[j][n - 1 - i];//4
        mat[j][n - 1 - i] = mat[n - 1 - i][n - 1 - j];//16
        mat[n - 1 - i][n - 1 - j] = mat[n - 1 - j][i];//13
        mat[n - 1 - j][i] = temp;//1
      }
    }
    return mat;
  }

  static bool isValidMatrix(List<List<dynamic>> matrix, int row) {
    if (row >= matrix.length) {
      return true;
    }
    if (matrix[row].length != matrix.length) {
      return false;
    }
    return isValidMatrix(matrix, row + 1);
  }
}