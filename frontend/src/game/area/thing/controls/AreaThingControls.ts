import CompositeInteractive from "$src/game/CompositeInteractive";
import Renderable from "$src/game/Renderable";
import AreaThing from "$src/game/area/thing/AreaThing";
import * as Vue from "vue/types/umd";

export default class AreaThingControls extends CompositeInteractive implements Renderable {
  private readonly areaThing: AreaThing;
  private closeCallback: Function;
  private eventBus: Vue;
  private readonly delta: number;
  private readonly controlsPanelX: number;
  private readonly controlsPanelY: number;
  private readonly controlsPanelWidth: number;
  private readonly controlsPanelHeight: number;

  constructor(areaThing: AreaThing, eventBus: Vue, closeCallback: Function, delta: number = 40) {
    super(areaThing.x, areaThing.y, areaThing.width, areaThing.height + delta);
    this.delta = delta;
    this.areaThing = areaThing;
    this.eventBus = eventBus;
    this.closeCallback = closeCallback;

    this.controlsPanelX = areaThing.x + areaThing.width/2 - 2 * delta/2;
    this.controlsPanelY = areaThing.y + areaThing.height;
    this.controlsPanelWidth = 2 * delta;
    this.controlsPanelHeight = delta;
  }

  render(ctx: CanvasRenderingContext2D, idx: number) {
    const xAreaCoord = this.areaThing.x;
    const yAreaCoord = this.areaThing.y;
    const delta = this.delta;

    ctx.fillStyle = "white";
    //fixme победить математику для фигур, которые не квадраты (не бейте, я старался)
    ctx.fillRect(xAreaCoord + this.areaThing.width/2 - this.controlsPanelWidth/2, yAreaCoord + this.areaThing.height, this.controlsPanelWidth, this.controlsPanelHeight);

    const imgMove = new Image();
    imgMove.src = "assets/image/move_40.png";
    ctx.drawImage(imgMove, xAreaCoord + this.areaThing.width/2 - this.controlsPanelWidth/2, yAreaCoord + this.areaThing.height);

    const imgDelete = new Image();
    imgDelete.src = "assets/image/delete_40.png";
    ctx.drawImage(imgDelete, xAreaCoord + this.areaThing.width/2 - this.controlsPanelWidth/2 + delta, yAreaCoord + this.areaThing.height);
  }

  processMouseClick(x: number, y: number): boolean {
    if (x >= this.controlsPanelX && x < this.controlsPanelX + this.delta
      && y >= this.controlsPanelY && y <= this.controlsPanelY + this.delta)
      console.log("aaaaaaa"); //todo move event
    else
      if (x >= this.controlsPanelX + this.delta && x <= this.controlsPanelX + 2 * this.delta
      && y >= this.controlsPanelY && y <= this.controlsPanelY + this.delta) {
        this.eventBus.$emit(AreaThing.REQUEST_AREA_THING_REMOVAL_EVENT, this.areaThing);
        this.closeCallback.call(this);
    }
    return super.processMouseClick(x, y);
  }

  processMouseLeave(x: number, y: number) {
    super.processMouseLeave(x, y);
    this.closeCallback.call(this);
  }

  processMouseMove(x: number, y: number): boolean {
    super.processMouseMove(x, y);
    return false;
  }
}