import Renderable from "$src/game/Renderable";

export default class Layer implements Renderable {
  private renderables: Renderable[];

  enabled: boolean;

  constructor(renderables = [], enabled = true) {
    this.renderables = renderables;
    this.enabled = enabled;
  }

  render(ctx, idx) {
    if (!this.enabled)
      return;

    for (let i = 0, n = this.renderables.length; i < n; i++)
      this.renderables[i].render(ctx, i);
  }

  addRenderable(renderable: Renderable) {
    this.renderables.push(renderable);
  }

  removeRenderable(renderable: Renderable) {
    let index = this.renderables.indexOf(renderable);
    if (index != -1)
      this.renderables.splice(index, 1);
  }

  sort(compareFunction) {
    this.renderables.sort(compareFunction);
  }
}