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

Here is a clean and professional **README.md** content you can directly use for your GitHub project.

---

# 4) CRC Calculator (Parameterized Verilog)

## 📌 Overview

This project implements a **parameterized CRC (Cyclic Redundancy Check) calculator** in Verilog.

The design computes the CRC value for an `N-bit` input data word using a configurable polynomial.

The module processes **1 bit per clock cycle** and asserts a `done` signal once CRC calculation is complete.

---

## ✨ Features

* Parameterized data width (`N`)
* Configurable CRC polynomial (`POLY`)
* Configurable initial value (`INIT`)
* Serial bit-by-bit CRC computation
* One-cycle `done` pulse when calculation completes
* Edge detection on `valid` input
* Fully synthesizable RTL

---

## 📂 Module Parameters

| Parameter | Description       | Default |
| --------- | ----------------- | ------- |
| `N`       | Data width        | 8       |
| `POLY`    | CRC polynomial    | 8'h07   |
| `INIT`    | Initial CRC value | 8'h00   |

---

## 🔌 Port Description

| Port             | Direction | Description                                |
| ---------------- | --------- | ------------------------------------------ |
| `clk`            | Input     | System clock                               |
| `rst`            | Input     | Synchronous reset (active high)            |
| `valid`          | Input     | Starts CRC computation                     |
| `data_in[N-1:0]` | Input     | Input data word                            |
| `crc_out[N-1:0]` | Output    | Final CRC result                           |
| `done`           | Output    | High for one clock cycle when CRC is ready |

---

## ⚙️ Working Principle

1. When `valid` is asserted (and module is not busy):

   * Input data is loaded into `data_reg`
   * CRC register is initialized to `INIT`
   * Bit counter is reset
   * `busy` signal is asserted

2. For every clock cycle while `busy`:

   * MSB of `data_reg` is XORed with MSB of `crc_reg`
   * CRC is updated based on polynomial
   * Data shifts left
   * Bit counter increments

3. When all bits are processed:

   * `busy` deasserts
   * `done` is asserted for one clock cycle
   * `crc_out` holds final CRC value

---

## 🧠 Internal Signals

* `crc_reg` – CRC shift register
* `data_reg` – Shifted input data
* `bit_cnt` – Tracks processed bits
* `busy` – Indicates CRC calculation in progress
* `busy_d` – Delayed version of busy (used for edge detection)
* `feedback` – XOR of MSBs of data and CRC

---

## 🕒 Timing Behavior

* CRC calculation takes **N clock cycles**
* `done` is asserted for **1 clock cycle**
* New computation can start after `busy` becomes 0

---

## 🚀 Example Configuration (CRC-8)

```verilog
parameter N     = 8;
parameter POLY  = 8'h07;
parameter INIT  = 8'h00;
```

This corresponds to a common CRC-8 polynomial.

---

## 📊 Design Notes

* Uses serial architecture (area efficient)
* Suitable for low-area ASIC/FPGA designs
* Can be extended for CRC-16, CRC-32 by changing parameters
* Uses synchronous reset
* Fully synthesizable

---

## 🛠 How to Simulate

Example using Verilator:

```bash
verilator --trace --binary crc_calculator_tb.v crc_calculator.v --top crc_calculator_tb
./obj_dir/Vcrc_calculator_tb
```

---

## 📚 Future Improvements

* Add parallel CRC version (faster)
* Add streaming input support
* Add configurable bit order (MSB/LSB first)
* Add testbench with random stimulus
* Add CRC remainder post-processing

---

# 5) Asynchronous FIFO (Verilog RTL)

## 📌 Overview

This project implements a **parameterized Asynchronous FIFO (First-In First-Out)** in Verilog.

The FIFO safely transfers data between two different clock domains:

* `wr_clk` → Write domain
* `rd_clk` → Read domain

It uses:

* Binary write/read pointers
* Gray code conversion
* Two-stage synchronizers
* Proper full and empty detection

This is a classic CDC (Clock Domain Crossing) safe FIFO architecture used in ASIC and FPGA designs.

