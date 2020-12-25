import InteractiveBounds from "$src/ui/InteractiveBounds";

let bounds = new InteractiveBounds(0, 0, 0, 0);

export default class Interactive {
  get mouseEventBounds() {
    return bounds;
  }

  set mouseEventBounds(v) {
    bounds = v;
  }

  processClick(x, y) {}
  processMouseDown(x, y) {}
  processMouseUp(x, y) {}
  processMouseMove(x, y) {}
}