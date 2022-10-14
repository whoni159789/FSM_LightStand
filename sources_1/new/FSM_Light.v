`timescale 1ns / 1ps

module FSM_Light(
    input i_clk,
    input i_reset,
    input [2:0] i_button,
    output [2:0] o_lightState
    );

    parameter   LIGHT_0 = 3'd0,
                LIGHT_1 = 3'd1,
                LIGHT_2 = 3'd2,
                LIGHT_3 = 3'd3,
                LIGHT_4 = 3'd4;

    reg [2:0] r_curState = LIGHT_0, r_nextState;
    reg [2:0] r_lightState;
    assign o_lightState = r_lightState;

    /* 상태 변경 */
    always @(posedge i_clk or posedge i_reset) begin
        if (i_reset)    r_curState <= LIGHT_0;
        else            r_curState <= r_nextState;
    end

    /* 이벤트 처리 */
    always @(r_curState, i_button) begin
        r_nextState <= LIGHT_0;
        case (r_curState)
            LIGHT_0 : begin
                if(i_button[0])         r_nextState <= LIGHT_1;
                else                    r_nextState <= LIGHT_0;
            end
            LIGHT_1 : begin
                if(i_button[0])         r_nextState <= LIGHT_2;
                else if(i_button[1])    r_nextState <= LIGHT_0;
                else if(i_button[2])    r_nextState <= LIGHT_0;
                else                    r_nextState <= LIGHT_1;
            end
            LIGHT_2 : begin
                if(i_button[0])         r_nextState <= LIGHT_3;
                else if(i_button[1])    r_nextState <= LIGHT_1;
                else if(i_button[2])    r_nextState <= LIGHT_0;
                else                    r_nextState <= LIGHT_2;
            end
            LIGHT_3 : begin
                if(i_button[0])         r_nextState <= LIGHT_4;
                else if(i_button[1])    r_nextState <= LIGHT_2;
                else if(i_button[2])    r_nextState <= LIGHT_0;
                else                    r_nextState <= LIGHT_3;
            end
            LIGHT_4 : begin
                if(i_button[1])         r_nextState <= LIGHT_3;
                else if(i_button[2])    r_nextState <= LIGHT_0;
                else                    r_nextState <= LIGHT_4;
            end
        endcase
    end

    /* 상태에 따른 동작 */
    always @(r_curState) begin
        r_lightState <= 3'b000;
        case(r_curState)
            LIGHT_0 : r_lightState <= 3'd0;
            LIGHT_1 : r_lightState <= 3'd1;
            LIGHT_2 : r_lightState <= 3'd2;
            LIGHT_3 : r_lightState <= 3'd3;
            LIGHT_4 : r_lightState <= 3'd4;
        endcase
    end

endmodule
