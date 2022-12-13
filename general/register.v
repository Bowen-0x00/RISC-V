module DDF_en_rst #(
    parameter DW = 32,
    parameter RESET_VALUE = 0
) (
    input       clk,
    input       en,
    input       rst,
    input       [DW-1:0] din,
    output reg  [DW-1:0] q
);
    reg [DW-1:0] q_r;

    always @(posedge clk or negedge rst) begin
        if (rst == 1'b0)
            q <= {DW{RESET_VALUE}};
        else if (en)
            q <= din;
    end

endmodule

module DDF_rst #(
    parameter DW = 32,
    parameter RESET_VALUE = 0
) (
    input       clk,
    input       en,
    input       rst,
    input       [DW-1:0] din,
    output reg  [DW-1:0] q
);
    reg [DW-1:0] q_r;

    always @(posedge clk or negedge rst) begin
        if (rst == 1'b0)
            q <= {DW{RESET_VALUE}};
        else
            q <= din;
    end

endmodule

module DDF_en #(
    parameter DW = 32
) (
    input       clk,
    input       en,
    input       rst,
    input       [DW-1:0] din,
    output reg  [DW-1:0] q
);
    reg [DW-1:0] q_r;

    always @(posedge clk or negedge rst) begin
        if (en)
            q <= din;
    end

endmodule

module DDF #(
    parameter DW = 32
) (
    input       clk,
    input       [DW-1:0] din,
    output reg  [DW-1:0] q
);
    reg [DW-1:0] q_r;

    always @(posedge clk) begin
            q <= din;
    end

endmodule