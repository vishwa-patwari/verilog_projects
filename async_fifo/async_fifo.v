module async_fifo #( parameter WIDTH =32 , DEPTH = 8 , ADDR =4) (
input wr_clk ,
input rst_n ,
input rd_clk ,
input wr ,
input rd ,
input [WIDTH-1:0] din ,
output reg [WIDTH-1:0] dout ,
output empty ,
output full );

reg [ADDR-1:0]wr_ptr_b,rd_ptr_b,wr_ptr_g_s1,wr_ptr_g_s2,rd_ptr_g_s1,rd_ptr_g_s2;

wire  [ADDR-1:0]wr_ptr_g,rd_ptr_g;

reg [WIDTH-1:0] mem [DEPTH-1:0];


// write 
always@(posedge wr_clk or negedge rst_n)begin 
if(!rst_n) begin wr_ptr_b <= 0; end
else begin
  if(wr && !full)begin 
  mem[wr_ptr_b[2:0]] <= din;
  wr_ptr_b <= wr_ptr_b + 1;
  end
end
end

// read 
always@(posedge rd_clk or negedge rst_n)begin 
if(!rst_n) begin rd_ptr_b <= 0; dout <= 0; end
else begin
  if(rd && !empty)begin 
  dout <= mem[rd_ptr_b[2:0]]; 
  rd_ptr_b <= rd_ptr_b + 1;
  end
end
end

//binary to gray 
assign wr_ptr_g = wr_ptr_b ^ (wr_ptr_b >>1);

assign rd_ptr_g = rd_ptr_b ^ (rd_ptr_b >>1);

//sync for rd side 
always@(posedge rd_clk or negedge rst_n)begin
if(!rst_n) begin wr_ptr_g_s1 <= 0;  wr_ptr_g_s2 <= 0;end
else begin 
wr_ptr_g_s1 <= wr_ptr_g;
wr_ptr_g_s2 <= wr_ptr_g_s1;
end
end

//sync for wr side
always@(posedge wr_clk or negedge rst_n)begin
if(!rst_n) begin rd_ptr_g_s1 <= 0;  rd_ptr_g_s2 <= 0;end
else begin 
rd_ptr_g_s1 <= rd_ptr_g;
rd_ptr_g_s2 <= rd_ptr_g_s1;
end
end


// full and empty
assign empty = (wr_ptr_g_s2 == rd_ptr_g);

assign full = (wr_ptr_g == { ~rd_ptr_g_s2 [ADDR-1:ADDR-2] , rd_ptr_g_s2 [ADDR-3:0]});

endmodule










