// https://stackoverflow.com/questions/808826/draw-arrow-on-canvas-tag
export function drawArrow(context, fromX, fromY, toX, toY, headLength = 10) {
  let dx = toX - fromX;
  let dy = toY - fromY;
  let angle = Math.atan2(dy, dx);
  context.beginPath();
  context.moveTo(fromX, fromY);
  context.lineTo(toX, toY);
  context.moveTo(toX, toY);
  context.lineTo(toX - headLength * Math.cos(angle - Math.PI / 6), toY - headLength * Math.sin(angle - Math.PI / 6));
  context.moveTo(toX, toY);
  context.lineTo(toX - headLength * Math.cos(angle + Math.PI / 6), toY - headLength * Math.sin(angle + Math.PI / 6));
  context.stroke();
}