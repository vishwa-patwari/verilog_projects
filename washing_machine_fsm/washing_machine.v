module washing_machine(
  input clk, rst, cycle, supply,
  output reg [2:0] stage
);
  parameter IDEL = 3'b000, FILL = 3'b001, WASH = 3'b010, RINSE = 3'b011, SPIN = 3'b100, DONE = 3'b101;
  parameter FILL_TIME = 3, WASH_TIME = 4, RINSE_TIME = 4, SPIN_TIME = 4;

  reg [15:0] timer;
  reg [2:0] state, next_state;

  
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      state <= IDEL;
      timer <= 0;
    end else if (!supply) begin
      state <= state; 
      timer <= timer; 
    end else begin
      state <= next_state;
      if (state == next_state) begin
        timer <= timer + 1;
      end else begin
        timer <= 0; 
      end
    end
  end

  always @(*) begin
    next_state = state;
    if (supply) begin
      case (state)
        IDEL: if (cycle) next_state = FILL;
        FILL: if (timer == FILL_TIME - 1) next_state = WASH; 
        WASH: if (timer == WASH_TIME - 1) next_state = RINSE;
        RINSE: if (timer == RINSE_TIME - 1) next_state = SPIN;
        SPIN: if (timer == SPIN_TIME - 1) next_state = DONE;
        DONE: next_state = IDEL;
      endcase
    end
  end

  always @(*) begin
    case (state)
      IDEL: stage = 3'b000;
      FILL: stage = 3'b001;
      WASH: stage = 3'b010;
      RINSE: stage = 3'b011;
      SPIN: stage = 3'b100;
      DONE: stage = 3'b101;
      default: stage = 3'b000;
    endcase
  end
endmodule
