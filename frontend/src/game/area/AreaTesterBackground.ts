import Renderable from "$src/game/Renderable";

const TEXT_MARGIN = 5;
const GRID_STEP = 100;

export default class AreaTesterBackground implements Renderable {
  inGameSizeX: number;
  inGameSizeY: number;
  transformation: DOMMatrix;

  constructor(inGameSizeX: number, inGameSizeY: number, transformation: DOMMatrix = null) {
    this.inGameSizeX = inGameSizeX;
    this.inGameSizeY = inGameSizeY;
    this.transformation = transformation || new DOMMatrix();
  }

  render(ctx: CanvasRenderingContext2D, idx: number) {
    ctx.save();
    ctx.fillStyle = 'grey';
    let t = this.transformation;
    ctx.transform(t.a, t.b, t.c, t.d, t.e, t.f);
    ctx.fillRect(0, 0, this.inGameSizeX, this.inGameSizeY);

    ctx.strokeStyle = "grey";
    ctx.lineWidth = 1;

    for (let i = 0; i <= this.inGameSizeX; i += GRID_STEP) {
      ctx.beginPath();
      ctx.moveTo(i, 0);
      ctx.lineTo(i, this.inGameSizeY);
      ctx.stroke();
    }

    for (let i = 0; i <= this.inGameSizeY; i += GRID_STEP) {
      ctx.beginPath();
      ctx.moveTo(0, i);
      ctx.lineTo(this.inGameSizeX, i);
      ctx.stroke();
    }

    // ctx.strokeStyle = 'rgba(0, 0, 0, .5)';
    // ctx.fillStyle = 'black';
    // ctx.setLineDash([2, 2]);
    // ctx.lineWidth = 2;
    // ctx.textBaseline = "top";
    // ctx.font = '18px sans-serif';

    // for (let i = 0; i <= this.inGameSizeX; i += GRID_STEP) {
    //   ctx.beginPath();
    //   ctx.moveTo(i, 0);
    //   ctx.lineTo(i, this.inGameSizeY);
    //   ctx.stroke();
    //
    //   ctx.fillText(i.toString(), i + TEXT_MARGIN, TEXT_MARGIN);
    // }
    //
    // for (let i = 0; i <= this.inGameSizeY; i += GRID_STEP) {
    //   ctx.beginPath();
    //   ctx.moveTo(0, i);
    //   ctx.lineTo(this.inGameSizeX, i);
    //   ctx.stroke();
    //
    //   ctx.fillText(i.toString(), TEXT_MARGIN, i + TEXT_MARGIN);
    // }

    ctx.restore();
  }
}