---

## ✨ Features

* Parameterized data width (`WIDTH`)
* Parameterized depth (`DEPTH`)
* Separate write and read clocks
* Gray code pointer synchronization
* Double-flop synchronizers for CDC safety
* Full and empty flag generation
* Active-low asynchronous reset (`rst_n`)
* Fully synthesizable

---

## 📂 Parameters

| Parameter | Description   | Default |
| --------- | ------------- | ------- |
| `WIDTH`   | Data width    | 32      |
| `DEPTH`   | FIFO depth    | 8       |
| `ADDR`    | Pointer width | 4       |

> Note: `ADDR` should be `clog2(DEPTH) + 1` for correct full detection.

---

## 🔌 Port Description

| Port              | Direction | Description      |
| ----------------- | --------- | ---------------- |
| `wr_clk`          | Input     | Write clock      |
| `rd_clk`          | Input     | Read clock       |
| `rst_n`           | Input     | Active-low reset |
| `wr`              | Input     | Write enable     |
| `rd`              | Input     | Read enable      |
| `din[WIDTH-1:0]`  | Input     | Data input       |
| `dout[WIDTH-1:0]` | Output    | Data output      |
| `full`            | Output    | FIFO full flag   |
| `empty`           | Output    | FIFO empty flag  |

---

## 🧠 Architecture Explanation

### 1️⃣ Write Logic (Write Clock Domain)

* Writes data into memory when:

  ```
  wr && !full
  ```
* Increments binary write pointer (`wr_ptr_b`)
* Converts binary pointer to Gray code (`wr_ptr_g`)

---

### 2️⃣ Read Logic (Read Clock Domain)

* Reads data when:

  ```
  rd && !empty
  ```
* Increments binary read pointer (`rd_ptr_b`)
* Converts binary pointer to Gray code (`rd_ptr_g`)

---

### 3️⃣ Gray Code Conversion

Binary to Gray conversion:

```verilog
gray = binary ^ (binary >> 1);
```

Gray code ensures **only one bit changes at a time**, which reduces metastability risk during clock domain crossing.

---

### 4️⃣ Pointer Synchronization

Each Gray pointer is passed through **two flip-flops** before being used in the opposite clock domain:

* `wr_ptr_g` → synchronized into read domain
* `rd_ptr_g` → synchronized into write domain

This prevents metastability from affecting FIFO control logic.

---

## 🔍 Empty Condition

FIFO is empty when:

```verilog
empty = (wr_ptr_g_s2 == rd_ptr_g);
```

Meaning:

* Both pointers are equal
* No unread data present

---

## 🔍 Full Condition

FIFO is full when:

```verilog
full = (wr_ptr_g == {~rd_ptr_g_s2[ADDR-1:ADDR-2], rd_ptr_g_s2[ADDR-3:0]});
```

Meaning:

* Write pointer catches up to read pointer
* MSBs inverted to detect wrap-around condition

This method distinguishes between:

* Full state
* Empty state

Even though lower bits are equal.

---

## 🗂 Memory Structure

```verilog
reg [WIDTH-1:0] mem [DEPTH-1:0];
```

Data is stored using:

```verilog
mem[wr_ptr_b[2:0]] <= din;
```

Indexing uses lower bits of pointer.

---

## ⚠️ Important Design Notes

* FIFO depth should be power of 2
* `ADDR` must be correctly chosen
* Double synchronizers are mandatory for CDC safety
* Gray code ensures safe multi-bit crossing
* Reset must initialize both domains correctly

---

## 🚀 Example Configuration

```verilog
parameter WIDTH = 32;
parameter DEPTH = 8;
parameter ADDR  = 4;
```

## 🔮 Future Improvements

* Add almost_full flag
* Add almost_empty flag
* Add parameterized synchronizer depth
* Add formal verification
* Add assertion-based verification
* Add testbench with different clock frequencies

---

## 👨‍💻 Author

Vishwa Patwari
RTL Design & ASIC Frontend Enthusiast

---






