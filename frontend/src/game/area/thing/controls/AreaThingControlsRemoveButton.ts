import Interactive from "$src/game/Interactive";
import Renderable from "$src/game/Renderable";
import {fillRoundRect} from "$src/lib/CanvasUtils";

export default class AreaThingControlsRemoveButton extends Interactive implements Renderable {
  private static BUTTON_SIZE = 40;
  private static IMAGE_SIZE = 30;
  private static IMAGE_PATH = new Path2D(`
    M.875 0.25l-0.125 0.75h-0.5l-0.125-0.75h0.0845l0.111083333 0.666667h0.358791667l0.111083333-0.666667
    h0.0845416667zm-0.196291667-0.166667c-0.0375 0-0.0679583333-0.0457916667-0.0679583333-0.0833333333
    h-0.2215c0 0.0375416667-0.0304166667 0.0833333333-0.0679583333 0.0833333333h-0.237958333
    v0.0833333333h0.833333333v-0.0833333333h-0.237958333z`
  );

  private static DEFAULT_COLOR = "rgb(220, 220, 220)";
  private static HOVER_COLOR = "white";
  private static ACTIVE_COLOR = "rgb(180, 180, 180)";

  private callback: Function;

  constructor(callback: Function) {
    super(0, 0, AreaThingControlsRemoveButton.BUTTON_SIZE, AreaThingControlsRemoveButton.BUTTON_SIZE);
    this.callback = callback;
    this.cursor = Interactive.CURSOR_POINTER;
  }

  render(ctx: CanvasRenderingContext2D, idx: number) {
    if (this.active)
      ctx.fillStyle = AreaThingControlsRemoveButton.ACTIVE_COLOR;
    else if (this.hover)
      ctx.fillStyle = AreaThingControlsRemoveButton.HOVER_COLOR;
    else
      ctx.fillStyle = AreaThingControlsRemoveButton.DEFAULT_COLOR;

    fillRoundRect(ctx, this.x, this.y, this.width, this.height, 2);

    let padding = (AreaThingControlsRemoveButton.BUTTON_SIZE - AreaThingControlsRemoveButton.IMAGE_SIZE)/2;
    ctx.save();
    ctx.translate(this.x + padding, this.y + padding);
    ctx.scale(AreaThingControlsRemoveButton.IMAGE_SIZE, AreaThingControlsRemoveButton.IMAGE_SIZE);
    ctx.fillStyle = 'black';
    ctx.fill(AreaThingControlsRemoveButton.IMAGE_PATH);
    ctx.restore();
  }

  processMouseClick(x: number, y: number): boolean {
    this.callback.call(this);
    return false;
  }
}