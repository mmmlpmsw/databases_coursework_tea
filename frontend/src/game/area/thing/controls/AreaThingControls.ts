import CompositeInteractive from "$src/game/CompositeInteractive";
import Renderable from "$src/game/Renderable";
import AreaThing from "$src/game/area/thing/AreaThing";
import * as Vue from "vue/types/umd";

export default class AreaThingControls extends CompositeInteractive implements Renderable {
  private areaThing: AreaThing;
  private closeCallback: Function;
  private eventBus: Vue;

  constructor(areaThing: AreaThing, eventBus: Vue, closeCallback: Function) {
    super(areaThing.x, areaThing.y, areaThing.width, areaThing.height);
    this.areaThing = areaThing;
    this.eventBus = eventBus;
    this.closeCallback = closeCallback;
  }

  render(ctx: CanvasRenderingContext2D, idx: number) {
    ctx.fillStyle = this.hover ? "magenta" : "red";
    ctx.fillRect(this.x, this.y, this.width, this.height)
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