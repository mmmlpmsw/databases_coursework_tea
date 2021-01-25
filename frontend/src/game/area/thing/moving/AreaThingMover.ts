import Renderable from "$src/game/Renderable";
import AreaThing from "$src/game/area/thing/AreaThing";
import * as Vue from "vue/types/umd";
import AreaThingMoverApplyButton from "$src/game/area/thing/moving/AreaThingMoverApplyButton";
import AreaThingMoverCancelButton from "$src/game/area/thing/moving/AreaThingMoverCancelButton";
import CompositeInteractive from "$src/game/CompositeInteractive";
import { saturate } from "$src/lib/Saturation";

let BOUNDS_RECT_COLOR_DEFAULT = "rgba(0, 255, 0, 0.5)";
let BOUNDS_RECT_COLOR_INTERSECT = "rgba(255, 0, 0, 0.5)";

export default class AreaThingMover extends CompositeInteractive implements Renderable {
  private readonly transformation: DOMMatrix;

  private target: AreaThing = null;
  private allAreaThings: AreaThing[];
  private eventBus: Vue;

  private readonly bound;

  private oldX: number;
  private oldY: number;

  private draggingOrigin: DOMPoint;

  private dragging = false;

  private buttonsSpacing = 8;
  private buttonsTopMargin = 8;

  private applyButton = new AreaThingMoverApplyButton(() => {
    this.eventBus.$emit(AreaThing.REQUEST_AREA_THING_MOVING_DONE_EVENT, this.target);
    this.target.cursor = AreaThingMover.CURSOR_DEFAULT;
    this.target = null;
  });

  private cancelButton = new AreaThingMoverCancelButton(() => {
    this.target.inGameX = this.oldX;
    this.target.inGameY = this.oldY;
    this.eventBus.$emit(AreaThing.REQUEST_AREA_THING_MOVING_DONE_EVENT, this.target);
    this.target.cursor = AreaThingMover.CURSOR_DEFAULT;
    this.target = null;
  });

  private buttons = [this.applyButton, this.cancelButton];

  constructor(eventBus: Vue, allAreaThings: AreaThing[], inGameTransformation: DOMMatrix, bound: number = 10) {
    super();
    this.eventBus = eventBus;
    this.allAreaThings = allAreaThings;
    this.transformation = inGameTransformation;
    this.bound = bound;
    this.buttons.forEach(b => this.addInteractive(b));
  }

  render(ctx: CanvasRenderingContext2D, idx: number) {
    ctx.save();
    if (this.target) {

      ctx.save();
      ctx.setTransform(ctx.getTransform().multiply(this.transformation));
      let intersections = this.findIntersections(this.target);
      ctx.fillStyle = intersections.length == 0 ? BOUNDS_RECT_COLOR_DEFAULT : BOUNDS_RECT_COLOR_INTERSECT;
      ctx.fillRect(this.target.inGameX, this.target.inGameY, this.target.inGameSizeX, this.target.inGameSizeY);
      intersections.forEach(i => ctx.fillRect(i.inGameX, i.inGameY, i.inGameSizeX, i.inGameSizeY));
      ctx.restore();

      for (let i = 0; i < this.allAreaThings.length; i++)
        if (this.allAreaThings[i] != this.target)
          this.allAreaThings[i].render(ctx, i);

      ctx.globalAlpha = 0.5;
      this.target.render(ctx, idx);

      if (!this.dragging) {
        ctx.globalAlpha = 1;
        this.buttons.forEach((b, i) => b.render(ctx, i));
      }
    }
    ctx.restore();
  }

  move(areaThing: AreaThing) {
    this.target = areaThing;
    this.oldX = this.target.inGameX;
    this.oldY = this.target.inGameY;
    this.updateButtons();
  }

  processMouseDown(x: number, y: number): boolean {
    super.processMouseDown(x, y);
    if (this.target.isPointOnItem(x, y)) {
      this.eventBus.$emit("request_camera_lock");
      this.dragging = true;
      this.draggingOrigin = new DOMPoint(x, y).matrixTransform(this.transformation.inverse());
      this.draggingOrigin.x -= this.target.inGameX;
      this.draggingOrigin.y -= this.target.inGameY;
    }
    return true;
  }

  processMouseMove(x: number, y: number): boolean {
    super.processMouseMove(x, y);

    let inGamePoint = new DOMPoint(x, y).matrixTransform(this.transformation.inverse());
    inGamePoint.x -= this.target.inGameX;
    inGamePoint.y -= this.target.inGameY;
    let inGameHover = inGamePoint.x > 0 &&
      inGamePoint.y > 0 &&
      inGamePoint.x < this.target.inGameSizeX &&
      inGamePoint.y < this.target.inGameSizeY;
    if (inGameHover)
      this.cursor = AreaThingMover.CURSOR_MOVE;

    if (this.dragging) {
      let inGamePoint = new DOMPoint(x, y).matrixTransform(this.transformation.inverse());
      this.target.inGameX = saturate(inGamePoint.x - this.draggingOrigin.x, 0, 1000 - this.target.inGameSizeX);
      this.target.inGameY = saturate(inGamePoint.y - this.draggingOrigin.y, 0, 1000 - this.target.inGameSizeY);
      this.target.inGameX -= this.target.inGameX % this.bound;
      this.target.inGameY -= this.target.inGameY % this.bound;
    }
    return true;
  }

  processMouseUp(x: number, y: number): boolean {
    super.processMouseUp(x, y);
    this.eventBus.$emit("request_camera_unlock");
    this.dragging = false;
    this.updateButtons();
    return true;
  }

  isPointOnItem(x: number, y: number): boolean {
    return true;
  }

  private findIntersections(a: AreaThing): AreaThing[] {
    let result: AreaThing[] = [];
    let between = (x, min, max) => x >= min && x < max;
    for (let b of this.allAreaThings) {
      if (a == b) continue;
      let xIntersects = between(a.inGameX, b.inGameX, b.inGameX + b.inGameSizeX) ||
                        between(b.inGameX, a.inGameX, a.inGameX + a.inGameSizeX);
      let yIntersects = between(a.inGameY, b.inGameY, b.inGameY + b.inGameSizeY) ||
                        between(b.inGameY, a.inGameY, a.inGameY + a.inGameSizeY);
      if (xIntersects && yIntersects)
        result.push(b);
    }
    return result;
  }

  private updateButtons() {
    let buttonsWidthSum = this.buttons.map(c => c.width).reduce((a, b) => a + b);

    let totalWidthSum = buttonsWidthSum + this.buttonsSpacing * (this.buttons.length - 1);

    let xPointer = this.target.x + this.target.width/2 - totalWidthSum/2;
    this.buttons.forEach(c => {
      c.x = xPointer;
      c.y = this.target.y + this.target.height + this.buttonsTopMargin;
      xPointer += c.width + this.buttonsSpacing;
    });
    this.applyButton.enabled = this.findIntersections(this.target).length == 0;
  }
}