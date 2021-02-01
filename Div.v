////////////////////////////////////////////////////////////
//  File: Div.v
//  
//  Description :   Binary divider using binary restoing 
//                  division algorithm
//  
//  Author : Saurabh Singh
//
//
/////////////////////////////////////////////////////////////

/*
    =============== ALGORITHM ================

    CYCLE   |   TASK
    ------------------------------------------
    0       |   Shift left (A-Q << 1)
    ------------------------------------------
    1       |   A = A-M ; A_prev <= A;
    ------------------------------------------
    2       |   if (A[msb] == 1)
                { 
                    Q[0] = 1;
                }
                else
                {
                    Q[0] = 0
                    A <= A_prev
                }
                n <= n-1
    ------------------------------------------
    3       |   if (n==0)
                {
                    done    //  Remainder in A; Quotient in Q; 
                }
                else
                {
                    goto cycle 0;
                }
*/

module Div#(parameter L = 16, parameter l = 3)      // L = Dividend length;     l = Divisor length
    (
        input [L-1:0]   Dividend_i,
        input [l-1:0]   Divisor_i,
        input           Clk_i,
        input           Rst_i,

        output  reg     State,
        output  [L-1:0] Q_o,
        output  [L:0]   A_o
    );

    assign Q_o = Q;     // Quotient
    assign A_o = A;     // Remainder


    // Internal registers
    reg [L-1:0]         Q = 0;  // Quotient register
    reg [L:0]           A = 0;  // Accumulator
    reg [L:0]           M = 0;

    reg [$clog2(L):0]   n;      // no of bits in divisor

    reg [L:0]           A_prev = 0; // temporary register used in restore-A
    
    wire done = (n == 0);

    reg [3:0] cycle = 0;


    // cycle register
    always @(posedge Clk_i)begin
        if(Rst_i) begin
            A <= 0;
        end
        else if((cycle < 3) && (!done))begin        // cycle counting stops if done signal is high
            cycle <= cycle+1;
        end
        else begin 
            cycle<= 0;
        end
    end


    // n register
    always @(posedge Clk_i)begin
        if(Rst_i) begin
            n <= L;             // Initialization
        end
        if (cycle == 3)begin
            n <= n-1;
        end
    end


    // A register
    always @(posedge Clk_i)begin
        if(Rst_i) begin
            A <= 0;             // Initialization
        end
        if (cycle == 1)begin
            A <= {A[L-1:0],Q[L-1]};
        end
        if (cycle == 2)begin
            A <= A-M;
        end
        if ((cycle == 3) && (A[L] == 1))begin
            A <= A_prev;
        end
    end


    // M register
    always @(posedge Clk_i)begin
        if(Rst_i) begin
            M <= Divisor_i;     // Initialization
        end
    end


    // Q register
    always @(posedge Clk_i)begin
        if(Rst_i) begin
            Q <= Dividend_i;    // Initialization
        end
        if (cycle == 1)begin
            Q <= Q<<1;
        end
        if (cycle == 3)begin
            Q[0] <= (A[L] == 1)? 1'b0 : 1'b1;
        end
    end


    // A_pev register
    always @(posedge Clk_i)begin
        if(Rst_i) begin
            A_prev <= 0;             // Initialization
        end
        if (cycle == 2)begin
            A_prev <= A;
        end
    end

endmodule






























/*



    wire done;

    // state logic
    parameter IDLE = 1'b0, BUSY = 1'b1;
    
    reg state = IDLE;

    always @(posedge Clk_i) begin
        case(state)
            IDLE:   if(We_i)    state <= BUSY;
            BUSY:   if(done)    state <= IDLE;
    end


    reg [5:0] l;

*/