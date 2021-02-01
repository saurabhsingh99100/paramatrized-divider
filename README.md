# Paramatrized_Divider
## Description

A paramatrized binary divider using binary restoring division algorithm

## Algorithm



```CYCLE   |   TASK
	CYCLES	|	TASK
------------------------------------------
    0       |   Shift left A-Q pair (A-Q << 1)
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
```



## Prerequisites

- Install iverilog

  ```sudo apt-get install iverilog```

- Install gtkwave

  ```sudo apt-get install gtwave```

  

## Usage

- clone the repository

  ``` git clone <url> ```

- change directory

  ``` cd Paramatrized_Divider```

- run iverilog

  ```iverilog -o out.vvp Div_tb.v```

- run vvp assembly & observe A,Q values

  ```vvp out.vvp```

- observe waveform

  ```gtkwave out.vcd```

  