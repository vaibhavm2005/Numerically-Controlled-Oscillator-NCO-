module nco (
    input wire clk,
    input wire reset,
    input wire [15:0] phase_inc,  // User phase increment
    output reg [7:0] wave_out1,   // Sine wave 1 (user-defined freq)
    output reg [7:0] wave_out2,   // Sine wave 2 (fixed freq = 1000)
    output reg [7:0] wave_out3    // Sine wave 3 (fixed freq = 3000)
);

    // Phase accumulators
    reg [15:0] phase_acc1 = 16'd0;
    reg [15:0] phase_acc2 = 16'd0;
    reg [15:0] phase_acc3 = 16'd0;

    // 256-point sine LUT
    reg [7:0] sine_lut [0:255];

    initial begin
        $readmemh("sine_lut.hex", sine_lut);
        $display("Sine LUT loaded.");
    end

    // Accumulate phases
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            phase_acc1 <= 16'd0;
            phase_acc2 <= 16'd0;
            phase_acc3 <= 16'd0;
        end else begin
            phase_acc1 <= phase_acc1 + phase_inc;
            phase_acc2 <= phase_acc2 + 16'd1000;
            phase_acc3 <= phase_acc3 + 16'd3000;
        end
    end

    // LUT outputs
    always @(posedge clk) begin
        wave_out1 <= sine_lut[phase_acc1[15:8]];
        wave_out2 <= sine_lut[phase_acc2[15:8]];
        wave_out3 <= sine_lut[phase_acc3[15:8]];
    end

endmodule
