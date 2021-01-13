import Interactive from "$src/game/Interactive";
import Renderable from "$src/game/Renderable";
import { fillRoundRect } from "$src/lib/CanvasUtils";

export default class CommonAreaHudButton extends Interactive implements Renderable {
  private readonly buttonSize: number;
  private readonly imageSize: number;
  private readonly imagePath: Path2D;
  private readonly defaultColor: string;
  private readonly hoverColor: string;
  private readonly activeColor: string;
  private readonly callback: Function;

  private _enabled: boolean;

  public get enabled() { return this._enabled }
  public set enabled(v) {
    this._enabled = v;
    this.cursor = v ? Interactive.CURSOR_POINTER : Interactive.CURSOR_DEFAULT;
  }

  constructor(
    buttonSize: number,
    imageSize: number,
    imagePath: Path2D,
    defaultColor: string,
    hoverColor: string,
    activeColor: string,
    callback: Function
  ) {
    super(0, 0, buttonSize, buttonSize);
    this.buttonSize = buttonSize;
    this.imageSize = imageSize;
    this.imagePath = imagePath;
    this.defaultColor = defaultColor;
    this.hoverColor = hoverColor;
    this.activeColor = activeColor;
    this.callback = callback;
    this.enabled = true;
  }

  render(ctx: CanvasRenderingContext2D, idx: number) {
    ctx.save();

    if (!this.enabled)
      ctx.globalAlpha = 0.5;

    if (this.enabled && this.active)
      ctx.fillStyle = this.activeColor;
    else if (this.enabled && this.hover)
      ctx.fillStyle = this.hoverColor;
    else
      ctx.fillStyle = this.defaultColor;

    fillRoundRect(ctx, this.x, this.y, this.width, this.height, 2);

    let padding = (this.buttonSize - this.imageSize)/2;
    ctx.translate(this.x + padding, this.y + padding);
    ctx.scale(this.imageSize, this.imageSize);
    ctx.fillStyle = 'black';
    ctx.fill(this.imagePath);
    ctx.restore();
  }

  processMouseClick(x: number, y: number): boolean {
    if (this.enabled)
      this.callback.call(this);
    return false;
  }
}