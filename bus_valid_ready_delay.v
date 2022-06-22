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

reg        valid_o;
reg[WIDTH-1:0]    data_o;
reg        ready_o;

// internal signal
reg  [WIDTH-1:0]   skid_bus;
reg                skid_val;

wire               dn_active;
wire               valid_o_w;
wire [WIDTH-1:0]   data_o_w;


    // skid_bus always reflects downstream data's last cycle
    always @(posedge clk)
        skid_bus <= data_o_w;


    // skid_val remembers if there is valid data in the skid register until
    // it's consumed by the downstream
    always @(posedge clk)
        if (!rst_n)    skid_val <= 1'b0;
        else        skid_val <= valid_o_w & ~dn_active;


    // down stream mux: if ready_o not active, use last cycle's data and valid
    assign data_o_w = ready_o ? data_i : skid_bus;

    assign valid_o_w = ready_o ? valid_i : skid_val;


    // when down stream is ready or up stream has valid data, set upstream
    // ready to high if the modules 'down' pipeline is not stalled
    always @(posedge clk)
        if      (!rst_n)               ready_o <= 1'b0;
        else if (ready_i | valid_i)   ready_o <= dn_active;


    always @(posedge clk)
        if      (!rst_n)       valid_o <= 1'b0;
        else if (dn_active) valid_o <= valid_o_w;


    always @(posedge clk)
        if (dn_active) data_o <= data_o_w;


    // do not stall pipeline until it is primed
    assign dn_active = ~valid_o | ready_i;



endmodule
