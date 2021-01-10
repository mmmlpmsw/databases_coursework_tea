import StaticImageRenderer from "$src/game/StaticImageRenderer";

export default class StaticBuildingRenderer extends StaticImageRenderer {
  private static IMAGE = new Image();
  private static IMAGE_SRC = "assets/image/game/area/building_static.png";
  private static IMAGE_Y_OFFSET = -587;

  static staticInit() {
    StaticBuildingRenderer.IMAGE.src = this.IMAGE_SRC;
  }

  constructor() {
    super(new Image(), 0, 0, 0, 0);
    StaticBuildingRenderer.IMAGE.onload = () => {
      this.image = StaticBuildingRenderer.IMAGE;
      this.x = -StaticBuildingRenderer.IMAGE.width/2;
      this.y = StaticBuildingRenderer.IMAGE_Y_OFFSET;
      this.width = StaticBuildingRenderer.IMAGE.width;
      this.height = StaticBuildingRenderer.IMAGE.height;
    };
  }
}

StaticBuildingRenderer.staticInit();