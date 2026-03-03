`timescale 1ns/1ps

module async_fifo_tb;

parameter WIDTH = 32;
parameter DEPTH = 8;
parameter ADDR  = 3;

reg wr_clk;
reg rd_clk;
reg rst_n;
reg wr;
reg rd;

reg  [WIDTH-1:0] din;
wire [WIDTH-1:0] dout;
wire empty;
wire full;

async_fifo #(
    .WIDTH(WIDTH),
    .DEPTH(DEPTH),
    .ADDR(ADDR)
) DUT (
    .wr_clk(wr_clk),
    .rd_clk(rd_clk),
    .rst_n(rst_n),
    .wr(wr),
    .rd(rd),
    .din(din),
    .dout(dout),
    .empty(empty),
    .full(full)
);

// ---------------- Clocks ----------------
always #5   wr_clk = ~wr_clk;   // 100 MHz
always #2.5 rd_clk = ~rd_clk;   // 200 MHz

// ---------------- Dump ----------------
initial begin
    $dumpfile("async_fifo.vcd");
    $dumpvars(0, async_fifo_tb);
end

// ---------------- Reset Task ----------------
task reset;
begin
    rst_n = 0;
    #20;
    rst_n = 1;
end
endtask

// ---------------- Write Task ----------------
task write(input [WIDTH-1:0] data);
begin
    @(posedge wr_clk);
    if (!full) begin
        din = data;
        wr  = 1;
    end
    @(posedge wr_clk);
    wr = 0;
end
endtask

// ---------------- Read Task ----------------
task read;
begin
    @(posedge rd_clk);
    if (!empty)
        rd = 1;
    @(posedge rd_clk);
    rd = 0;
end
endtask

// ---------------- Initial ----------------
integer i;

initial begin
    // init
    wr_clk = 0;
    rd_clk = 0;
    wr = 0;
    rd = 0;
    rst_n = 1;

    // reset
    reset();

    // Write one value
    write(32'd55);

    // Read one value
    read();

    // -------- Fill FIFO to FULL --------
    for (i = 0; i < DEPTH; i = i + 1) begin
        write($random);
    end

    // -------- Empty FIFO --------
    for (i = 0; i < DEPTH; i = i + 1) begin
        read();
    end

    #200;
    $finish;
end

endmodule

