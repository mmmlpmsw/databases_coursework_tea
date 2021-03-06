import HasSize from "$src/game/HasSize";
import HasCoordinates from "$src/game/HasCoordinates";

export default class Interactive implements HasSize, HasCoordinates {
  public static CURSOR_DEFAULT = "default";
  public static CURSOR_POINTER = "pointer";
  public static CURSOR_MOVE = "move";

  private _cursor = Interactive.CURSOR_DEFAULT;

  hover = false;
  active = false;
  height: number;
  width: number;
  x: number;
  y: number;

  constructor(x?: number, y?: number, width?: number, height?: number) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
  }

  // true = continue propagation
  processMouseClick(x: number, y: number): boolean { return true };
  processMouseDown(x: number, y: number): boolean { return true };
  processMouseUp(x: number, y: number): boolean { return true };
  processMouseMove(x: number, y: number): boolean { return true };
  processMouseLeave(x: number, y: number) {};
  processMouseEnter(x: number, y: number) {};

  get cursor() { return this._cursor }
  set cursor(v) { this._cursor = v }

  isPointOnItem(x: number, y: number) {
    return ((
        this.x == undefined
        || this.y == undefined
        || this.width == undefined
        || this.height == undefined
      ) || (
        x >= this.x
        && x < this.x + this.width
        && y >= this.y
        && y < this.y + this.height
      )
    )
  }
}