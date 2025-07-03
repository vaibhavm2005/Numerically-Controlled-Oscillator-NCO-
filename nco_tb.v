`timescale 1ns/1ps
module nco_tb;

    reg clk = 0;
    reg reset = 1;
    reg [15:0] phase_inc;
    wire [7:0] wave_out1;
    wire [7:0] wave_out2;
    wire [7:0] wave_out3;

    // Instantiate the NCO
    nco uut (
        .clk(clk),
        .reset(reset),
        .phase_inc(phase_inc),
        .wave_out1(wave_out1),
        .wave_out2(wave_out2),
        .wave_out3(wave_out3)
    );

    // 100 MHz clock
    always #5 clk = ~clk;

    initial begin
        $dumpfile("nco.vcd");
        $dumpvars(0, nco_tb);
        $dumpvars(1, wave_out1);
        $dumpvars(1, wave_out2);
        $dumpvars(1, wave_out3);

        #10 reset = 0;
        phase_inc = 16'd2000;  // User-defined phase increment for wave_out1

        #5000;  // Run simulation for 5 us
        $finish;
    end

endmodule
