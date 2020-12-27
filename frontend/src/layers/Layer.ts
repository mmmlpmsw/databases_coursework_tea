import Renderable from "$src/ui/Renderable";

export default class Layer implements Renderable {
  renderables: Renderable[];
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
}