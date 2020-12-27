import Interactive from "./Interactive";
import Renderable from "./Renderable";


export default class TestButton extends Interactive implements Renderable {

  width: number;
  height: number;

  constructor(width, height) {
    super();
    this.width = width;
    this.height = height;
  }

  render(ctx, idx) {
    // this.drawButton(ctx);
  }

  processClick(x, y) {
  }

  processMouseDown(x, y) {
  }

  processMouseMove(x, y) {
  }

  processMouseUp(x, y) {
  }

  drawButton(ctx) {
    let transform = ctx.getTransform();
    let lineWidth = 10/(transform.a + transform.d);

    ctx.strokeStyle = 'red';
    ctx.lineCap = "round";
    ctx.lineWidth = lineWidth;
    ctx.rect(0, 0, this.width, this.height);
  }
}