build:
	iverilog -o test test.v I2C-bridge.v
	./test
