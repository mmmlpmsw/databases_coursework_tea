// https://stackoverflow.com/questions/808826
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

export function fillRoundRect(ctx, x, y, width, height, radius) {
  return roundRect(ctx, x, y, width, height, radius, 'fill');
}

export function strokeRoundRect(ctx, x, y, width, height, radius) {
  return roundRect(ctx, x, y, width, height, radius, 'stroke');
}

// https://stackoverflow.com/questions/1255512
function roundRect(ctx, x, y, width, height, radius, mode: 'fill' | 'stroke') {
  if (typeof radius === 'undefined')
    radius = 0;
  if (typeof radius === 'number') {
    radius = {tl: radius, tr: radius, br: radius, bl: radius};
  } else {
    let defaultRadius = {tl: 0, tr: 0, br: 0, bl: 0};
    for (let side in defaultRadius) {
      radius[side] = radius[side] || defaultRadius[side];
    }
  }
  ctx.beginPath();
  ctx.moveTo(x + radius.tl, y);
  ctx.lineTo(x + width - radius.tr, y);
  ctx.quadraticCurveTo(x + width, y, x + width, y + radius.tr);
  ctx.lineTo(x + width, y + height - radius.br);
  ctx.quadraticCurveTo(x + width, y + height, x + width - radius.br, y + height);
  ctx.lineTo(x + radius.bl, y + height);
  ctx.quadraticCurveTo(x, y + height, x, y + height - radius.bl);
  ctx.lineTo(x, y + radius.tl);
  ctx.quadraticCurveTo(x, y, x + radius.tl, y);
  ctx.closePath();
  if (mode == 'fill')
    ctx.fill();
  if (mode == 'stroke')
    ctx.stroke();
}