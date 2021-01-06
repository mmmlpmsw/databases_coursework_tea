/**
 * Common interface for anything that can be placed on in-game area.
 */
import Renderable from "$src/game/Renderable";
import Interactive from "$src/game/Interactive";
import {MatrixUtils} from "$src/lib/MatrixUtils";
import * as Vue from "vue/types/umd";

export default class AreaThing extends Interactive implements Renderable {
  protected static AREA_TRANSFORMATION = new DOMMatrix()
    .scale(1, 0.5)
    .rotate(45);

  public static DEV_DRAW_BOUNDS = false;
  public static REQUEST_AREA_THING_CONTROLS_EVENT = "request_area_thing_controls";

  private _inGameSizeX: number;
  private _inGameSizeY: number;
  private _inGameX: number;
  private _inGameY: number;
  private deletable: boolean = true;
  private movable: boolean = true;
  private inGameHover: boolean = false;

  public eventBus: Vue = null;

  constructor(inGameX: number, inGameY: number, inGameSizeX: number, inGameSizeY: number) {
    super(0, 0, 0, 0);
    this._inGameX = inGameX;
    this._inGameY = inGameY;
    this._inGameSizeX = inGameSizeX;
    this._inGameSizeY = inGameSizeY;
    this.updateBounds();
  }

  get inGameSizeX() { return this._inGameSizeX; }
  get inGameSizeY() { return this._inGameSizeY; }
  get inGameX() { return this._inGameX; }
  get inGameY() { return this._inGameY; }

  set inGameSizeX(v) {
    this._inGameSizeX = v;
    this.updateBounds();
  }

  set inGameSizeY(v) {
    this._inGameSizeY = v;
    this.updateBounds();
  }

  set inGameX(v) {
    this._inGameX = v;
    this.updateBounds();
  }

  set inGameY(v) {
    this._inGameY = v;
    this.updateBounds();
  }

  processMouseMove(x: number, y: number) {
    let inGamePoint = new DOMPoint(x, y).matrixTransform(AreaThing.AREA_TRANSFORMATION.inverse());
    inGamePoint.x -= this.inGameX;
    inGamePoint.y -= this.inGameY;
    this.inGameHover =  inGamePoint.x > 0 &&
                        inGamePoint.y > 0 &&
                        inGamePoint.x < this.inGameSizeX &&
                        inGamePoint.y < this.inGameSizeY;
  }

  processMouseLeave(x: number, y: number) {
    this.inGameHover = false;
  }

  processMouseClick(x: number, y: number) {
    if (this.eventBus)
      this.eventBus.$emit(AreaThing.REQUEST_AREA_THING_CONTROLS_EVENT, this);
  }

  render(ctx: CanvasRenderingContext2D, idx: number) {
    ctx.save();
    let t = AreaThing.AREA_TRANSFORMATION;
    ctx.transform(t.a, t.b, t.c, t.d, t.e, t.f);

    ctx.fillStyle = 'green';
    if (this.inGameHover)
      ctx.fillStyle = 'yellow';

    ctx.fillRect(this.inGameX, this.inGameY, this.inGameSizeX, this.inGameSizeY);

    ctx.restore();

    let transform = ctx.getTransform();
    if (AreaThing.DEV_DRAW_BOUNDS) {
      ctx.setLineDash([2, 2]);

      ctx.lineWidth = 2/(transform.a + transform.b);
      ctx.strokeStyle = this.hover ? 'blue' : 'magenta';
      ctx.strokeRect(this.x, this.y, this.width, this.height);
    }
  }

  private updateBounds() {
    let rightPoint = MatrixUtils.multiply(AreaThing.AREA_TRANSFORMATION, new DOMPoint(this._inGameX + this._inGameSizeX, this._inGameY));
    let leftPoint = MatrixUtils.multiply(AreaThing.AREA_TRANSFORMATION, new DOMPoint(this._inGameX, this._inGameY + this._inGameSizeY));
    this.width = rightPoint.x - leftPoint.x; // visual x size
    this.height = MatrixUtils.multiply(AreaThing.AREA_TRANSFORMATION, new DOMPoint(this._inGameSizeX, this._inGameSizeY)).y;

    let visualPoint = MatrixUtils.multiply(AreaThing.AREA_TRANSFORMATION, new DOMPoint(this._inGameX, this._inGameY));
    this.x = leftPoint.x;
    this.y = visualPoint.y;
  }
}