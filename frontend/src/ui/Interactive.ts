import InteractiveBounds from "./InteractiveBounds";

export default abstract class Interactive {
  mouseEventBounds: InteractiveBounds;

  abstract processClick(x, y);
  abstract processMouseDown(x, y);
  abstract processMouseUp(x, y);
  abstract processMouseMove(x, y);

  // checkClick(x, y) {
  //   return (x >= this.mouseEventBounds.left
  //     && x <= this.mouseEventBounds.right
  //     && y >= this.mouseEventBounds.bottom
  //     && y <= this.mouseEventBounds.top)
  // }
}