import AreaThing from "$src/game/area/thing/AreaThing";
import {Store} from "vuex";
import GameState from "$src/game/model/GameState";
import Machine from "$src/game/model/Machine";
import EventBusConstants from "$src/util/EventBusConstants";

function getAreaThingImageUrl(id, index) {
  return `assets/image/game/area/things/id${id}/${index}.png`;
}

let STATIC_IMAGE_RENDERER_GENERATOR_GENERATOR = (imageSrc, xOffset, yOffset) => {
  return (thisRef: AreaThing) => {
    let image = new Image();
    image.src = imageSrc;
    let superRender = thisRef.render;
    return (context: CanvasRenderingContext2D, idx: number) => {
      context.save();
      superRender.apply(thisRef, [context, idx]);
      let scale = thisRef.width/image.width;
      let x = thisRef.x + xOffset;
      let y = thisRef.y + thisRef.height + yOffset - image.height*scale;
      context.drawImage(image, x, y, image.width*scale, image.height*scale);
      context.restore();
    }
  }
};

let ANIMATED_IMAGE_RENDERER_GENERATOR_GENERATOR = (imageSources, xOffset, yOffset) => {
  return (thisRef: AreaThing) => {
    let images = [];
    for (let source of imageSources) {
      let img = new Image();
      img.src = source;
      images.push(img);
    }
    let superRender = thisRef.render;
    let srcIdx = 0;
    let dstIdx = (srcIdx + 1) % images.length;
    let normalizedAnimationPosition = 0;
    return (context: CanvasRenderingContext2D, idx: number) => {
      context.save();
      superRender.apply(thisRef, [context, idx]);
      let scale = thisRef.width/images[dstIdx].width;
      let x = thisRef.x + xOffset;
      let y = thisRef.y + thisRef.height + yOffset - images[dstIdx].height*scale;
      context.drawImage(images[srcIdx], x, y, images[srcIdx].width*scale, images[srcIdx].height*scale);
      if (context.globalAlpha == 1) {
        context.globalAlpha = normalizedAnimationPosition;
        context.drawImage(images[dstIdx], x, y, images[dstIdx].width * scale, images[dstIdx].height * scale);
      }
      context.restore();

      normalizedAnimationPosition += 1/60;
      if (normalizedAnimationPosition > 1) {
        normalizedAnimationPosition = 0;
        srcIdx = (srcIdx + 1) % images.length;
        dstIdx = (dstIdx + 1) % images.length;
      }
    }
  }
};

let RENDERER_GENERATOR_BY_MACHINE_ID: { [key:number]: (MachineAreaThing) => (CanvasRenderingContext2D, number) => void } = {
  1: STATIC_IMAGE_RENDERER_GENERATOR_GENERATOR(getAreaThingImageUrl(1, 0), 0, 0),
  2: STATIC_IMAGE_RENDERER_GENERATOR_GENERATOR(getAreaThingImageUrl(2, 0), 0, 0),
  3: STATIC_IMAGE_RENDERER_GENERATOR_GENERATOR(getAreaThingImageUrl(3, 0), 0, 35),
  4: ANIMATED_IMAGE_RENDERER_GENERATOR_GENERATOR([0, 8, 16, 24, 32].map(i => getAreaThingImageUrl(4, i)), 0, 45),
  5: STATIC_IMAGE_RENDERER_GENERATOR_GENERATOR(getAreaThingImageUrl(5, 0), 0, 0),
  6: STATIC_IMAGE_RENDERER_GENERATOR_GENERATOR(getAreaThingImageUrl(6, 0), 0, 0)
};

export default class MachineAreaThingFactory {
  public static createInstance(instanceId: number, store: Store<GameState>): AreaThing {
    let instance = store.state.game.machineInstances[instanceId];
    if (!instance)
      throw new Error(`Instance with id ${instanceId} not found`);

    let machine = store.state.game.machines[instance.machineId];
    let thing = new AreaThing(instance.areaX, instance.areaY, machine.sizeX, machine.sizeY);
    thing.render = RENDERER_GENERATOR_BY_MACHINE_ID[instance.machineId](thing);
    let superClickFn = thing.processMouseClick;
    thing.processMouseClick = (x, y) => {
      if (thing.selected && thing.eventBus && thing['instance'])
        thing.eventBus.$emit(EventBusConstants.REQUEST_MACHINE_RECIPES_DIALOG, thing['instance'].id);
      else
        superClickFn.apply(thing, [x, y]);
      return false;
    };
    thing['instance'] = instance;
    return thing;
  }

  public static createAnonymousInstance(machine: Machine, areaX: number, areaY: number) {
    let thing = new AreaThing(areaX, areaY, machine.sizeX, machine.sizeY);
    thing.render = RENDERER_GENERATOR_BY_MACHINE_ID[machine.id](thing);
    let superClickFn = thing.processMouseClick;
    thing.processMouseClick = (x, y) => {
      if (thing.selected && thing.eventBus && thing['instance'])
        thing.eventBus.$emit(EventBusConstants.REQUEST_MACHINE_RECIPES_DIALOG, thing['instance'].id);
      else
        superClickFn.apply(thing, [x, y]);
      return false;
    };
    return thing;
  }
}