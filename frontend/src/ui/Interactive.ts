import HasSize from "$src/ui/HasSize";
import HasCoordinates from "$src/ui/HasCoordinates";

export default class Interactive implements HasSize, HasCoordinates {
  hover: boolean = false;
  active: boolean = false;
  height: number;
  width: number;
  x: number;
  y: number;

  constructor(x: number, y: number, width: number, height: number) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
  }

  processMouseClick(x: number, y: number) {};
  processMouseDown(x: number, y: number) {};
  processMouseUp(x: number, y: number) {};
  processMouseMove(x: number, y: number) {};
  processMouseLeave(x: number, y: number) {};
  processMouseEnter(x: number, y: number) {};

  isPointOnItem(x, y) {
    return (x >= this.x
      && x <= this.x + this.width
      && y >= this.y
      && y <= this.y + this.height)
  }
}