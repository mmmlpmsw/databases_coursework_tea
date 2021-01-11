import CommonAreaHudButton from "$src/game/area/CommonAreaHudButton";

const BUTTON_SIZE = 40;
const IMAGE_SIZE = 30;
const IMAGE_PATH = new Path2D(`
    M.5 0l.2 .2h-.1v.2h.2v-.1L1 .5l-.2 .2v-.1h-.2v.2h.1L.5 1l-.2 -.2h.1v-.2h-.2v.1L0 .5l.2 -.2v.1h.2v-.2h-.1
  `);
const DEFAULT_COLOR = "rgb(220, 220, 220)";
const HOVER_COLOR = "white";
const ACTIVE_COLOR = "rgb(180, 180, 180)";

export default class AreaThingControlsMoveButton extends CommonAreaHudButton {
  constructor(callback: Function) {
    super(BUTTON_SIZE, IMAGE_SIZE, IMAGE_PATH, DEFAULT_COLOR, HOVER_COLOR, ACTIVE_COLOR, callback);
  }
}