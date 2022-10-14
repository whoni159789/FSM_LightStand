`timescale 1ns / 1ps

module Comparator(
    input [9:0] i_counter,
    output o_light_0, o_light_1, o_light_2, o_light_3, o_light_4
    );

    /* 
       lignt_0 :  0%
       light_1 : 30%
       light_2 : 60%
       light_3 : 80%
       light_4 : 99% */

    assign o_light_0 = (i_counter < 0)   ? 1'b1 : 1'b0;
    assign o_light_1 = (i_counter < 100) ? 1'b1 : 1'b0;
    assign o_light_2 = (i_counter < 400) ? 1'b1 : 1'b0;
    assign o_light_3 = (i_counter < 700) ? 1'b1 : 1'b0;
    assign o_light_4 = (i_counter < 999) ? 1'b1 : 1'b0;

endmodule
