module bus_valid_ready_delay(
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
output       ready_o;

// reg        valid_o;
// reg[WIDTH-1:0]    data_o;
// reg        ready_o;

// internal signal
wire  [WIDTH-1:0]  data_temp;
wire               valid_temp;
wire               ready_temp;

bus_ready_delay u_bus_ready_delay(
    .clk     ( clk     ),
    .rst_n   ( rst_n   ),
    .valid_i ( valid_i ),
    .valid_o ( valid_temp ),
    .ready_i ( ready_temp ),
    .ready_o ( ready_o ),
    .data_i  ( data_i  ),
    .data_o  ( data_temp  )
);

bus_valid_delay u_bus_valid_delay(
    .clk     ( clk     ),
    .rst_n   ( rst_n   ),
    .valid_i ( valid_temp ),
    .valid_o ( valid_o ),
    .ready_i ( ready_i ),
    .ready_o ( ready_temp ),
    .data_i  ( data_temp  ),
    .data_o  ( data_o  )
);



endmodule
