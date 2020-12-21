import Layer from "$src/layers/Layer";

export default class CameraLayer extends Layer {
  constructor(renderables, enabled) {
    super(renderables, enabled);
    this._cameraX = 0;
    this._cameraY = 0;
    this._cameraScale = 1;
    this._matrix = new DOMMatrix();
  }

  setCameraPosition(x, y) {
    this._cameraX = x;
    this._cameraY = y;
    this._updateMatrix();
  }

  setCameraScale(scale) {
    this._cameraScale = scale;
    this._updateMatrix();
  }

  moveCamera(dx, dy) {
    this._cameraX += dx;
    this._cameraY += dy;
    this._matrix.translateSelf(-dx, -dy);
  }

  scaleCamera(scaleDelta, originX = this._cameraX, originY = this._cameraY) {
    this._cameraScale *= scaleDelta;
    this._matrix.scaleSelf(scaleDelta, scaleDelta, 1, originX, originY, 0);
  }

  unproject(x, y) {
    return { x: this._matrix.a * x + this._matrix.c * y, y: this._matrix.b * x + this._matrix.d * y };
  }
  
  render(ctx, idx) {
    ctx.save();
    ctx.translate(ctx.canvas.width/2, ctx.canvas.height/2);
    ctx.transform(
      this._matrix.a,
      this._matrix.b,
      this._matrix.c,
      this._matrix.d,
      this._matrix.e,
      this._matrix.f
    );
    super.render(ctx, idx);
    ctx.restore();
  }

  _updateMatrix() {
    this._matrix = new DOMMatrix();
    this._matrix.translateSelf(this._cameraX, this._cameraY);
    this._matrix.scaleSelf(this._cameraScale, this._cameraScale, 1, this._cameraX, this._cameraY, 0);
    this._matrix.invertSelf();
  }
}