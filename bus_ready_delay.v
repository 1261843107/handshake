module bus_ready_delay(
    clk, rst_n, valid_i, valid_o, ready_i, ready_o, data_i, data_o
);

parameter WIDTH = 32;

input        clk;
input        rst_n;
input        valid_i;
input        ready_i;
input[WIDTH-1:0]   data_i;
output[WIDTH-1:0]  data_o;
output       valid_o;
output  reg  ready_o;

wire store_data;
reg[WIDTH-1:0]    buffered_data;
reg               buffer_valid;

assign store_data = valid_i && ready_o && ~ready_i;
 
always @(posedge clk)
	if (!rst_n)  buffer_valid <= 1'b0;
	else        buffer_valid <= buffer_valid ? ~ready_i: store_data;
//Note: If now buffer has data, then next valid would be ~ready_i:   
//If downstream is ready, next cycle will be un-valid.    
//If downstream is not ready, keeping high. 
// If now buffer has no data, then next valid would be store_data, 1 for store;
always @(posedge clk)
	if (!rst_n)  buffered_data <= {WIDTH{1'b0}};
	else        buffered_data <= store_data ? data_i : buffered_data;

always @(posedge clk) begin
	if (!rst_n)  ready_o <= 1'b1; //rst_n can be 1.
	else        ready_o <= ready_i || ((~buffer_valid) && (~store_data)); //Bubule clampping
	end
//Downstream valid and data.
//Bypass
assign valid_o = ready_o? valid_i : buffer_valid;
assign data_o  = ready_o? data_i  : buffered_data;

endmodule
