import planck from 'planck-js';

export default function () {

  const TARGET_SELECTOR = "[physical-body]";
  const SCALE = 1/200;

  cheatCode.addCheatListener("ALLFALLSDOWN", activate);

  let objects = [];

  let world = null;

  let walls = {};

  function activate() {
    cheatCode.addCheatListener("ALLFALLSDOWN", null);
    world = planck.World({
      gravity: planck.Vec2(0, 10),
    });
    document.body.style.overflow = 'hidden';

    createWalls();

    let targetElements = document.querySelectorAll(TARGET_SELECTOR);

    for (let i = 0; i < targetElements.length; i++) {
      let object = {};
      object.el = targetElements[i];

      let rect = object.el.getBoundingClientRect();

      if (rect.x < 0 || rect.y < 0 || rect.x + rect.width > window.innerWidth ||
          rect.y + rect.height > window.innerHeight)
        continue;

      if (object.el.hasAttribute('physical-body-size-scale')) {
        let scale = parseFloat(object.el.getAttribute('physical-body-size-scale'));
        rect.width *= scale;
        rect.height *= scale;
      }

      if (object.el.hasAttribute('physical-body-bg'))
        object.el.style.background = object.el.getAttribute('physical-body-bg');

      object.body = world.createBody({
        type: "dynamic",
        position: planck.Vec2(rect.x*SCALE + rect.width*SCALE/2, rect.y*SCALE + rect.height*SCALE/2),
        linearDamping: 0,
        angularVelocity: Math.random() - 0.5,
        linearVelocity: planck.Vec2(2*(Math.random() - 0.5), 2*(Math.random() - 0.5)),
        fixedRotation: false
      });
      if (object.el.hasAttribute('physical-body-circle')) {
        object.body.createFixture({
          density: 1,
          friction: .1,
          shape: planck.Circle(
            planck.Vec2(0, 0),
            (rect.width / 2 * SCALE + rect.height / 2 * SCALE)/2,
          )
        });
      } else {
        object.body.createFixture({
          density: 1,
          friction: .1,
          shape: planck.Box(
            rect.width / 2 * SCALE,
            rect.height / 2 * SCALE,
            planck.Vec2(0, 0)
          )
        });
      }
      object.boundingRect = rect;
      objects.push(object);
    }

    setInterval(update, 1000/30);
  }

  function createWalls() {
    walls['top'] = createStaticBox(window.innerWidth*SCALE/2, -0.5, window.innerWidth*SCALE, 1);
    walls['bottom'] = createStaticBox(window.innerWidth*SCALE/2, window.innerHeight*SCALE + 0.5, window.innerWidth*SCALE, 1);
    walls['left'] = createStaticBox(-0.5, window.innerHeight*SCALE/2, 1, window.innerHeight*SCALE);
    walls['right'] = createStaticBox(window.innerWidth*SCALE + 0.5, window.innerHeight*SCALE/2, 1, window.innerHeight*SCALE);
  }

  function createStaticBox(x, y, w, h) {
    let body = world.createBody({
      type: "static",
      position: planck.Vec2(x, y)
    });
    body.createFixture({
      shape: planck.Box(
        w/2,
        h/2,
        planck.Vec2(0, 0)
      )
    });
    return body;
  }

  let lastMillis = null;
  function update() {
    if (lastMillis == null)
      lastMillis = Date.now();
    let delta = Date.now() - lastMillis;

    world.step(1/60);

    for (let i = 0; i < objects.length; i++) {
      let object = objects[i];
      let rect = object.boundingRect;

      object.el.style.position = 'relative';
      object.el.style.zIndex = 9999999 + i + '';
      object.el.style.transform = `translate(${object.body.getPosition().x/SCALE - rect.x - rect.width/2}px, ${object.body.getPosition().y/SCALE - rect.y - rect.height/2}px) rotate(${object.body.getAngle()}rad)`;
    }

    lastMillis = Date.now();
  }
}