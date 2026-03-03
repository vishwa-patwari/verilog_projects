`timescale 1ns/1ps

module crc_calculator_tb;

    reg        clk;
    reg        rst;
    reg        valid;
    reg  [7:0] data_in;
    wire [7:0] crc_out;
    wire       done;

      
    crc_calculator #(
        .POLY(8'h07),
        .INIT(8'h00)
    ) dut (
        .clk(clk),
        .rst(rst),
        .valid(valid),
        .data_in(data_in),
        .crc_out(crc_out),
        .done(done)
    );

    
    // Clock generation
    
    always #5 clk = ~clk;

    
    initial begin
        $dumpfile("crc8.vcd");
        $dumpvars(0, crc_calculator_tb);
    end

   
    // Monitor internal signals
   
    initial begin
        $monitor("time=%0t | bit_cnt=%0d | crc=%b | done=%b",
                  $time, dut.bit_cnt, dut.crc_reg, done);
    end

    
    // Test sequence
    
    initial begin

        clk     = 0;
        rst     = 1;
        valid   = 0;
        data_in = 0;

        // Apply reset
        #20;
        rst = 0;

        // Send one byte
        
        @(posedge clk);
        
        valid   = 1;
        data_in = 8'b10110010;

        @(posedge clk);
        valid = 0;

      
        wait(done);
        @(posedge clk);

        if (crc_out == 8'h17)
            $display("TEST PASSED  | CRC = %h", crc_out);
        else
            $display("TEST FAILED  | CRC = %h | Expected = 17", crc_out);
            
        
         @(posedge clk);
        
        valid   = 1;
        data_in = 8'b10011010;

        @(posedge clk);
        valid = 0;

      
        wait(done);
        @(posedge clk);

        if (crc_out == 8'hcf)
            $display("TEST PASSED  | CRC = %h", crc_out);
        else
            $display("TEST FAILED  | CRC = %h | Expected = cf", crc_out);
        #20;
        $finish;
    end

endmodule
