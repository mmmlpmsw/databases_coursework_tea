import Interactive from "$src/game/Interactive";
import Renderable from "$src/game/Renderable";

export default class AreaThingControlsRemoveButton extends Interactive implements Renderable {
  private static BUTTON_SIZE = 40;

  private callback: Function;

  constructor(callback: Function) {
    super(0, 0, AreaThingControlsRemoveButton.BUTTON_SIZE, AreaThingControlsRemoveButton.BUTTON_SIZE);
    this.callback = callback;
  }

  render(ctx: CanvasRenderingContext2D, idx: number) {
    ctx.fillStyle = 'blue';
    ctx.fillRect(this.x, this.y, this.width, this.height);
  }

  processMouseClick(x: number, y: number): boolean {
    this.callback.call(null);
    return false;
  }
}