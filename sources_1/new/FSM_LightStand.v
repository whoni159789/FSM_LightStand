`timescale 1ns / 1ps

module FSM_LightStand(
    input i_clk,
    input i_reset,
    input [2:0] i_button,
    output o_pwm_light
    );

    wire w_clk;
    ClockDivider clkdiv(
        .i_clk(i_clk),
        .i_reset(i_reset),
        .o_clk(w_clk)
    );

    wire [9:0] w_counter;
    Counter count(
        .i_clk(w_clk),
        .i_reset(i_reset),
        .o_counter(w_counter)
    );

    wire [4:0] w_light;
    Comparator comp(
        .i_counter(w_counter),
        .o_light_0(w_light[0]),
        .o_light_1(w_light[1]), 
        .o_light_2(w_light[2]), 
        .o_light_3(w_light[3]), 
        .o_light_4(w_light[4])
    );

    wire [2:0] w_button;
    ButtonController UpBTN(
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_button(i_button[0]),
        .o_button(w_button[0])
    );

    ButtonController DownBTN(
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_button(i_button[1]),
        .o_button(w_button[1])
    );

    ButtonController OffBTN(
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_button(i_button[2]),
        .o_button(w_button[2])
    );

    wire [2:0] w_lightState;
    FSM_Light fsm_led(
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_button(w_button),
        .o_lightState(w_lightState)
    );

    MUX pwmsel(
        .i_x(w_light),
        .sel(w_lightState),
        .o_y(o_pwm_light)
    );

endmodule
