import Layer from "$src/layers/Layer";
import { saturate } from "$src/lib/Saturation"

export default class CameraLayer extends Layer {
  constructor(renderables, enabled) {
    super(renderables, enabled);
    this._matrix = new DOMMatrix();

    this.minCameraX = -100;
    this.maxCameraX = 100;
    this.minCameraY = -100;
    this.maxCameraY = 100;
    this.minCameraScale = 0.5;
    this.maxCameraScale = 4;
  }

  scaleCamera(scaleDelta, originX = this.cameraX, originY = this.cameraY) {
    let resultScale = saturate(this.cameraScale/scaleDelta, this.minCameraScale, this.maxCameraScale);
    let saturatedDelta = this.cameraScale/resultScale;
    this._matrix.scaleSelf(saturatedDelta, saturatedDelta, saturatedDelta, originX, originY, 0);

    this.cameraX = this.cameraX;
    this.cameraY = this.cameraY;
  }

  get cameraX() { return -this._matrix.e; }
  get cameraY() { return -this._matrix.f; }
  get cameraScale() { return 1/this._matrix.a; }

  set cameraX(v) { this._matrix.e = -saturate(v*this.cameraScale, this.minCameraX, this.maxCameraX)/this.cameraScale; }
  set cameraY(v) { this._matrix.f = -saturate(v*this.cameraScale, this.minCameraY, this.maxCameraY)/this.cameraScale; }
  set cameraScale(scale) {
    this._matrix.a = saturate(1/scale, this.minCameraScale, this.maxCameraScale);
    this._matrix.d = this._matrix.a;
  }

  project(x, y) {
    let m = this._matrix;
    return {
      x: m.a * x + m.c * y + m.e,
      y: m.b * x + m.d * y + m.f
    }
  }

  unproject(x, y) {
    let m = this._matrix.inverse();
    return {
      x: m.a * x + m.c * y + m.e,
      y: m.b * x + m.d * y + m.f
    }
  }
  
  render(ctx, idx) {
    ctx.save();
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

  // _updateMatrix() {
  //   this._matrix = new DOMMatrix();
  //   this._matrix.translateSelf(this._cameraX, this._cameraY);
  //   this._matrix.scaleSelf(this._cameraScale, this._cameraScale, this._cameraScale, this._cameraX, this._cameraY, 0);
  //   this._matrix.invertSelf();
  // }
}