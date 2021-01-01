// todo get rid of this
export class MatrixUtils {
  static multiply(matrix: DOMMatrix, point: DOMPoint): DOMPoint {
    return new DOMPoint(
      matrix.a * point.x + matrix.c * point.y + matrix.e,
      matrix.b * point.x + matrix.d * point.y + matrix.f
    );
  }
}