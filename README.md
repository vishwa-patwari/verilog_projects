### Traffic Light Controller

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
2. Use any Verilog simulator (e.g., ModelSim, Vivado, or iverilog) to run the `traffic_light_tb.v` testbench.
3. Observe the state transitions and output signals in the waveform or console output.



