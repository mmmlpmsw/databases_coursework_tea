import StaticImageRenderer from "$src/game/StaticImageRenderer";

export default class StaticBuildingRenderer extends StaticImageRenderer {
  private static IMAGE = new Image();
  private static IMAGE_SRC = "assets/image/game/area/building_static.png";
  private static IMAGE_Y_OFFSET = -587;

  static staticInit() {
    StaticBuildingRenderer.IMAGE.src = this.IMAGE_SRC;
  }

  constructor() {
    super(
      StaticBuildingRenderer.IMAGE,
      -StaticBuildingRenderer.IMAGE.width/2,
      StaticBuildingRenderer.IMAGE_Y_OFFSET,
      StaticBuildingRenderer.IMAGE.width,
      StaticBuildingRenderer.IMAGE.height
    );
  }
}

StaticBuildingRenderer.staticInit();