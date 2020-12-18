export default function () {
  let map = {};
  let maxBufferLength = 0;
  let buffer = '';

  let activationSound = new Audio('/assets/media/cheat_activated.wav');
  activationSound.load();

  this.addCheatListener = function (code, handler) {
    if (handler == null)
      delete map[code.toUpperCase()];
    else
      map[code.toUpperCase()] = handler;

    for (let it in map)
      if (it.length > maxBufferLength)
        maxBufferLength = it.length;
  };

  window.addEventListener('keypress', onKeyPress);

  function onKeyPress(event) {
    if (event.key.length === 1) { // It's a character key
      buffer += event.key.toUpperCase();
      if (buffer.length > maxBufferLength)
        buffer = buffer.substring(1);

      for (let it in map) {
        if (buffer.endsWith(it)) {
          activationSound.play();
          setTimeout(() => {
            showActivationLabel();
            map[it]();
          }, 300);
        }
      }
    }
  }

  function showActivationLabel() {
    let label = document.createElement('div');
    label.innerText = "Cheat activated";
    label.style.padding = '10px';
    label.style.background = 'rgba(0, 0, 0, .6)';
    label.style.position = 'fixed';
    label.style.width = '300px';
    label.style.left = '65px';
    label.style.top = '65px';
    label.style.zIndex = '99999999999';
    label.style.fontWeight = '900';
    label.style.fontSize = '22px';
    label.style.color = 'white';
    document.body.append(label);
    setTimeout(() => {label.outerHTML = ''}, 3500);
  }
};