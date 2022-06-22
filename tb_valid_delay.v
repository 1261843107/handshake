`timescale 1ns/1ps
module tb_valid_delay;

parameter Width = 32;
reg clk;
reg rst_n;
reg valid_i;
reg ready_i;
reg [Width-1:0] data_i;
wire  [Width-1:0] data_o;
wire  valid_o;
wire  ready_o;

 
bus_valid_delay u_bus_valid_delay(
    .clk     ( clk     ),
    .rst_n   ( rst_n   ),
    .valid_i ( valid_i ),
    .ready_i ( ready_i ),
    .data_i  ( data_i  ),
    .data_o  ( data_o  ),
    .valid_o ( valid_o ),
    .ready_o  ( ready_o  )
);



initial begin 
    clk <= 0;
    forever begin
      #5 clk <= !clk;
    end
end


initial begin 
    #10 rst_n <= 0;
    repeat(3) @(posedge clk);
    rst_n <= 1;
end

initial begin
    @(posedge rst_n);
    repeat(3) @(posedge clk);
    write_data('h0000_0000);
    write_data('h0000_0001);
    write_data('h0000_0002);
    write_data('h0000_0003);
    write_data('h0000_0004);
    write_data('h0000_0005);
    write_data('h0000_0006);
    write_data('h0000_0007);
    write_data('h0000_0008);
    write_data('h0000_0009);
    write_data('h0000_000a);
    write_data('h0000_000b);
    write_data('h0000_000c);
end
initial begin
    @(posedge rst_n);
    repeat(3) @(posedge clk);
    ready();
    ready();
    ready();
    ready();
    ready();
    ready();
    idle();
    ready();
    idle();
    ready();    
    idle();
    ready();
    idle();
    ready();
    idle();
    ready();
    idle();
    ready();
    idle();
    ready();
end

task write_data(input reg[Width-1:0] data);
begin
    @(posedge clk);
    if (ready_o || ~valid_i) begin
        data_i <= data;
        valid_i <= 1;
    end
    else begin
        write_data(data);
    end
end 



endtask

task ready();
begin
    @(posedge clk);
    begin
        ready_i <= 1;
    end
end 



endtask

task idle();
begin
    @(posedge clk);
    begin
        ready_i <=0;
    end

end 


endtask

endmodule
`default_nettype wire