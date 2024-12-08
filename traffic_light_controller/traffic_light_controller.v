
module traffic_light_controller (
    input clk,
    input reset,
    output reg [2:0] ns_light,
    output reg [2:0] sn_light,
    output reg [2:0] ew_light,
    output reg [2:0] we_light
);
    parameter RED = 3'b100, YELLOW = 3'b010, GREEN = 3'b001;
    parameter NS_GREEN = 3'b000, NS_YELLOW = 3'b001, ALL_RED = 3'b010, EW_GREEN = 3'b011, EW_YELLOW = 3'b100;
    reg [2:0] state;
    reg [4:0] timer;
    parameter GREEN_TIME = 10, YELLOW_TIME = 5, RED_TIME = 3;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= NS_GREEN;
            timer <= GREEN_TIME;
        end else begin
            if (timer == 0) begin
                case (state)
                    NS_GREEN: begin
                        state <= NS_YELLOW;
                        timer <= YELLOW_TIME;
                    end
                    NS_YELLOW: begin
                        state <= ALL_RED;
                        timer <= RED_TIME;
                    end
                    ALL_RED: begin
                        state <= EW_GREEN;
                        timer <= GREEN_TIME;
                    end
                    EW_GREEN: begin
                        state <= EW_YELLOW;
                        timer <= YELLOW_TIME;
                    end
                    EW_YELLOW: begin
                        state <= ALL_RED;
                        timer <= RED_TIME;
                    end
                endcase
            end else begin
                timer <= timer - 1;
            end
        end
    end

    always @(*) begin
        case (state)
            NS_GREEN: begin
                ns_light = GREEN;
                sn_light = GREEN;
                ew_light = RED;
                we_light = RED;
            end
            NS_YELLOW: begin
                ns_light = YELLOW;
                sn_light = YELLOW;
                ew_light = RED;
                we_light = RED;
            end
            ALL_RED: begin
                ns_light = RED;
                sn_light = RED;
                ew_light = RED;
                we_light = RED;
            end
            EW_GREEN: begin
                ns_light = RED;
                sn_light = RED;
                ew_light = GREEN;
                we_light = GREEN;
            end
            EW_YELLOW: begin
                ns_light = RED;
                sn_light = RED;
                ew_light = YELLOW;
                we_light = YELLOW;
            end
            default: begin
                ns_light = RED;
                sn_light = RED;
                ew_light = RED;
                we_light = RED;
            end
        endcase
    end
endmodule


