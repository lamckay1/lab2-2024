`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/15/2021 06:40:11 PM
// Design Name: 
// Module Name: top_demo
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top_demo
(
  // input
  input  logic [7:0] sw,
  input  logic [3:0] btn,
  input  logic       sysclk_125mhz,
  input  logic       rst,
  // output  
  output logic [7:0] led,
  output logic sseg_ca,
  output logic sseg_cb,
  output logic sseg_cc,
  output logic sseg_cd,
  output logic sseg_ce,
  output logic sseg_cf,
  output logic sseg_cg,
  output logic sseg_dp,
  output logic [3:0] sseg_an
);

  logic [16:0] CURRENT_COUNT;
  logic [16:0] NEXT_COUNT;
  logic        smol_clk;
  
  // Place SHA instantiation here
  logic [255:0] hashed;
  logic [MSG_SIZE-1:0] message;
  localparam MSG_SIZE = 24;
  localparam PADDED_SIZE = 512;
  logic [255:0] result;
  logic [15:0] s;
  top #(MSG_SIZE, PADDED_SIZE) (.message(24'h616263),.hashed(result));
  
  alway_comb begin
        case(sw[1:0])
          4'b0000: s = result[15:0];
          4'b0001: s = result[31:16];
          4'b0010: s = result[47:32];
          4'b0011: s = result[63:48];
          4'b0100: s = result[79:64];
          4'b0101: s = result[95:80];
          4'b0110: s = result[111:96];
          4'b0111: s = result[127:112];
          4'b1000: s = result[143:128];
          4'b1001: s = result[159:144];
          4'b1010: s = result[175:160];
          4'b1011: s = result[191:176];
          4'b1100: s = result[207:192];
          4'b1101: s = result[223:208];
          4'b1110: s = result[239:224];
          4'b1111: s = result[255:240];
          
        
        endcase
  end
  // 7-segment display
  segment_driver driver(
  .clk(smol_clk),
  .rst(btn[3]),
  
    .digit0(s[3:0]),
    .digit1(s[7:4]),
    .digit2(s[11:8]),
    .digit3(s[15:12]),
    
  .decimals({1'b0, btn[2:0]}),
  .segment_cathodes({sseg_dp, sseg_cg, sseg_cf, sseg_ce, sseg_cd, sseg_cc, sseg_cb, sseg_ca}),
  .digit_anodes(sseg_an)
  );

// Register logic storing clock counts
  always@(posedge sysclk_125mhz)
  begin
    if(btn[3])
      CURRENT_COUNT = 17'h00000;
    else
      CURRENT_COUNT = NEXT_COUNT;
  end
  
  // Increment logic
  assign NEXT_COUNT = CURRENT_COUNT == 17'd100000 ? 17'h00000 : CURRENT_COUNT + 1;

  // Creation of smaller clock signal from counters
  assign smol_clk = CURRENT_COUNT == 17'd100000 ? 1'b1 : 1'b0;

endmodule
