import Renderable from "$src/game/Renderable";

export default class StaticBackgroundRenderer implements Renderable {
  private readonly style: string;

  constructor(style: string) {
    this.style = style;
  }

  render(ctx: CanvasRenderingContext2D, idx: number) {
    ctx.fillStyle = this.style;
    ctx.fillRect(0, 0, ctx.canvas.width, ctx.canvas.height);
  }
}