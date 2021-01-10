import Renderable from "$src/game/Renderable";
import HasCoordinates from "$src/game/HasCoordinates";
import HasSize from "$src/game/HasSize";
import Parallaxer from "$src/lib/Parallaxer";

export class SkyRenderer implements Renderable, HasCoordinates, HasSize {
  private static readonly PARALLAX_FACTOR = 0.6; // 1 - no move, 0 - full following

  height: number;
  width: number;
  x: number;
  y: number;

  private gradient: CanvasGradient;

  // TODO Немного костыльная реализация
  constructor(minX: number, minY: number, maxX: number, maxY: number) {
    this.x = minX;
    this.y = minY;
    this.width = maxX - minX;
    this.height = maxY - minY;
  }

  render(ctx: CanvasRenderingContext2D, idx: number) {
    ctx.save();

    ctx.setTransform(
      Parallaxer.parallax(
        ctx.getTransform(),
        ctx.canvas.width,
        ctx.canvas.height,
        SkyRenderer.PARALLAX_FACTOR
      )
    );

    if (!this.gradient)
      this.initGradient(ctx);

    ctx.fillStyle = this.gradient;
    ctx.fillRect(this.x, this.y, this.width, this.height);

    ctx.restore();
  }

  private initGradient(ctx: CanvasRenderingContext2D) {
    this.gradient = ctx.createLinearGradient(0, this.y, 0, this.y + this.height);
    this.gradient.addColorStop(0, '#01001a');
    this.gradient.addColorStop(.4, '#090979');
    this.gradient.addColorStop(1, '#00d4ff');
  }
}