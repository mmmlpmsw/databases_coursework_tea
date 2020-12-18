<!--TODO this may not work-->
<template>
  <div class="tetris_wr" :class="{ hidden }">
    <transition-expand>
      <div class="tetris" v-if="!hidden" :class="{ 'failed': game.failed }">

        <div class="content">
          <canvas class="canvas" ref="canvas" width="700" height="1000"/>
          <div class="aside">
            <div class="next_elem">{{$t( 'components.tetris_game.next_elem' )}}</div>
            <canvas class="canvas_aside" ref="canvas_aside" width="500" height="400"/>
            <div class="scores">{{ game.scores }}</div>
            <transition-expand>
              <div class="pls_give_points" v-if="game.scores > 0">{{$t( 'components.tetris_game.pls_give_points' )}}</div>
            </transition-expand>
          </div>
        </div>

        <div class="exit_hint">{{$t( 'components.tetris_game.esc_to_exit' )}}</div>
        <div class="common_center_msg" v-if="state === 'before_start'">{{$t( 'components.tetris_game.before_start_msg' )}}</div>
        <div class="common_center_msg" v-if="state === 'pause'">{{$t( 'components.tetris_game.pause' )}}</div>

      </div>
    </transition-expand>
  </div>
</template>

<script>
  import TransitionExpand from "#/components/TransitionExpand";

  const
    EMPTY = 'transparent',
    RED = 'rgb(255,0,59)',
    GREEN = 'rgb(92,255,14)',
    BLUE = 'rgb(46,105,255)',
    YELLOW = 'rgb(235,155,46)',
    PURPLE = 'rgb(186,78,235)';

  const COLORS = [ RED, GREEN, BLUE, YELLOW, PURPLE ];
  const FIGURES = 'IOTSZJL'.split('');

  const MODELS = {
    'I': [
      [ [0, 0], [1, 0], [-1, 0], [-2, 0] ],
      [ [0, 0], [0, -1], [0, 1], [0, 2] ]
    ],
    'O': [
      [ [0, 0], [0, 1], [-1, 1], [-1, 0] ]
    ],
    'T': [
      [ [0, 0], [1, 0], [-1, 0], [0, 1] ],
      [ [0, 0], [1, 0], [0, -1], [0, 1] ],
      [ [0, 0], [1, 0], [0, -1], [-1, 0] ],
      [ [0, 0], [0, 1], [0, -1], [-1, 0] ],
    ],
    'S': [
      [ [0, 0], [1, 0], [0, 1], [-1, 1] ],
      [ [0, 0], [1, 0], [0, -1], [1, 1] ]
    ],
    'Z': [
      [ [0, 0], [-1, 0], [0, 1], [1, 1] ],
      [ [0, 0], [1, 0], [0, 1], [1, -1] ]
    ],
    'J': [
      [ [0, 0], [-1, 0], [1, 0], [1, 1] ],
      [ [0, 0], [0, -1], [0, 1], [1, -1] ],
      [ [0, 0], [-1, 0], [1, 0], [-1, -1] ],
      [ [0, 0], [0, -1], [0, 1], [-1, 1] ]
    ],
    'L': [
      [ [0, 0], [-1, 0], [1, 0], [-1, 1] ],
      [ [0, 0], [0, -1], [0, 1], [1, 1] ],
      [ [0, 0], [-1, 0], [1, 0], [1, -1] ],
      [ [0, 0], [0, -1], [0, 1], [-1, -1] ],
    ],
  };

  export default {
    components: { TransitionExpand },
    data() {
      return {
        hidden: true,
        state: 'before_start',
        tickingTimeoutId: null,
        game: {
          width: 14,
          height: 20,
          ticksPerSec: 1,
          failed: false,
          scores: 0,
          area: [],
          current: {
            figure: null,
            color: null,
            position: [0, 0],
            rotation: null,
          },
          next: {
            figure: null,
            color: null,
          }
        }
      }
    },
    methods: {
      activate() {
        this.hidden = false;
        this.$parent.blurCurrentView = true;
        setTimeout(this.renderGame, 0);
        window.addEventListener('keydown',  this.onKeyDown);
      },
      deactivate() {
        window.removeEventListener('keydown',  this.onKeyDown);
        this.stopTicking();
        this.state = 'pause';
        this.hidden = true;

        this.$parent.blurCurrentView = false;
      },
      initArea() {
        let area = [];

        for (let row = 0; row < this.game.height; row++) {
          area[row] = [];
          for (let column = 0; column < this.game.width; column++)
            area[row][column] = EMPTY;
        }

        this.game.area = area;
      },
      iterateFigures() {
        if (this.game.current.figure != null) {
          let modelPack = MODELS[this.game.current.figure];
          let model = modelPack[this.game.current.rotation % modelPack.length];
          let [x, y] = this.game.current.position;

          for (let i = 0; i < model.length; i++)
            this.game.area[y + model[i][1]][x + model[i][0]] = this.game.current.color;
        }

        if (this.game.next.figure == null) {
          this.game.next.figure = FIGURES[Math.floor(Math.random()*FIGURES.length)];
          this.game.next.color = COLORS[Math.floor(Math.random()*COLORS.length)];
        }

        this.game.current.figure = this.game.next.figure;
        this.game.current.color = this.game.next.color;
        this.game.current.position = [Math.floor(this.game.width/2), 0];
        this.game.current.rotation = 0;
        this.game.next.figure = FIGURES[Math.floor(Math.random()*FIGURES.length)];
        this.game.next.color = COLORS[Math.floor(Math.random()*COLORS.length)];

        let absoluteModel = this.generateAbsoluteModelPoints(
          this.game.current.position[0],
          this.game.current.position[1],
          MODELS[this.game.current.figure][this.game.current.rotation % MODELS[this.game.current.figure].length]
        );

        if (this.arePointsOverlappingArea(absoluteModel)) {
          this.stopTicking();
          this.state = 'before_start';
          this.game.failed = true;
          this.game.current.figure = null;
          this.game.next.figure = null;
        }

        this.checkForSolidRows();
      },
      onKeyDown(event) {
        let key = event.key;

        switch (key) {
          case 'Escape':
            if (this.hidden === false)
              this.deactivate();
            break;

          case 'Enter':
            switch (this.state) {
              case 'before_start':
                this.game.failed = false;
                this.initArea();
                this.iterateFigures();
                this.state = 'game';
                this.game.scores = 0;
                this.tick();
                break;
              case 'game':
                this.state = 'pause';
                this.stopTicking();
                break;
              case 'pause':
                this.state = 'game';
                this.tick();
                break;
            }
            break;

          case 'ArrowLeft':
            if (this.state === 'game')
              this.trySideMove(-1);
            this.correctCurrentFigureBounds();
            this.renderGame();
            break;

          case 'ArrowRight':
            if (this.state === 'game')
              this.trySideMove(1);
            this.correctCurrentFigureBounds();
            this.renderGame();
            break;

          case 'ArrowDown':
            if (this.state === 'game')
              this.tick();
            break;

          case 'ArrowUp':
            if (this.state === 'game')
              this.game.current.rotation++;
            this.correctCurrentFigureBounds();
            this.renderGame();
            break;
        }
      },
      getFigureBounds(figure, position, rotation) {
        let [x, y] = position;

        let r = (l, r, t, b) => { return { left: x + l, right: x + r, top: y + t, bottom: y + b } };

        switch (figure) {
          case 'I':
            if (rotation % 2 === 0) // 0 or 2: figure is horizontal
              return r(-2, 1, 0, 0);
            else
              return r(0, 0, -1, 2);

          case 'O':
            return r(-1, 0, 0, 1);

          case 'T':
          case 'J':
          case 'L':
            switch (rotation % 4) {
              case 0: return r(-1, 1, 0, 1);
              case 1: return r(0, 1, -1, 1);
              case 2: return r(-1, 1, -1, 0);
              case 3: return r(-1, 0, -1, 1);
              default:
                return r(-1, 1, -1, 1);
            }

          case 'S':
          case 'Z':
            if (rotation % 2 === 0) // 0 or 2: figure is horizontal
              return r(-1, 1, 0, 1);
            else
              return r(0, 1, -1, 1);
        }
        console.error('Unknown figure: ' + figure);
        return r(-1, 1, -1, 1);
      },
      correctCurrentFigureBounds() {
        let bounds = this.getFigureBounds(this.game.current.figure, this.game.current.position, this.game.current.rotation);
        if (bounds.left < 0)
          this.game.current.position[0] -= bounds.left;
        if (bounds.top < 0)
          this.game.current.position[1] -= bounds.top;
        if (bounds.right >= this.game.width)
          this.game.current.position[0] += this.game.width - bounds.right - 1;
        if (bounds.bottom >= this.game.height)
          this.game.current.position[1] += this.game.height - bounds.bottom - 1;
      },
      arePointsOverlappingArea(points) {
        for (let i = 0; i < points.length; i++) {
          let point = points[i];

          if (point[0] < 0 || point[0] >= this.game.width || point[1] < 0 || point[1] >= this.game.height)
            continue;

          if (this.game.area[point[1]][point[0]] !== EMPTY)
            return true;
        }
        return false;
      },
      generateAbsoluteModelPoints(x, y, model) {
        let result = [];
        for (let i = 0; i < model.length; i++)
          result.push([ x + model[i][0], y + model[i][1] ]);
        return result;
      },
      trySideMove(shift) {
        let futureAbsoluteModel = this.generateAbsoluteModelPoints(
          this.game.current.position[0] + shift,
          this.game.current.position[1],
          MODELS[this.game.current.figure][this.game.current.rotation % MODELS[this.game.current.figure].length]
        );

        if (!this.arePointsOverlappingArea(futureAbsoluteModel))
          this.game.current.position[0] += shift;
      },
      checkForSolidRows() {
        let isRowSolid = r => {
          for (let i = 0; i < r.length; i++)
            if (r[i] === EMPTY)
              return false;
          return true;
        };

        let area = this.game.area;
        for (let row = area.length - 1; row >= 0; row--) {
          if (isRowSolid(area[row])) {

            area.splice(row, 1);

            let newRow = [];
            for (let i = 0; i < this.game.width; i++)
              newRow.push(EMPTY);
            area.unshift(newRow);

            this.checkForSolidRows();
            this.game.scores += this.game.width;
            break;
          }
        }
      },
      renderGame() {
        let canvas = this.$refs['canvas'];
        let ctx = canvas.getContext('2d');

        let asideCanvas = this.$refs['canvas_aside'];
        let actx = asideCanvas.getContext('2d');

        ctx.clearRect(0, 0, canvas.width, canvas.height);
        actx.clearRect(0, 0, asideCanvas.width, asideCanvas.height);

        let tileWidth = canvas.width/this.game.width;
        let tileHeight = canvas.height/this.game.height;

        ctx.fillTile = (x, y, padding = 1) => ctx.fillRect(
          tileWidth*x + padding,
          tileHeight*y + padding,
          tileWidth - padding*2,
          tileHeight - padding*2
        );

        if (this.game.current.figure) {
          ctx.fillStyle = this.game.current.color;
          let [x, y] = this.game.current.position;
          let r = this.game.current.rotation;

          let modelPack = MODELS[this.game.current.figure];
          let model = modelPack[r % modelPack.length];

          for (let i = 0; i < model.length; i++)
            ctx.fillTile(x + model[i][0], y + model[i][1]);
        }

        let area = this.game.area;
        for (let row = 0; row < area.length; row++) {
          for (let column = 0; column < area[row].length; column++) {

            ctx.fillStyle = area[row][column];
            ctx.fillTile(column, row);
          }
        }

        if (this.game.next.figure) {
          let model = MODELS[this.game.next.figure][0];

          actx.fillStyle = this.game.next.color;
          for (let i = 0; i < model.length; i++)
            actx.fillRect(
              (2 + model[i][0]) * asideCanvas.width/5 + 2,
              (1 + model[i][1]) * asideCanvas.height/4 + 2,
              asideCanvas.width/5 - 4,
              asideCanvas.height/4 - 4
            );
        }

        ctx.lineWidth = 1;
        ctx.strokeStyle = 'black';
        ctx.strokeRect(0, 0, canvas.width, canvas.height);
      },
      tick() {
        if (this.state !== 'game')
          return;

        this.stopTicking();

        let futureBounds = this.getFigureBounds(
          this.game.current.figure,
          [this.game.current.position[0], this.game.current.position[1] + 1],
          this.game.current.rotation
        );

        if (futureBounds.bottom >= this.game.height) {
          this.iterateFigures();
        } else {

          let futureAbsoluteModel = this.generateAbsoluteModelPoints(
            this.game.current.position[0],
            this.game.current.position[1] + 1,
            MODELS[this.game.current.figure][this.game.current.rotation % MODELS[this.game.current.figure].length]
          );

          if (this.arePointsOverlappingArea(futureAbsoluteModel))
            this.iterateFigures();
          else {
            this.game.current.position[1]++;
            this.correctCurrentFigureBounds();
          }
        }

        this.renderGame();
        this.tickingTimeoutId = setTimeout(this.tick, 1000/this.game.ticksPerSec);
      },
      stopTicking() {
        if (this.tickingTimeoutId != null)
          clearTimeout(this.tickingTimeoutId);
      }
    },
    mounted() {
      cheatCode.setCheatListener('DAMNBRICKS', this.activate);
    }
  }
