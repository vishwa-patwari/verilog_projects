`timescale 1ns / 1ps

module tb_traffic_light_controller;
    reg clk;
    reg reset;
    wire [2:0] ns_light;
    wire [2:0] sn_light;
    wire [2:0] ew_light;
    wire [2:0] we_light;

    traffic_light_controller uut (
        .clk(clk),
        .reset(reset),
        .ns_light(ns_light),
        .sn_light(sn_light),
        .ew_light(ew_light),
        .we_light(we_light)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        reset = 1;
        #10 reset = 0;
        #200 $stop;
    end

    initial begin
        $monitor("Time: %0d | NS: %b | SN: %b | EW: %b | WE: %b", $time, ns_light, sn_light, ew_light, we_light);
    end
endmodule