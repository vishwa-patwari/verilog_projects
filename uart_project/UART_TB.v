module UART_TB();

  parameter c_CLOCK_PERIOD_NS = 40;
  parameter c_CLOCKS_PER_BIT = 217;
  
  reg r_Clock = 0;
  reg r_Reset = 0;
  reg r_TX_DV = 0;
  reg [7:0] r_TX_Byte = 8'h3F;
  wire w_TX_Active;
  wire w_TX_Serial;
  wire w_TX_Done;
  
  UART_TX #(.CLOCKS_PER_BIT(c_CLOCKS_PER_BIT)) UART_TX_Inst (
    .reset(r_Reset),
    .clock(r_Clock),
    .data_valid(r_TX_DV),
    .data_in(r_TX_Byte),
    .transmitting(w_TX_Active),
    .serial_out(w_TX_Serial),
    .transmission_done(w_TX_Done)
  );

  always
    #(c_CLOCK_PERIOD_NS/2) r_Clock = !r_Clock;

  initial begin
    r_Reset = 0;
    @(posedge r_Clock);
    r_Reset = 1;
    @(posedge r_Clock);

    r_TX_DV = 1'b1;
    r_TX_Byte = 8'h3F;
    @(posedge r_Clock);
    r_TX_DV = 1'b0;
    
    @(posedge w_TX_Done);

    if (w_TX_Done) begin
      $display("Test Passed - Byte 0x3F Transmitted Successfully");
    end else begin
      $display("Test Failed - Transmission Error");
    end

    $finish;
  end

  initial begin
    $monitor("Time: %0t | Reset: %b | Data Valid: %b | Data In: %h | Serial Out: %b | Transmitting: %b | TX Done: %b", 
             $time, r_Reset, r_TX_DV, r_TX_Byte, w_TX_Serial, w_TX_Active, w_TX_Done);
  end

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0);
  end

endmodule