</script>

<style scoped>
  .hidden {
    opacity: 0;
    pointer-events: none;
  }

  .tetris_wr {
    position: fixed;
    width: 100vw;
    height: 100vh;
    background-color: rgba(0, 0, 0, 0.4);
    top: 0;
    left: 0;
    z-index: 1;
    transition: opacity 300ms;
    align-items: center;
    display: flex;
    flex-direction: column;
    justify-content: center;
  }

  .tetris {
    background: white;
    box-shadow: 0 0 5px rgba(0, 0, 0, .5);
    display: inline-block;
    max-width: calc(320px + 25%);
    max-height: 90vh;
    padding: 10px;
  }

  .exit_hint {
    opacity: 0.5;
    text-align: center;
    width: 100%;
  }

  .next_elem {
    margin-bottom: 8px;
  }

  .common_center_msg {
    position: fixed;
    left: 0;
    right: 0;
    top: 50%;
    text-align: center;
    padding: 10%;
    transform: translateY(-50%);
    font-size: 32px;
  }

  .content {
    display: flex;
    flex-direction: row;
  }

  .aside {
    padding: 15px 5px 15px 15px;
    text-align: center;
  }

  .scores,
  .pls_give_points {
    background: #e0e0e0;
    border: 1px solid #aaa;
    border-radius: 6px;
    text-align: center;
    font-size: 40px;
    margin-top: 20px;
  }

  .pls_give_points {
    font-size: 18px;
    padding: 10px;
  }

  canvas {
    max-width: 70%;
    background: #eee;
  }

  .failed {
    animation: failed_anim 300ms;
  }

  @keyframes failed_anim {
    0% {
      transform: translateX(-30px);
    }

    20% {
      transform: translateX(20px);
    }

    40% {
      transform: translateX(-13px);
    }

    60% {
      transform: translateX(8px);
    }

    80% {
      transform: translateX(-5px);
    }

    100% {
      transform: translateX(0px);
    }
  }
</style>