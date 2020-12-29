import Renderable from "$src/ui/Renderable";

const TEXT_MARGIN = 5;
const GRID_STEP = 100;

export default class AreaBackground implements Renderable {
  inGameSizeX: number;
  inGameSizeY: number;

  constructor(inGameSizeX: number, inGameSizeY: number) {
    this.inGameSizeX = inGameSizeX;
    this.inGameSizeY = inGameSizeY;
  }

  render(ctx: CanvasRenderingContext2D, idx: number) {
    ctx.save();
    ctx.fillStyle = 'grey';
    ctx.scale(1, 0.5);
    ctx.rotate(Math.PI/4);
    ctx.fillRect(0, 0, this.inGameSizeX, this.inGameSizeY);

    ctx.strokeStyle = 'rgba(0, 0, 0, .5)';
    ctx.fillStyle = 'black';
    ctx.setLineDash([2, 2]);
    ctx.lineWidth = 2;
    ctx.textBaseline = "top";
    ctx.font = '18px sans-serif';

    for (let i = 0; i <= this.inGameSizeX; i += GRID_STEP) {
      ctx.beginPath();
      ctx.moveTo(i, 0);
      ctx.lineTo(i, this.inGameSizeY);
      ctx.stroke();

      ctx.fillText(i.toString(), i + TEXT_MARGIN, TEXT_MARGIN);
    }

    for (let i = 0; i <= this.inGameSizeY; i += GRID_STEP) {
      ctx.beginPath();
      ctx.moveTo(0, i);
      ctx.lineTo(this.inGameSizeX, i);
      ctx.stroke();

      ctx.fillText(i.toString(), TEXT_MARGIN, i + TEXT_MARGIN);
    }

    ctx.restore();
  }
}