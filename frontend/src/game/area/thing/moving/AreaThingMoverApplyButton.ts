import CommonAreaHudButton from "$src/game/area/CommonAreaHudButton";

const BUTTON_SIZE = 40;
const IMAGE_SIZE = 30;
const IMAGE_PATH = new Path2D(`M0 .6l.3 .3l.7 -.7l-.1 -.1l-.6 .6l-.2 -.2l-.1 .1`);
const DEFAULT_COLOR = "rgb(39,204,61)";
const HOVER_COLOR = "rgb(90,230,108)";
const ACTIVE_COLOR = "rgb(32,153,46)";

export default class AreaThingMoverApplyButton extends CommonAreaHudButton {
  constructor(callback: Function) {
    super(BUTTON_SIZE, IMAGE_SIZE, IMAGE_PATH, DEFAULT_COLOR, HOVER_COLOR, ACTIVE_COLOR, callback);
  }
}