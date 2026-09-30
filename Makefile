.PHONY: docker west update corne_left corne_right corne totem_left totem_right totem totem_reset output

docker:
	docker run --rm -it -v ${PWD}:/workspace -w /workspace zmkfirmware/zmk-build-arm:stable \
		bash -c 'west zephyr-export >/dev/null 2>&1; exec bash'

init:
	west init -l config
	west update
	west zephyr-export

update:
	west update
	west zephyr-export

output:
	mkdir -p output

corne_left: output
	west build -p -d build/left -s zmk/app -b nice_nano_v2 -- -DSHIELD="corne_left nice_view_adapter nice_view_custom" -DZMK_CONFIG="/workspace/config"
	cp build/left/zephyr/zmk.uf2 output/left_zmk.uf2

corne_right: output
	west build -p -d build/right -s zmk/app -b nice_nano_v2 -- -DSHIELD="corne_right nice_view_adapter nice_view_custom" -DZMK_CONFIG="/workspace/config"
	cp build/right/zephyr/zmk.uf2 output/right_zmk.uf2

cotne: corne_left corne_right

totem_left: output
	west build -p -d build/totem_left -s zmk/app -b seeeduino_xiao_ble -- -DSHIELD="totem_left" -DZMK_CONFIG="/workspace/config"
	cp build/totem_left/zephyr/zmk.uf2 output/totem_left_zmk.uf2

totem_right: output
	west build -p -d build/totem_right -s zmk/app -b seeeduino_xiao_ble -- -DSHIELD="totem_right" -DZMK_CONFIG="/workspace/config"
	cp build/totem_right/zephyr/zmk.uf2 output/totem_right_zmk.uf2

totem: totem_left totem_right

totem_reset: output
	west build -p -d build/totem_reset -s zmk/app -b seeeduino_xiao_ble -- -DSHIELD="settings_reset"
	cp build/totem_reset/zephyr/zmk.uf2 output/totem_reset_zmk.uf2
