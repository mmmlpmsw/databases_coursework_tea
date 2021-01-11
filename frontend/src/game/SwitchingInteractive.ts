import Interactive from "$src/game/Interactive";
import CompositeInteractive from "$src/game/CompositeInteractive";

type InteractivesMap = { [key:string]: Interactive };

const NULL_INTERACTIVE = new class extends Interactive {
  constructor() {
    super(0, 0, 0, 0);
  }
};

export default class SwitchingInteractive extends CompositeInteractive {
  private readonly map: InteractivesMap = {};
  private proxy: Interactive = NULL_INTERACTIVE;

  constructor(initialInteractiveName, map: InteractivesMap) {
    super();
    this.map = map;
    this.switch(initialInteractiveName);
  }

  public switch(name) {
    this.removeInteractive(this.proxy);
    if (this.map[name]) {
      this.proxy = this.map[name];
    } else {
      this.proxy = NULL_INTERACTIVE;
    }
    this.addInteractive(this.proxy);
  }
}