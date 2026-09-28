# EECS 3216 LED Aided Digital Balancer

An accelerometer-based level indicator built on an Intel DE10-Lite (MAX 10) FPGA
in SystemVerilog. The board reads a 3-axis accelerometer over SPI, converts the
raw sensor data to an angle, and lights a corresponding LED on an addressable
strip. The user can also set a target angle, turning the device into a digital
protractor.

Coursework: EECS 3216 — Advanced Digital Design, York University.
Solo project.

## How It Works

1. On startup, the driver programs the accelerometer's registers over SPI
   (output rate, thresholds, interrupt config, power mode).
2. In a loop, it reads the X and Z axes and converts them to a 0–90° angle.
3. The angle is displayed on two 7-segment displays and mapped to a position
   on the LED strip.
4. A switch lets the user enter a target angle; the top-level FSM switches
   between DISPLAY and SET modes.

## Modules

| File | Purpose |
|------|---------|
| `spi.sv` | SPI master. Clock divider, 4-state FSM (IDLE → TO_ACTIVE → ACTIVE → TO_IDLE), TX/RX shifting, chip-select sequencing, idle-time enforcement. |
| `gsensor.sv` | Accelerometer driver. Instruction sequencer with opcodes (READ, WRITE, WAIT_FOR_IDLE, WAIT_FOR_UPDATE, JUMP, NOTIFY) that programs registers on startup, then runs a read loop. |
| `Digital_Level_Project.sv` | Top level. Two-state FSM (DISPLAY / SET), switch input for target angle, 7-segment output logic. |
| `read_sensor.sv` | Wrapper around the sensor driver; handles sign conversion and digit extraction. |
| `AngleConverter.sv` | Maps raw accelerometer readings to a 0–90° angle. |
| `output_led_strip.sv` | LED strip driver. Maps current and target angles to LED indices. |
| `pulseGen.sv` | Bit-banged pulse generation for the addressable LEDs. |
| `ClockDivider.sv` | Clock division for the SPI clock. |
| `clockDiv.sv` | Clock division for the display refresh. |

## Tools
- Intel Quartus Prime 20.1 (synthesis, pin assignment, programming)
- Quartus simulation

## Hardware
- Terasic DE10-Lite (Intel MAX 10, `10M50DAF484C7G`)
- 3-axis accelerometer (SPI)
- WS2812 addressable LED strip
- 6x 7-segment displays (on-board)

## Notes and Known Issues

This code is kept as-written, not cleaned up. The debugging process was part
of the work, and documenting what went wrong is more useful than pretending
it didn't.

Known issues in the current source:

- `output_led_strip.sv` — signal name case mismatch (`slC` declared, `slc`
  used); port width mismatch on `curr` / `set` (declared 1-bit, driven with
  multi-bit values).
- `Digital_Level_Project.sv` — uses `negedge reset` as a clock; contains a
  self-assignment (`set_angle[14:0] = set_angle[14:0]`); `angle_reading_s`
  and `set_angle_s` are referenced but never declared.
- `clockDiv.sv` — blocking assignments inside an `always @(posedge clk)`
  block, where non-blocking would be correct for flip-flop inference.
- `read_sensor.sv` — `KEY0` port is left unconnected at the top level.

What I would do differently:

- Run a proper simulation testbench for the SPI master before wiring it to
  the accelerometer, rather than debugging on hardware.
- Register the module outputs at the boundaries instead of relying on
  combinational paths through multiple modules.
- Fix the reset scheme — asynchronous reset should not be used as a clock.

The parts I'm most confident in are `spi.sv` and `gsensor.sv`.
