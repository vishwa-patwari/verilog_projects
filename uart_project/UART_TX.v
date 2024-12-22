
module UART_TX
  #(parameter CLOCKS_PER_BIT = 217)
  (
   input       reset,
   input       clock,
   input       data_valid,
   input [7:0] data_in,
   output reg  transmitting,
   output reg  serial_out,
   output reg  transmission_done
   );

  localparam IDLE         = 2'b00;
  localparam START_BIT    = 2'b01;
  localparam DATA_BITS    = 2'b10;
  localparam STOP_BIT     = 2'b11;

  reg [1:0] state;
  reg [7:0] clock_counter;
  reg [2:0] bit_index;
  reg [7:0] data_to_send;

  always @(posedge clock or negedge reset)
  begin
    if (~reset)
    begin
      state <= IDLE;
      transmitting <= 0;
      serial_out <= 1;
      transmission_done <= 0;
    end
    else
    begin
      transmission_done <= 0;

      case (state)
      
      IDLE:
        begin
          serial_out <= 1;
          clock_counter <= 0;
          bit_index <= 0;
          
          if (data_valid)
          begin
            transmitting <= 1;
            data_to_send <= data_in;
            state <= START_BIT;
          end
        end

      START_BIT:
        begin
          serial_out <= 0;
          if (clock_counter < CLOCKS_PER_BIT - 1)
          begin
            clock_counter <= clock_counter + 1;
          end
          else
          begin
            clock_counter <= 0;
            state <= DATA_BITS;
          end
        end

      DATA_BITS:
        begin
          serial_out <= data_to_send[bit_index];
          if (clock_counter < CLOCKS_PER_BIT - 1)
          begin
            clock_counter <= clock_counter + 1;
          end
          else
          begin
            clock_counter <= 0;
            if (bit_index < 7)
            begin
              bit_index <= bit_index + 1; 
              state <= DATA_BITS;  
            end
            else  
            begin
              bit_index <= 0; 
              state <= STOP_BIT; 
            end
          end
        end

      STOP_BIT:  
        begin
          serial_out <= 1;  
          if (clock_counter < CLOCKS_PER_BIT - 1) 
          begin
            clock_counter <= clock_counter + 1; 
          end
          else
          begin
            transmission_done <= 1;  
            clock_counter <= 0; 
            state <= IDLE; 
            transmitting <= 0;  
          end
        end

      default:  
        state <= IDLE;  
      endcase
    end
  end

endmodule