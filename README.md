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

### 2) Washing Machine Simulation in Verilog
Overview
This project simulates the operation of a washing machine using Verilog. The washing machine transitions through various stages—Idle, Fill, Wash, Rinse, Spin, and Done—based on a clock-driven state machine. The design is robust, handling scenarios like supply interruptions and ensuring proper resumption of operation after the supply is restored.

The simulation demonstrates the following:

State Machine Logic: Transitioning between washing machine stages based on timers and conditions.
Timer-Based Control: Ensures that each stage runs for a specific time duration.
Supply Interruption Handling: Retains the current state and timer values when the power supply is turned off.
Reset Mechanism: Ensures the washing machine resets to an idle state as needed.
Features
Finite State Machine (FSM):
The washing machine is modeled as an FSM with six states:

1.IDLE: Initial state before the washing process starts.
2.FILL: Water filling stage.
3.WASH: Washing stage.
4.RINSE: Rinsing stage.
5.SPIN: Spinning stage.
6.DONE: Completion stage, returning to IDLE.
Parameter-Driven Timing:
Each stage has a predefined duration (configurable via parameters):

1.Fill: 3 cycles.
2.Wash: 4 cycles.
3.Rinse: 4 cycles.
3.Spin: 4 cycles.
5.Supply Handling:
If the power supply is interrupted (supply=0), the machine retains its current state and resumes correctly once power is restored.

Design Details
Verilog Module:
The module washing_machine includes:

Inputs:

clk: Clock signal.
rst: Reset signal.
cycle: Start cycle signal.
supply: Power supply signal.
Output:

stage: Current stage of the washing process, represented as a 3-bit binary code.
Parameters:
Configurable timing for each stage.

State Transitions:
The washing machine starts in the IDLE state.
On receiving the cycle signal, it transitions to FILL, then sequentially through WASH, RINSE, SPIN, and finally DONE.
Each stage runs for a fixed number of cycles before transitioning.
Simulation
The testbench (washing_machine_tb.v) verifies the following scenarios:

Normal Operation:

The machine transitions through all stages without interruptions.
Supply Interruption:

Tests the machine's ability to retain state and timer values during a power outage and resume properly when the supply is restored.
Reset Handling:

Ensures the machine resets to IDLE when the rst signal is asserted.
Tools Used
Simulation Tools: ModelSim, Vivado, or any Verilog simulation environment.
Waveform Viewing: GTKWave for analyzing signal transitions.

#### How to Run
1. Clone the repository.
2. Use any Verilog simulator (e.g., ModelSim, Vivado, or iverilog).
3. Observe the state transitions and output signals in the waveform or console output.



