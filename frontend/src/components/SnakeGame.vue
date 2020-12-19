<!--TODO this may not work-->
<template>
  <div class="tetris_wr" :class="{ hidden }">
    <transition-expand>
      <div class="tetris" v-if="!hidden" :class="{ 'failed': game.failed }">
        <canvas ref="canvas" width="1000" height="1000"/>
        <div class="exit_hint">{{$t( 'components.snake_game.esc_to_exit' )}}</div>
        <div class="common_center_msg" v-if="state === 'before_start'">{{$t( 'components.snake_game.before_start_msg' )}}</div>
        <div class="common_center_msg" v-if="state === 'pause'">{{$t( 'components.snake_game.pause' )}}</div>
      </div>
    </transition-expand>
  </div>
</template>

<script>
  import TransitionExpand from "$src/components/TransitionExpand";

  export default {
    components: { TransitionExpand },
    data() {
      return {
        hidden: true,
        state: 'before_start',
        tickingTimeoutId: null,
        game: {
          width: 20,
          height: 20,
          ticksPerSec: 3,
          failed: false,
          food: null,
          snakeSegments: [],
          nextStepVec: [0, -1],
          prevStepVec: [0, -1]
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
      isSnakeSegment(tile) {
        let segments = this.game.snakeSegments;
        for (let i = 0; i < segments.length; i++)
          if (segments[i][0] === tile[0] && segments[i][1] === tile[1])
            return true;
        return false;
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
                let segmentBase = [
                  Math.floor(this.game.width / 2),
                  Math.floor(this.game.height / 2) + 2 // We assume that snake's length will be 4 at start
                ];

                this.game.snakeSegments = [
                  [segmentBase[0], segmentBase[1] - 3],
                  [segmentBase[0], segmentBase[1] - 2],
                  [segmentBase[0], segmentBase[1] - 1],
                  [segmentBase[0], segmentBase[1]]
                ];
                this.state = 'game';
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
            if (this.game.prevStepVec[0] !== 1)
              this.game.nextStepVec = [-1, 0];
            break;

          case 'ArrowRight':
            if (this.game.prevStepVec[0] !== -1)
              this.game.nextStepVec = [1, 0];
            break;

          case 'ArrowUp':
            if (this.game.prevStepVec[1] !== 1)
              this.game.nextStepVec = [0, -1];
            break;

          case 'ArrowDown':
            if (this.game.prevStepVec[1] !== -1)
              this.game.nextStepVec = [0, 1];
            break;
        }
      },
      renderGame() {
        let canvas = this.$refs['canvas'];
        let ctx = canvas.getContext('2d');

        ctx.clearRect(0, 0, canvas.width, canvas.height);

        let tileWidth = canvas.width/this.game.width;
        let tileHeight = canvas.height/this.game.height;

        ctx.fillTile = (x, y, padding = 0) => ctx.fillRect(
          tileWidth*x + padding,
          tileHeight*y + padding,
          tileWidth - padding*2,
          tileHeight - padding*2
        );

        let segments = this.game.snakeSegments;
        let segmentsAreClose = (s1, s2) => Math.abs(s1[0] - s2[0]) <= 1 && Math.abs(s1[1] - s2[1]) <= 1;
        for (let i = 0; i < segments.length; i++) {
          let it = segments[i];
          ctx.fillStyle = `rgb(0, ${150 + 40*Math.sin(i/4 )}, 0)`;
          ctx.fillTile(...it, 12 - 12*(segments.length - i)/segments.length);
          if (i < segments.length-1 && segmentsAreClose(segments[i], segments[i+1])) {
            ctx.fillStyle = `rgb(0, ${150 + 40*Math.sin((i + 0.5)/4 )}, 0)`;
            ctx.fillTile(
              (segments[i][0] + segments[i + 1][0]) / 2,
              (segments[i][1] + segments[i + 1][1]) / 2,
              12 - 12 * (segments.length - i - 0.5) / segments.length
            );
          }
        }

        ctx.fillStyle = "rgb(132, 62, 51)";
        if (this.food != null)
          ctx.fillTile(...this.food);
      },
      tick() {
        this.stopTicking();

        if (this.game.snakeSegments.length > 0) {
          let segments = this.game.snakeSegments;
          let firstSegment = segments[0];

          // Moving
          let newSegment = [];
          newSegment[0] = firstSegment[0] + this.game.nextStepVec[0];
          newSegment[1] = firstSegment[1] + this.game.nextStepVec[1];

          // Processing borders loop
          let loop = (val, min, max) => val < min ? max : val > max ? min : val;
          newSegment[0] = loop(newSegment[0], 0, this.game.width - 1);
          newSegment[1] = loop(newSegment[1], 0, this.game.height - 1);

          if (this.food != null) {
            if (newSegment[0] === this.food[0] && newSegment[1] === this.food[1]) {
              this.food = null;
              this.game.ticksPerSec++;
            } else
              segments.splice(segments.length - 1, 1);
          }

          if (this.isSnakeSegment(newSegment)) {
            this.state = 'before_start';
            this.game.ticksPerSec = 3;
            this.game.nextStepVec = [0, -1];
            this.game.prevStepVec = [0, -1];
            this.game.failed = true;
            this.stopTicking();
            return;
          }

          segments.unshift(newSegment);

          if (this.food == null)
            this.food = [
              Math.floor(Math.random()*this.game.width),
              Math.floor(Math.random()*this.game.height)
            ];

          this.game.prevStepVec = this.game.nextStepVec;
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
      cheatCode.setCheatListener('DONTEATYOURSELF', this.activate);
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

  canvas {
    max-width: 100%;
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