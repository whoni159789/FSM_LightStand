`timescale 1ns / 1ps

module MUX(
    input [4:0] i_x,
    input [2:0] sel,
    output o_y
    );

    reg r_y;
    assign o_y = r_y;

    always @(*) begin
        r_y = 1'b0;
        case (sel)
            3'd0 : r_y = i_x[0];
            3'd1 : r_y = i_x[1];
            3'd2 : r_y = i_x[2];
            3'd3 : r_y = i_x[3];
            3'd4 : r_y = i_x[4];
        endcase
    end
endmodule
