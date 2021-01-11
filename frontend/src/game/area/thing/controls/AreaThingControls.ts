import CompositeInteractive from "$src/game/CompositeInteractive";
import Renderable from "$src/game/Renderable";
import AreaThing from "$src/game/area/thing/AreaThing";
import * as Vue from "vue/types/umd";
import AreaThingControlsRemoveButton from "$src/game/area/thing/controls/AreaThingControlsRemoveButton";
import AreaThingControlsMoveButton from "$src/game/area/thing/controls/AreaThingControlsMoveButton";

export default class AreaThingControls extends CompositeInteractive implements Renderable {
  private readonly areaThing: AreaThing;
  private readonly buttonsBaseline: number;

  private closeCallback: Function;
  private eventBus: Vue;

  private buttonsSpacing = 8;
  private buttonsTopMargin = 8;
  private rootPadding = 40;

  private buttonsAlpha = 1;

  private buttons = [
    new AreaThingControlsMoveButton(() => {
      this.eventBus.$emit(AreaThing.REQUEST_AREA_THING_MOVING_START_EVENT, this.areaThing);
      this.closeControls();
    }),
    new AreaThingControlsRemoveButton(() => {
      this.eventBus.$emit(AreaThing.REQUEST_AREA_THING_REMOVAL_EVENT, this.areaThing);
      this.closeControls();
    })
  ];

  constructor(areaThing: AreaThing, eventBus: Vue, closeCallback: Function) {
    super(0, 0, 0, 0);
    this.x = areaThing.x - this.rootPadding;
    this.y = areaThing.y - this.rootPadding;
    this.width = areaThing.width + this.rootPadding*2;

    areaThing.selected = true;
    this.areaThing = areaThing;
    this.eventBus = eventBus;
    this.closeCallback = closeCallback;
    this.buttonsBaseline = this.y + this.rootPadding + this.areaThing.height + this.buttonsTopMargin;
    this.initAndArrangeButtons();
  }

  render(ctx: CanvasRenderingContext2D, idx: number) {
    ctx.save();
    ctx.globalAlpha = this.buttonsAlpha;
    this.buttons.forEach((c, i) => c.render(ctx, i));
    ctx.restore();
  }

  processMouseLeave(x: number, y: number) {
    super.processMouseLeave(x, y);
    this.closeControls();
  }

  processMouseMove(x: number, y: number): boolean {
    super.processMouseMove(x, y);
    this.buttonsAlpha = this.getSuggestedButtonsAlpha(x, y);
    return false;
  }

  private getSuggestedButtonsAlpha(x: number, y: number): number {
    let closeness = this.getMouseBorderCloseness(x, y);
    if (closeness < this.rootPadding) {
      return closeness/this.rootPadding;
    }
    return 1;
  }

  private getMouseBorderCloseness(x: number, y: number): number {
    let borderDistances = [
      x - this.x,
      this.x + this.width - x,
      y - this.y,
      this.y + this.height - y
    ];
    return Math.min(...borderDistances);
  }

  private initAndArrangeButtons() {
    let sum = (a, b) => a + b;
    let max = (a, b) => a > b ? a : b;

    let buttonsWidthSum = this.buttons.map(c => c.width).reduce(sum);
    let buttonsMaxHeight = this.buttons.map(c => c.height).reduce(max);

    let totalWidthSum = buttonsWidthSum + this.buttonsSpacing * (this.buttons.length - 1);

    let xPointer = this.x + this.width/2 - totalWidthSum/2;
    this.buttons.forEach(c => {
      c.x = xPointer;
      c.y = this.buttonsBaseline;
      xPointer += c.width + this.buttonsSpacing;
      this.addInteractive(c);
    });

    this.height = this.areaThing.height + buttonsMaxHeight + this.buttonsTopMargin + this.rootPadding*2;
  }

  private closeControls() {
    this.areaThing.selected = false;
    this.closeCallback.call(this);
  }
}