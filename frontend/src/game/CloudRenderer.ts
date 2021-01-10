import Renderable from "$src/game/Renderable";
import HasSize from "$src/game/HasSize";
import HasCoordinates from "$src/game/HasCoordinates";
import Parallaxer from "$src/lib/Parallaxer";

export default class CloudRenderer implements Renderable, HasSize, HasCoordinates {
  height: number;
  width: number;
  x: number;
  y: number;
  speed: number = 0;
  scale: number;

  parallaxFactor: number;
  image: HTMLImageElement;

  constructor(x: number, y: number, scale: number, parallaxFactor: number, image: HTMLImageElement) {
    this.x = x;
    this.y = y;
    this.width = image.width*scale;
    this.height = image.height*scale;
    this.scale = scale;
    this.parallaxFactor = parallaxFactor;
    this.image = image;
  }

  render(ctx: CanvasRenderingContext2D, idx: number) {
    ctx.save();

    ctx.setTransform(
      Parallaxer.parallax(
        ctx.getTransform(),
        ctx.canvas.width,
        ctx.canvas.height,
        this.parallaxFactor
      )
    );

    // ctx.globalAlpha = this.scale > 1 ? 1/this.scale : 1;
    ctx.globalCompositeOperation = "screen"; // screen or lighten
    ctx.drawImage(this.image, this.x, this.y, this.width, this.height);
    ctx.restore();
  }
}