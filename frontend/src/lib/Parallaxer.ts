export default class Parallaxer {
  public static parallax(origin: DOMMatrix, canvasWidth: number, canvasHeight: number, factor: number): DOMMatrix {
    // factor 1 - scale to zero
    // factor 0 - 1:1
    // factor -1 - double scale

    let scale = 1/origin.a;
    let diff = scale + factor;

    return origin.translate(
      (-origin.e + canvasWidth/2)*scale*factor,
      (-origin.f + canvasHeight/2)*scale*factor
    ).scale(
      (1 - factor) / diff * scale,
      (1 - factor) / diff * scale
    );
  }
}