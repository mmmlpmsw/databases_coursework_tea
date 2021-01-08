import StaticImageRenderer from "$src/game/StaticImageRenderer";

export default class LeftWall extends StaticImageRenderer {
  private static IMAGE = new Image();
  private static IMAGE_SRC = "assets/image/game/area/wall.png";

  static staticInit() {
    LeftWall.IMAGE.src = this.IMAGE_SRC;
  }

  constructor() {
    super(LeftWall.IMAGE, 0, -350, LeftWall.IMAGE.width, LeftWall.IMAGE.height);
  }

  render(ctx: CanvasRenderingContext2D, idx: number) {
    ctx.save();
    ctx.scale(-1, 1);
    super.render(ctx, idx);
    ctx.restore();
  }
}

LeftWall.staticInit();