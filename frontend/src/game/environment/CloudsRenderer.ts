import Layer from "$src/layers/Layer";
import CloudRenderer from "$src/game/environment/CloudRenderer";

export default class CloudsRenderer extends Layer {
  private static readonly CLOUD_IMAGES_NUM = 5;
  private static readonly FOG_IMAGES_NUM = 6;
  private cloudImages = [];
  private fogs = [];

  private clouds = [];

  private minX: number;
  private maxX: number;
  private minY: number;
  private maxY: number;

  private minParallax: number;
  private maxParallax: number;

  private cloudsNum: number;

  private lastRenderTime: number = Date.now();

  constructor(minX: number, maxX: number, minY: number, maxY: number, cloudsNum: number, minParallax: number = 1, maxParallax: number = 1) {
    super();

    this.minX = minX;
    this.maxX = maxX;
    this.maxY = minY;
    this.minY = minY;

    this.cloudsNum = cloudsNum;

    this.minParallax = minParallax;
    this.maxParallax = maxParallax;

    this.loadCloudImages().then(() => {this.generateClouds()});
  }

  render(ctx, idx) {
    super.render(ctx, idx);
    let delta = Date.now() - this.lastRenderTime;

    if (delta > 500) {
      this.lastRenderTime = Date.now();
      return;
    }

    this.clouds.forEach(c => {
      c.x += c.speed*delta;
      if (c.x > this.maxX)
        c.x = this.minX - c.width;
    });

    this.lastRenderTime += delta;
  }

  private generateClouds() {
    for (let i = 0; i < this.cloudsNum; i++) {
      let img = this.randomCloudImage();
      let cloud = new CloudRenderer(
        CloudsRenderer.random(this.minX - img.width, this.maxX),
        CloudsRenderer.random(this.minY, this.maxY),
        CloudsRenderer.random(1, 1.5),
        CloudsRenderer.random(this.minParallax, this.maxParallax),
        img
      );
      cloud.speed = .01 + .05*Math.random();
      this.clouds.push(cloud);
    }
    this.clouds.sort((a, b) => a.parallaxFactor - b.parallaxFactor);
    this.clouds.forEach((r) => this.addRenderable(r));
  }

  private static random(min, max) {
    return min + Math.random()*(max - min);
  }

  private randomCloudImage() {
    return this.cloudImages[Math.floor(Math.random()*this.cloudImages.length)];
  }

  private loadCloudImages() {
    return new Promise((resolve) => {
      let counter = 0;

      let count = () => {
        if (++counter == CloudsRenderer.CLOUD_IMAGES_NUM)
          resolve(null)
      };

      for (let i = 0; i < CloudsRenderer.CLOUD_IMAGES_NUM; i++) {
        let img = new Image();
        img.onload = () => {
          this.cloudImages.push(img);
          count();
        };
        img.onerror = count;
        img.src = `assets/image/game/clouds/cloud${i}.png`;
      }
    });
  }
}