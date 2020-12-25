import Renderable from "$src/ui/Renderable";
import {drawArrow} from "$src/lib/CanvasUtils";

const ARROWS_SIZE = 200;

export default class TesterRenderable extends Renderable {

  render(ctx, idx) {
    this.drawAxes(ctx);
  }

  drawAxes(ctx) {
    let transform = ctx.getTransform();
    let lineWidth = 10/(transform.a + transform.d);

    ctx.strokeStyle = 'red';
    ctx.lineCap = "round";
    ctx.lineWidth = lineWidth;
    drawArrow(ctx, 0, 0, 0, ARROWS_SIZE, 4*lineWidth);
    ctx.strokeStyle = 'blue';
    drawArrow(ctx, 0, 0, ARROWS_SIZE, 0, 4*lineWidth);
  }
}