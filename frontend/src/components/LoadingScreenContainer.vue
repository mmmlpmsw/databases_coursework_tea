<template>
  <div class="loading_screen_wrapper" :class="{loading}">
    <div class="loading_screen_container">
      <slot/>
    </div>
  </div>
</template>

<script>
  export default {
    props: {
      loading: Boolean
    }
  }
</script>

<style lang="scss" scoped>
  .loading_screen_wrapper.loading {
    .loading_screen_container {
      opacity: .5;
      pointer-events: none;
    }

    &:after {
      display: block;
      content: '';
      width: 100%;
      height: 100%;
      position: absolute;
      left: 0;
      top: 0;
      background-image: url("data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9Im5vIj8+CjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB3aWR0aD0iNjRweCIKICAgICBoZWlnaHQ9IjY0cHgiIHZpZXdCb3g9IjAgMCAxMjggMTI4IiB4bWw6c3BhY2U9InByZXNlcnZlIj48Zz48cGF0aCBkPSJNNjQgMEw0MC4wOCAyMS45YTEwLjk4IDEwLjk4IDAgMCAwLTUuMDUgOC43NUMzNC4zNyA0NC44NSA2NCA2MC42MyA2NCA2MC42M1YweiIgZmlsbD0iI2ZmYjExOCIvPjxwYXRoIGQ9Ik0xMjggNjRsLTIxLjg4LTIzLjlhMTAuOTcgMTAuOTcgMCAwIDAtOC43NS01LjA1QzgzLjE3IDM0LjQgNjcuNCA2NCA2Ny40IDY0SDEyOHoiIGZpbGw9IiM4MGMxNDEiLz48cGF0aCBkPSJNNjMuNyA2OS43M2ExMTAuOTcgMTEwLjk3IDAgMCAxLTUuMDQtMjAuNTRjLTEuMTYtOC43LjY4LTE0LjE3LjY4LTE0LjE3aDM4LjAzcy00LjMtLjg2LTE0LjQ3IDEwLjFjLTMuMDYgMy4zLTE5LjIgMjQuNTgtMTkuMiAyNC41OHoiIGZpbGw9IiNjYWRjMjgiLz48cGF0aCBkPSJNNjQgMTI4bDIzLjktMjEuODhhMTAuOTcgMTAuOTcgMCAwIDAgNS4wNS04Ljc1QzkzLjYgODMuMTcgNjQgNjcuNCA2NCA2Ny40VjEyOHoiIGZpbGw9IiNjZjE3MWYiLz48cGF0aCBkPSJNNTguMjcgNjMuN2ExMTAuOTcgMTEwLjk3IDAgMCAxIDIwLjU0LTUuMDRjOC43LTEuMTYgMTQuMTcuNjggMTQuMTcuNjh2MzguMDNzLjg2LTQuMy0xMC4xLTE0LjQ3Yy0zLjMtMy4wNi0yNC41OC0xOS4yLTI0LjU4LTE5LjJ6IiBmaWxsPSIjZWMxYjIxIi8+PHBhdGggZD0iTTAgNjRsMjEuODggMjMuOWExMC45NyAxMC45NyAwIDAgMCA4Ljc1IDUuMDVDNDQuODMgOTMuNiA2MC42IDY0IDYwLjYgNjRIMHoiIGZpbGw9IiMwMThlZDUiLz48cGF0aCBkPSJNNjQuMyA1OC4yN2ExMTAuOTcgMTEwLjk3IDAgMCAxIDUuMDQgMjAuNTRjMS4xNiA4LjctLjY4IDE0LjE3LS42OCAxNC4xN0gzMC42M3M0LjMuODYgMTQuNDctMTAuMWMzLjA2LTMuMyAxOS4yLTI0LjU4IDE5LjItMjQuNTh6IiBmaWxsPSIjMDBiYmYyIi8+PHBhdGggZD0iTTY5LjczIDY0LjM0YTExMS4wMiAxMTEuMDIgMCAwIDEtMjAuNTUgNS4wNWMtOC43IDEuMTQtMTQuMTUtLjctMTQuMTUtLjdWMzAuNjVzLS44NiA0LjMgMTAuMSAxNC41YzMuMyAzLjA1IDI0LjYgMTkuMiAyNC42IDE5LjJ6IiBmaWxsPSIjZjhmNDAwIi8+PGNpcmNsZSBjeD0iNjQiIGN5PSI2NCIgcj0iMi4wMyIvPjxhbmltYXRlVHJhbnNmb3JtIGF0dHJpYnV0ZU5hbWU9InRyYW5zZm9ybSIgdHlwZT0icm90YXRlIiBmcm9tPSIwIDY0IDY0IiB0bz0iLTM2MCA2NCA2NCIgZHVyPSIxNTAwbXMiIHJlcGVhdENvdW50PSJpbmRlZmluaXRlIj48L2FuaW1hdGVUcmFuc2Zvcm0+PC9nPjwvc3ZnPg==");
      background-position: center;
      background-repeat: no-repeat;
    }
  }
</style>