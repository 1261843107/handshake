module bus_valid_delay(
    clk, rst_n, valid_i, valid_o, ready_i, ready_o, data_i, data_o
);

parameter Width = 8;

input        clk;
input        rst_n;
input        valid_i;
input        ready_i;
input[Width-1:0]   data_i;
output[Width-1:0]  data_o;
output       valid_o;
output       ready_o;

reg        valid_o;
reg[Width-1:0]    data_o;
 
assign ready_o = ready_i || ~valid_o;
assign handshake = valid_i && ready_o;
 
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        valid_o <= 1'b0;
    else if(handshake)
            valid_o <= valid_i;
end
always@(posedge clk or negedge rst_n)begin
    if(handshake)
        data_o <= data_i;
end
endmodule
