module Main;

  reg clk;
  reg rst_n;
  reg enable;
  wire [7:0] data;

  SequenceGenerator sequence_gen (
    .clk(clk),
    .rst_n(rst_n),
    .enable(enable),
    .data(data)
  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    rst_n = 0;
    #10 rst_n = 1;
  end

  initial begin
    enable = 1;
    #100 enable = 0;
    #100 enable = 1;
    #100 enable = 0;
    #100 enable = 1;
    #100 enable = 0;
    #100 enable = 1;
    #100 enable = 0;
    #100 enable = 1;
  end

endmodule
