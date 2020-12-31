/**
 * Common interface for anything that can be placed on in-game area.
 */
import Renderable from "$src/ui/Renderable";
import Interactive from "$src/ui/Interactive";
import {MatrixUtils} from "$src/lib/MatrixUtils";

export default class AreaThing extends Interactive implements Renderable {
  protected static AREA_TRANSFORMATION = new DOMMatrix()
    .scale(1, 0.5)
    .rotate(45);

  inGameSizeX: number;
  inGameSizeY: number;
  inGameX: number;
  inGameY: number;
  private deletable: boolean;
  private movable: boolean;
  private inGameHover: boolean = false;

  constructor(inGameX: number, inGameY: number, inGameSizeX: number, inGameSizeY: number) {
    super(0, 0, 0, 0); // todo

    let rightPoint = MatrixUtils.multiply(AreaThing.AREA_TRANSFORMATION, new DOMPoint(inGameSizeX, 0));
    let leftPoint = MatrixUtils.multiply(AreaThing.AREA_TRANSFORMATION, new DOMPoint(0, inGameSizeY));
    this.width = rightPoint.x - leftPoint.x; // visual x size
    this.height = MatrixUtils.multiply(AreaThing.AREA_TRANSFORMATION, new DOMPoint(inGameSizeX, inGameSizeY)).y;

    let visualPoint = MatrixUtils.multiply(AreaThing.AREA_TRANSFORMATION, new DOMPoint(inGameX, inGameY));
    this.x = visualPoint.x - this.width/2;
    this.y = visualPoint.y;
    this.inGameX = inGameX;
    this.inGameY = inGameY;
    this.inGameSizeX = inGameSizeX;
    this.inGameSizeY = inGameSizeY;
  }

  processMouseMove(x: number, y: number) {
    this.inGameHover = true; // todo nadya
  }

  processMouseLeave(x: number, y: number) {
    this.inGameHover = false;
  }

  render(ctx: CanvasRenderingContext2D, idx: number) {
    ctx.save();
    let t = AreaThing.AREA_TRANSFORMATION;
    ctx.transform(t.a, t.b, t.c, t.d, t.e, t.f);

    ctx.fillStyle = 'green';
    if (this.inGameHover)
      ctx.fillStyle = 'red';

    ctx.fillRect(this.inGameX, this.inGameY, this.inGameSizeX, this.inGameSizeY);

    ctx.restore();
  }
}