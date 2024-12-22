### 1) Traffic Light Controller

This project implements a traffic light controller for a four-way intersection using a finite state machine (FSM) model. The controller operates in a simulated environment, where the traffic lights switch states based on a timer, ensuring smooth and safe traffic flow.

#### Features
- Simulates a standard traffic light system with North-South and East-West directions.
- Time-based transitions for Green, Yellow, and Red lights.
- Includes an all-red state for safety between transitions.

#### Traffic Light States
The system operates in the following sequence of states:
1. **NS_GREEN**: North-South direction has green light; East-West direction has red light.
2. **NS_YELLOW**: North-South direction has yellow light; East-West direction has red light.
3. **ALL_RED**: All directions have red lights for a brief period.
4. **EW_GREEN**: East-West direction has green light; North-South direction has red light.
5. **EW_YELLOW**: East-West direction has yellow light; North-South direction has red light.

#### Timing
- `GREEN_TIME`: 10 clock cycles.
- `YELLOW_TIME`: 5 clock cycles.
- `RED_TIME`: 3 clock cycles.

The state transitions are governed by these timers, ensuring each state persists for a defined period before transitioning to the next.

#### Applications
- Simulation of traffic light systems for educational or demonstration purposes.
- Can be extended with sensor inputs for real-world implementation.

 #### How to Run
1. Clone the repository.
2. Use any Verilog simulator (e.g., ModelSim, Vivado, or iverilog).
3. Observe the state transitions and output signals in the waveform or console output.

## 2) Washing Machine Simulation in Verilog

### Overview
This project simulates the operation of a washing machine using Verilog. The washing machine transitions through various stages—Idle, Fill, Wash, Rinse, Spin, and Done—based on a clock-driven state machine. The design is robust, handling scenarios like supply interruptions and ensuring proper resumption of operation after the supply is restored.

#### The simulation demonstrates the following:

- **State Machine Logic**: Transitioning between washing machine stages based on timers and conditions.
- **Timer-Based Control**: Ensures that each stage runs for a specific time duration.
- **Supply Interruption Handling**: Retains the current state and timer values when the power supply is turned off.
- **Reset Mechanism**: Ensures the washing machine resets to an idle state as needed.

### Features

#### Finite State Machine (FSM):
The washing machine is modeled as an FSM with six states:

1. **IDLE**: Initial state before the washing process starts.
2. **FILL**: Water filling stage.
3. **WASH**: Washing stage.
4. **RINSE**: Rinsing stage.
5. **SPIN**: Spinning stage.
6. **DONE**: Completion stage, returning to IDLE.

#### Parameter-Driven Timing:
Each stage has a predefined duration (configurable via parameters):

- **Fill**: 3 cycles.
- **Wash**: 4 cycles.
- **Rinse**: 4 cycles.
- **Spin**: 4 cycles.

#### Supply Handling:
- If the power supply is interrupted (supply=0), the machine retains its current state and resumes correctly once power is restored.

### Design Details

#### Verilog Module:
The module `washing_machine` includes the following:

##### Inputs:
- **clk**: Clock signal.
- **rst**: Reset signal.
- **cycle**: Start cycle signal.
- **supply**: Power supply signal.

##### Output:
- **stage**: Current stage of the washing process, represented as a 3-bit binary code.

##### Parameters:
- Configurable timing for each stage.

#### State Transitions:
- The washing machine starts in the **IDLE** state.
- On receiving the **cycle** signal, it transitions to **FILL**, then sequentially through **WASH**, **RINSE**, **SPIN**, and finally **DONE**.
- Each stage runs for a fixed number of cycles before transitioning.

### Simulation

#### The testbench (`washing_machine_tb.v`) verifies the following scenarios:

- **Normal Operation**: The machine transitions through all stages without interruptions.
- **Supply Interruption**: Tests the machine's ability to retain state and timer values during a power outage and resume properly when the supply is restored.
- **Reset Handling**: Ensures the machine resets to **IDLE** when the `rst` signal is asserted.

## 3)UART Transmitter Design in Verilog

This repository contains a Verilog implementation of a Universal Asynchronous Receiver-Transmitter (UART) Transmitter module, along with its corresponding testbench. The UART Transmitter module sends data byte-by-byte over a serial connection. The module supports the following features:

- **Idle state** when no transmission is occurring.
- **Start bit** signaling to begin transmission.
- **Data bit transmission** in sequence (LSB first).
- **Stop bit** signaling to mark the end of the transmission.
- **Transmission done** signaling once the data is fully transmitted.

## Features

- Configurable clock period for controlling baud rate via `CLOCKS_PER_BIT` parameter.
- Supports an 8-bit data transmission protocol.
- Includes a testbench (`UART_TB`) for simulation and verification.
- Data transmission format: **Start bit, 8 data bits, Stop bit**.

## Modules

### UART_TX
The main UART transmitter module with the following ports:

#### Inputs:
- **`reset`**: Active-low reset signal to initialize the transmitter.
- **`clock`**: Clock signal.
- **`data_valid`**: Indicates when valid data is available for transmission.
- **`data_in`**: 8-bit data to be transmitted.

#### Outputs:
- **`transmitting`**: High when the transmitter is active.
- **`serial_out`**: The serial output, which carries the data being transmitted.
- **`transmission_done`**: High once the transmission is complete.

### UART_TB
Testbench for the `UART_TX` module to simulate and verify its behavior.

#### Testbench Operation:
1. Initializes the system by applying the reset signal.
2. Sets `data_valid` to 1 and provides a sample byte (`8'h3F`) for transmission after reset is deasserted.
3. Waits for the transmission to complete and checks if the `transmission_done` signal is asserted, indicating a successful transmission.

## Simulation

### Running the Testbench
1. Compile the Verilog files and the testbench using a simulator (e.g., **ModelSim**).
2. Run the simulation to observe the UART transmitter's behavior.
3. Verify the output in the waveform viewer or console.

#### Expected Console Output:
- **Successful transmission**:Test Passed - Byte 0x3F Transmitted Successfully


#### How to Run
1. Clone the repository.
2. Use any Verilog simulator (e.g., ModelSim, Vivado, or iverilog).
3. Observe the state transitions and output signals in the waveform or console output.



