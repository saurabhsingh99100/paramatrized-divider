////////////////////////////////////////////////////////////
//  File: Div_tb.v
//  
//  Description :   Testbench for Binary divider using binary 
//                  restoing division algorithm
//  
//  Author : Saurabh Singh
//
//
/////////////////////////////////////////////////////////////

`timescale 1ns/10ps

`include "Div.v"


module Div_tb;
    parameter L = 16, l = 3;
    
    reg [L-1:0] Dividend;
    reg [l-1:0] Divisor;
    reg Clk, Rst;
    wire State;
    wire [L-1:0] Q;
    wire [L:0] A;

    Div d(
        Dividend,
        Divisor,
        Clk,
        Rst,
        State,
        Q,
        A
    );

    initial begin
        $monitor("A:%b (%d)\t\tQ:%b (%d)\t\n",A,A,Q,Q);
        $dumpfile("out.vcd");
        $dumpvars(0, Div_tb);

        // testcase 1
        Clk = 0;
        Dividend = 16'd36;
        Divisor = 3'd7;
        Rst = 1;
        #4;
        Rst = 0;
        #250;
        $display("(REMAINDER)\t\t\t\t(QUOTIENT)\n----------------------------------------------\n\n");

        // testcase 2
        Dividend = 16'd781;
        Divisor = 3'd6;
        Rst = 1;
        #4;
        Rst = 0;
        #250;
        $display("(REMAINDER)\t\t\t\t(QUOTIENT)\n----------------------------------------------\n\n");

        // testcase 3
        Dividend = 16'd463;
        Divisor = 3'd5;
        Rst = 1;
        #4;
        Rst = 0;
        #250;
        $display("(REMAINDER)\t\t\t\t(QUOTIENT)\n----------------------------------------------\n\n");





        $finish();
    end

    always begin
        #1;
        Clk <= ~Clk;
    end
endmodule