import { drawArrow } from "$src/lib/CanvasUtils";
import Renderable from "./Renderable";

const ARROWS_SIZE = 200;

export default class TesterRenderable implements Renderable {

  render(ctx: CanvasRenderingContext2D, idx: number) {
    this.drawAxes(ctx);
  }

  drawAxes(ctx: CanvasRenderingContext2D) {
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