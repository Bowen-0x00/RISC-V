
module shift_tb ();

reg [63:0]       src;
reg [5:0]       n;
reg            op_srl;
wire [63:0]     out;

shift_lr #(.DW(64))u1
(
    .src(src),
    .n(n),
    .op_srl(op_srl),
    .out(out)  
);

initial begin

        #5 src = 64'hFEDCBA9876543210;
            op_srl = 0;
            n = 1;
        #5  n = 63;
        #5  n = 64;
        #5  op_srl = 1; n = 2;
        
end


initial begin
    $dumpfile("./build/wave.vcd");  // 指定VCD文件的名字为wave.vcd，仿真信息将记录到此文件
    $dumpvars(0, shift_tb );  // 指定层次数为0，则tb_code 模块及其下面各层次的所有信号将被记录
    #10000 $finish;
end

endmodule