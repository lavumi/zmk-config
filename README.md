Docker 이미지 가져오기:
``` bash
docker pull zmkfirmware/zmk-build-arm:stable
```

작업 디렉토리 준비:

``` bash
cd {your-zmk-config-directory}
```

Docker 실행:

``` bash
docker run --rm -it -v ${PWD}:/workspace zmkfirmware/zmk-build-arm:stable
```

워크스페이스 초기화 (컨테이너 내부):

``` bash
cd /workspace
west init -l config
west update
west zephyr-export
```

``` bash
west build -p -d build/left -s zmk/app -b nice_nano_v2 -- -DSHIELD="corne_left nice_view_adapter nice_view"
```

``` bash
west build -p -d build/right -s zmk/app -b nice_nano_v2 -- -DSHIELD="corne_right nice_view_adapter nice_view_custom"
```
