module shift_lr #(
    parameter DW = 32
) (
    input [DW-1:0]               src,
    input [$clog2(DW)-1:0]       n,
    input                        op_srl,
    output [DW-1:0]              out                    
);
    wire [DW-1:0]    shift_src;
    wire [DW-1:0]    reverse;
    wire [DW-1:0]    sll_res;
    wire [DW-1:0]    shift_res;
    wire [DW-1:0]    sra_mask;
    wire [DW-1:0]    srl_res;
    wire [DW-1:0]    sra_res;
    genvar i;
    generate
        for(i = 0; i < DW; i=i+1) begin
            assign reverse[i] = src[DW-1-i];
        end 
    endgenerate
    assign shift_src = op_srl?reverse:src;

    // assign shift_src = op_srl ? {
    //                             src[0] , src[1] , src[2] , src[3] , src[4] , src[5] , src[6] , src[7],
    //                             src[8] , src[9] , src[10], src[11], src[12], src[13], src[14], src[15],
    //                             src[16], src[17], src[18], src[19], src[20], src[21], src[22], src[23],
    //                             src[24], src[25], src[26], src[27], src[28], src[29], src[30], src[31]
    //                             }
    //                             : src[31:0];

    assign shift_res = shift_src >> n;//shift result
    assign sra_mask = ~({DW{1'b1}}) >> n;
    assign srl_res = shift_res;
    assign sra_res = {{32{src[DW-1]}} & sra_mask} | shift_res;

    generate
        for(i = 0; i < DW; i=i+1) begin
            assign sll_res[i] = sra_res[DW-1-i];
        end 
    endgenerate
    assign out = op_srl?sll_res:shift_res;
endmodule