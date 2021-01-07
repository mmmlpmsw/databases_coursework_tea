import Interactive from "./Interactive";
import Renderable from "./Renderable";


export default class TestButton extends Interactive implements Renderable {
  render(ctx, idx) {
    this.drawButton(ctx);
  }

  drawButton(ctx) {
    ctx.strokeStyle = 'black';
    ctx.fillStyle = this.hover ? 'rgb(34,255,0)' : 'red';
    ctx.fillStyle = this.active ? 'rgb(104,101,100)': null;
    ctx.lineCap = "round";
    ctx.lineWidth = 1;
    ctx.fillRect(0, 0, this.width, this.height);
    ctx.strokeRect(0, 0, this.width, this.height);
  }

  processMouseEnter(x: number, y: number) {
    console.log("Mouse enter");
  }

  processMouseLeave(x: number, y: number) {
    console.log("Mouse leave");
  }

  processMouseDown(x: number, y: number) {
    console.log("Mouse down");
    return false;
  }

  processMouseUp(x: number, y: number) {
    console.log("Mouse up");
    return false;
  }

  processMouseMove(x: number, y: number) {
    console.log("Mouse move");
    return false;
  }

  processMouseClick(x: number, y: number) {
    console.log("Mouse click");
    return false;
  }
}