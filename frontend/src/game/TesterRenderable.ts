import { drawArrow } from "$src/lib/CanvasUtils";
import Renderable from "./Renderable";

const ARROWS_SIZE = 100;
const TEXT_MARGIN = 5;

const GRID_MIN = -5000;
const GRID_MAX = 5000;
const GRID_STEP = 100;

export default class TesterRenderable implements Renderable {

  render(ctx: CanvasRenderingContext2D, idx: number) {
    this.drawAxes(ctx);
  }

  drawAxes(ctx: CanvasRenderingContext2D) {
    for (let i = GRID_MIN; i <= GRID_MAX; i += GRID_STEP) {
      if (i == 0) {
        ctx.strokeStyle = 'rgba(0, 0, 0, .5)';
        ctx.lineWidth = 2;
      } else {
        ctx.strokeStyle = 'rgba(0, 0, 0, .1)';
        ctx.lineWidth = 1;
      }

      ctx.beginPath();
      ctx.moveTo(i, GRID_MIN);
      ctx.lineTo(i, GRID_MAX);
      ctx.moveTo(GRID_MIN, i);
      ctx.lineTo(GRID_MAX, i);
      ctx.stroke();

      ctx.fillText(i.toString(), i + TEXT_MARGIN, -TEXT_MARGIN);
      ctx.fillText(i.toString(), TEXT_MARGIN, i - TEXT_MARGIN);
    }

    let transform = ctx.getTransform();
    let lineWidth = 8/(transform.a + transform.d);

    ctx.strokeStyle = 'red';
    ctx.lineCap = "round";
    ctx.lineWidth = lineWidth;
    drawArrow(ctx, 0, 0, 0, ARROWS_SIZE, 4*lineWidth);
    ctx.strokeStyle = 'blue';
    drawArrow(ctx, 0, 0, ARROWS_SIZE, 0, 4*lineWidth);
  }
}