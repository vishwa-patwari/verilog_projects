// Testbench for washing machine module
module washing_machine_tb();

  // Testbench signals
  reg clk;
  reg rst;
  reg cycle;
  reg supply;
  wire [2:0] stage;

  // Instantiate the washing machine module
  washing_machine uut (
    .clk(clk),
    .rst(rst),
    .cycle(cycle),
    .supply(supply),
    .stage(stage)
  );

  // Clock generation
  always #5 clk = ~clk; // 10-unit clock period

  initial begin
    // Initialize signals
    clk = 0;
    rst = 1; // Reset active
    cycle = 0;
    supply = 0; // Supply off initially

    // Release reset after some time
    #10 rst = 0;

    // Test scenario: Start the washing cycle with supply on
    #10 supply = 1;
    #10 cycle = 1; // Start cycle

    // Allow the machine to transition through some states
    #100;

    // Test scenario: Turn off supply mid-operation
    #20 supply = 0;

    // Wait for a while to observe state retention
    #50;

    // Turn supply back on and resume operation
    #10 supply = 1;

    // Allow the machine to continue
    #1000;

    // End simulation
    $finish;
  end

  // Monitor outputs
  initial begin
    $monitor($time, " | clk=%b | rst=%b | cycle=%b | supply=%b | stage=%b", clk, rst, cycle, supply, stage);
  end

endmodule