export function saturate(value, min, max) {
  return value < min ? min : value > max ? max : value;
}