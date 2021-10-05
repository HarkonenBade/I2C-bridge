
module I2C_bridge(
    input clk,
    input reset,
    inout master_SDA,
    inout master_SCL,
    inout slave_SDA,
    inout slave_SCL);

reg master_SDA_drive;
reg master_SCL_drive;
reg slave_SDA_drive;
reg slave_SCL_drive;

assign master_SDA = master_SDA_drive ? 1'bz : 1'b0;
assign master_SCL = master_SCL_drive ? 1'bz : 1'b0;
assign slave_SDA = slave_SDA_drive ? 1'bz : 1'b0;
assign slave_SCL = slave_SCL_drive ? 1'bz : 1'b0;

always @(posedge clk or posedge reset)
    if(reset)
      begin
        master_SDA_drive <= 1'b1;
        master_SCL_drive <= 1'b1;
        slave_SDA_drive <= 1'b1;
        slave_SCL_drive <= 1'b1;
      end
    else
      begin
        if(master_SDA_drive)
            if(master_SDA)
                slave_SDA_drive <= 1'b1;
            else
                slave_SDA_drive <= 1'b0;
        else
            slave_SDA_drive <= 1'b1;

        if(slave_SDA_drive)
            if(slave_SDA)
                master_SDA_drive <= 1'b1;
            else
                master_SDA_drive <= 1'b0;
        else
            master_SDA_drive <= 1'b1;

        if(master_SCL_drive)
            if(master_SCL)
                slave_SCL_drive <= 1'b1;
            else
                slave_SCL_drive <= 1'b0;
        else
            slave_SCL_drive <= 1'b1;

        if(slave_SCL_drive)
            if(slave_SCL)
                master_SCL_drive <= 1'b1;
            else
                master_SCL_drive <= 1'b0;
        else
            master_SCL_drive <= 1'b1;
      end

endmodule
