.PHONY: docker west update left right both output

docker:
	docker run --rm -it -v ${PWD}:/workspace zmkfirmware/zmk-build-arm:stable

west:
	west init -l config
	west update
	west zephyr-export

update:
	west update

output:
	mkdir -p output

left: output
	west build -p -d build/left -s zmk/app -b nice_nano -- -DSHIELD="corne_left nice_view_adapter nice_view" -DZMK_CONFIG="/workspace/config"
	cp build/left/zephyr/zmk.uf2 output/left_zmk.uf2

right: output
	west build -p -d build/right -s zmk/app -b nice_nano -- -DSHIELD="corne_right nice_view_adapter nice_view" -DZMK_CONFIG="/workspace/config"
	cp build/right/zephyr/zmk.uf2 output/right_zmk.uf2

both: left right
