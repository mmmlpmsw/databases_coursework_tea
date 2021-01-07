import Interactive from "$src/game/Interactive";

export default class CompositeInteractive extends Interactive {
  private children: Interactive[] = [];

  addInteractive(interactive: Interactive) {
    this.children.push(interactive);
  }

  removeInteractive(interactive: Interactive) {
    let index = this.children.indexOf(interactive);
    if (index != -1)
      this.children.splice(index, 1);
  }

  processMouseClick(x: number, y: number) {
    return this.rayTraceAndCall(x, y, c => c.processMouseClick(x, y));
  };

  processMouseDown(x: number, y: number) {
    return this.rayTraceAndCall(x, y, c => {
      c.active = true;
      c.processMouseDown(x, y);
    })
  };

  processMouseUp(x: number, y: number) {
    return this.rayTraceAndCall(x, y, c => {
      c.active = false;
      c.processMouseUp(x, y);
    })
  };

  processMouseMove(x: number, y: number) {
    let rayTracingDone = false;

    this.children.forEach(item => {
      if (item.isPointOnItem(x, y) && !rayTracingDone) {
        if (!item.hover) {
          item.hover = true;
          item.processMouseEnter(x, y);
        }
        if (!item.processMouseMove(x, y))
          rayTracingDone = true;
      } else {
        if (item.hover) {
          item.hover = false;
          item.processMouseLeave(x, y);
        }
      }
    });

    return !rayTracingDone;
  };

  processMouseLeave(x: number, y: number) {
    // Disable hover for each child when mouse leaves parent
    this.children.forEach(item => {
      if (item.hover) {
        item.hover = false;
        item.processMouseLeave(x, y);
      }
    });
  };

  private rayTraceAndCall(x: number, y: number, callback: Function): boolean {
    this.children.forEach(c => {
      if (c.isPointOnItem(x, y)) {
        if (!callback.call(this, c))
          return false;
      }
    });
    return true;
  }
}