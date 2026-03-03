module crc_calculator #(
    parameter  N = 8,
    parameter POLY = 8'h07,
    parameter INIT = 8'h00
)(
    input        clk,
    input        rst,
    input        valid,
    input  [N-1:0] data_in,
    output [N-1:0] crc_out,
    output       done
);

reg [N-1:0] crc_reg;
reg [N-1:0] data_reg;
reg [$clog2(N)-1:0] bit_cnt;
reg       busy;



wire feedback;

localparam [$clog2(N)-1:0] CNT_MAX = 3'd7;

assign feedback = data_reg[N-1] ^ crc_reg[N-1];
assign crc_out  = crc_reg;
reg done_reg;
assign done = done_reg;
reg busy_d;

always @(posedge clk) begin
    if (rst)
        done_reg <= 0;
    else if (busy && bit_cnt == CNT_MAX)
        done_reg <= 1;
    else
        done_reg <= 0;
end

always @(posedge clk) begin
    if (rst) begin
        crc_reg  <= INIT;
        data_reg <= 8'd0;
        bit_cnt  <= 3'd0;
        busy     <= 1'b0;
    end
    else begin
     
        
            if (valid && !busy_d)begin
            data_reg <= data_in;
            bit_cnt  <= 3'd0;
            busy     <= 1'b1;
            crc_reg  <= INIT;
       end
        else if (busy) begin

            data_reg <= {data_reg[N-2:0], 1'b0};

            if (feedback)
                crc_reg <= {crc_reg[N-2:0], 1'b0} ^ POLY;
            else
                crc_reg <= {crc_reg[N-2:0], 1'b0};

            bit_cnt <= bit_cnt + 1'b1;

            if (bit_cnt == CNT_MAX) 
                busy <= 1'b0;
                
        end
    end
end

always @(posedge clk) busy_d <= busy;

endmodule
