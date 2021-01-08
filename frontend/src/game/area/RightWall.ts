import StaticImageRenderer from "$src/game/StaticImageRenderer";

export default class RightWall extends StaticImageRenderer {
  private static IMAGE = new Image();
  private static IMAGE_SRC = "assets/image/game/area/wall.png";

  static staticInit() {
    RightWall.IMAGE.src = this.IMAGE_SRC;
  }

  constructor() {
    super(RightWall.IMAGE, 0, -350, RightWall.IMAGE.width, RightWall.IMAGE.height);
  }
}

RightWall.staticInit();