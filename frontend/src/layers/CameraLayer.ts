import Layer from "$src/layers/Layer";
import { saturate } from "$src/lib/Saturation"
import Renderable from "$src/ui/Renderable";

export default class CameraLayer extends Layer {
  private matrix: DOMMatrix = new DOMMatrix();

  minCameraX: number = -1000;
  maxCameraX: number = 1000;
  minCameraY: number = -1000;
  maxCameraY: number = 1000;
  minCameraScale: number = 0.5;
  maxCameraScale: number = 4;

  cameraWidth: number = 100;
  cameraHeight: number = 100;

  constructor(renderables: Renderable[] = [], enabled: boolean = true) {
    super(renderables, enabled);
  }

  scaleCamera(scaleDelta, originX = this.cameraX, originY = this.cameraY) {
    let resultScale = saturate(this.cameraScale/scaleDelta, this.minCameraScale, this.maxCameraScale);
    let saturatedDelta = this.cameraScale/resultScale;
    this.matrix.scaleSelf(saturatedDelta, saturatedDelta, saturatedDelta, originX, originY, 0);

    this.cameraX = this.cameraX;
    this.cameraY = this.cameraY;
  }

  get cameraX() { return -this.matrix.e*this.cameraScale; }
  get cameraY() { return -this.matrix.f*this.cameraScale; }
  get cameraScale() { return 1/this.matrix.a; }

  set cameraX(v) { this.matrix.e = -saturate(v, this.minCameraX, this.maxCameraX)/this.cameraScale; }
  set cameraY(v) { this.matrix.f = -saturate(v, this.minCameraY, this.maxCameraY)/this.cameraScale; }
  set cameraScale(scale) {
    this.matrix.a = saturate(1/scale, this.minCameraScale, this.maxCameraScale);
    this.matrix.d = this.matrix.a;
  }

  project(x, y) {
    let m = this.matrix;
    x += this.cameraWidth/2;
    y += this.cameraHeight/2;
    return {
      x: m.a * x + m.c * y + m.e,
      y: m.b * x + m.d * y + m.f
    }
  }

  unproject(x, y) {
    let m = this.matrix.inverse();
    x -= this.cameraWidth/2;
    y -= this.cameraHeight/2;
    return {
      x: m.a * x + m.c * y + m.e,
      y: m.b * x + m.d * y + m.f
    }
  }
  
  render(ctx, idx) {
    ctx.save();
    ctx.translate(ctx.canvas.width/2, ctx.canvas.height/2);
    ctx.transform(
      this.matrix.a,
      this.matrix.b,
      this.matrix.c,
      this.matrix.d,
      this.matrix.e,
      this.matrix.f
    );
    super.render(ctx, idx);
    ctx.restore();
  }
}