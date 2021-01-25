import Renderable from "$src/game/Renderable";

export default class AreaThingAdder implements Renderable {

  constructor(private mover: AreaThingAdder) {}

  render(ctx: CanvasRenderingContext2D, idx: number) {
    // todo
  }
}