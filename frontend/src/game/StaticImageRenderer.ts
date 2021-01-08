import Renderable from "$src/game/Renderable";
import HasCoordinates from "$src/game/HasCoordinates";
import HasSize from "$src/game/HasSize";

export default class StaticImageRenderer implements Renderable, HasCoordinates, HasSize {

  image: CanvasImageSource;
  height: number;
  width: number;
  x: number;
  y: number;

  constructor(image: CanvasImageSource, x: number, y: number, width: number, height: number) {
    this.image = image;
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
  }

  render(ctx: CanvasRenderingContext2D, idx: number) {
    ctx.drawImage(this.image, this.x, this.y, this.width, this.height);
  }
}