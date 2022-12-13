`timescale 1ns/1ps
module register_tb;

    wire[31:0] q_DDF_en_rst;
    wire[31:0] q_DDF_rst;
    wire[31:0] q_DDF_en;
    wire[31:0] q_DDF;
    reg[31:0] d;
    reg clk;
    reg rst;
    DDF_en_rst #(.DW(32), .RESET_VALUE(32'h01010101)) u1
    (
        .clk(clk),
        .en(1),
        .rst(rst),
        .din(d),
        .q(q_DDF_en_rst)
    );
    DDF_rst #(.DW(32), .RESET_VALUE(32'h01010101)) u2
    (
        .clk(clk),
        .rst(rst),
        .din(d),
        .q(q_DDF_rst)
    );
    DDF_en #(.DW(32)) u3
    (
        .clk(clk),
        .en(1),
        .din(d),
        .q(q_DDF_en)
    );
    DDF #(.DW(32)) u4
    (
        .clk(clk),
        .din(d),
        .q(q_DDF)
    );
    initial begin
        clk <= 0;
        rst <= 0;
        #15 
        rst <= 1;
        #17  d<=32'h5a5a5a5a;
        #17 d<=32'h11111111;
        #5 rst <= 0;
    end

    always #5 clk = ~clk;

initial begin
    $dumpfile("./build/wave.vcd");  // 指定VCD文件的名字为wave.vcd，仿真信息将记录到此文件
    $dumpvars(0, register_tb);  // 指定层次数为0，则tb_code 模块及其下面各层次的所有信号将被记录

    #10000 $finish;
end

endmodule