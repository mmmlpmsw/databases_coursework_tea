import Interactive from "$src/game/Interactive";
import Renderable from "$src/game/Renderable";
import {fillRoundRect} from "$src/lib/CanvasUtils";

export default class AreaThingControlsMoveButton extends Interactive implements Renderable {
  private static BUTTON_SIZE = 40;
  private static IMAGE_SIZE = 30;
  private static IMAGE_PATH = new Path2D(`
    M.5 0l.2 .2h-.1v.2h.2v-.1L1 .5l-.2 .2v-.1h-.2v.2h.1L.5 1l-.2 -.2h.1v-.2h-.2v.1L0 .5l.2 -.2v.1h.2v-.2h-.1
  `);

  private static DEFAULT_COLOR = "rgb(220, 220, 220)";
  private static HOVER_COLOR = "white";
  private static ACTIVE_COLOR = "rgb(180, 180, 180)";

  private callback: Function;

  constructor(callback: Function) {
    super(0, 0, AreaThingControlsMoveButton.BUTTON_SIZE, AreaThingControlsMoveButton.BUTTON_SIZE);
    this.callback = callback;
    this.cursor = Interactive.CURSOR_POINTER;
  }

  render(ctx: CanvasRenderingContext2D, idx: number) {
    if (this.active)
      ctx.fillStyle = AreaThingControlsMoveButton.ACTIVE_COLOR;
    else if (this.hover)
      ctx.fillStyle = AreaThingControlsMoveButton.HOVER_COLOR;
    else
      ctx.fillStyle = AreaThingControlsMoveButton.DEFAULT_COLOR;

    fillRoundRect(ctx, this.x, this.y, this.width, this.height, 2);

    let padding = (AreaThingControlsMoveButton.BUTTON_SIZE - AreaThingControlsMoveButton.IMAGE_SIZE)/2;
    ctx.save();
    ctx.translate(this.x + padding, this.y + padding);
    ctx.scale(AreaThingControlsMoveButton.IMAGE_SIZE, AreaThingControlsMoveButton.IMAGE_SIZE);
    ctx.fillStyle = 'black';
    ctx.fill(AreaThingControlsMoveButton.IMAGE_PATH);
    ctx.restore();
  }

  processMouseClick(x: number, y: number): boolean {
    this.callback.call(this);
    return false;
  }
}