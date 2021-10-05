module test;


    reg master_SDA_drive = 1;
    reg master_SCL_drive = 1;
    reg slave_SDA_drive = 1;
    reg slave_SCL_drive = 1;
    tri1 master_SDA;
    tri1 master_SCL;
    tri1 slave_SDA;
    tri1 slave_SCL;

    reg reset = 0;
    reg clk = 0;

    assign master_SDA = master_SDA_drive ? 1'bz: 1'b0;
    assign master_SCL = master_SCL_drive ? 1'bz: 1'b0;
    assign slave_SDA = slave_SDA_drive ? 1'bz: 1'b0;
    assign slave_SCL = slave_SCL_drive ? 1'bz: 1'b0;

    always #5 clk = !clk;

    initial begin
        #10 reset = 1;
        #10 reset = 0;
        #50 master_SCL_drive = 0;
        #50 master_SCL_drive = 1;
        #50 master_SCL_drive = 0;
        #50 master_SDA_drive = 0;
        #50 master_SCL_drive = 1;
        #50 master_SDA_drive = 1;
        #50 slave_SDA_drive = 0;
        #50 master_SCL_drive = 0;
        #50 slave_SDA_drive = 1;
        #50 master_SCL_drive = 1;
        #50 $finish;
    end

    I2C_bridge mod(.clk(clk),
                   .reset(reset),
                   .master_SDA(master_SDA),
                   .master_SCL(master_SCL),
                   .slave_SDA(slave_SDA),
                   .slave_SCL(slave_SCL));

    initial
        $monitor("%t - Reset:%0d, Master: SCL:%0d SDA:%0d, Slave: SCL:%0d SDA: %0d",
                 $time, reset, master_SCL, master_SDA, slave_SCL, slave_SDA); 

endmodule
