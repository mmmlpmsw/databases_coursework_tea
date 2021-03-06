import CommonAreaHudButton from "$src/game/area/CommonAreaHudButton";

const BUTTON_SIZE = 40;
const IMAGE_SIZE = 30;
const IMAGE_PATH = new Path2D(`M.2 .1l.3 .3l.3 -.3l.1 .1l-.3 .3l.3 .3l-.1 .1l-.3 -.3l-.3 .3l-.1 -.1l.3 -.3l-.3 -.3`);
const DEFAULT_COLOR = "rgb(204,67,37)";
const HOVER_COLOR = "rgb(230,115,90)";
const ACTIVE_COLOR = "rgb(153,57,31)";

export default class AreaThingMoverCancelButton extends CommonAreaHudButton {
  constructor(callback: Function) {
    super(BUTTON_SIZE, IMAGE_SIZE, IMAGE_PATH, DEFAULT_COLOR, HOVER_COLOR, ACTIVE_COLOR, callback);
  }
}