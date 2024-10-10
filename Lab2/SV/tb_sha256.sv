`timescale 1ns/1ps
module stimulus;

   parameter MSG_SIZE = 24;   

   logic [MSG_SIZE-1:0] message1;   
   logic [255:0] hashed1;
   logic [MSG_SIZE-1:0] message2;   
   logic [255:0] hashed2;  
   logic [MSG_SIZE-1:0] message3;   
   logic [255:0] hashed3;  
   logic [MSG_SIZE-1:0] message4;   
   logic [255:0] hashed4;
   logic [MSG_SIZE-1:0] message5;   
   logic [255:0] hashed5;

   logic 	 clk;
   logic [31:0]  errors;
   logic [31:0]  vectornum;
   logic [255:0]  result1;
   logic [255:0]  result2;
   logic [255:0]  result3;
   logic [255:0]  result4;
   logic [255:0]  result5;
   // Size of [351:0] is size of vector in file: 96 + 256 = 352 bits
   logic [351:0] testvectors[511:0];
   integer 	 handle3;
   integer 	 desc3;
   integer 	 i;  
   integer       j;

   // Instantiate DUT
   top #(MSG_SIZE, 512) dut1 (message1, hashed1);
   top #(MSG_SIZE, 512) dut2 (message2, hashed2);
   top #(MSG_SIZE, 512) dut3 (message3, hashed3);
   top #(MSG_SIZE, 512) dut4 (message4, hashed4);
   top #(MSG_SIZE, 512) dut5 (message5, hashed5);
   // 1 ns clock
   initial 
     begin	
	clk = 1'b1;
	forever #5 clk = ~clk;
     end

   initial
     begin
	handle3 = $fopen("sha256.out");
	vectornum = 0;
	errors = 0;		
	desc3 = handle3;
     $readmemh("sha256.tv", testvectors, 0, 4);
     end

     

    // apply test vectors on rising edge of clk
   always @(posedge clk)
     begin
	// Add message here : "abc"	
	      #1 message1 = testvectors[vectornum];
	// Expected result 
        #0 result1 = 256'hba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad;	
	
     end  

     
      

   // check results on falling edge of clk
   always @(negedge clk)
     begin
	if (result1 != hashed1)
          errors = errors + 1;
        $fdisplay(desc3, "message: %h\nhashed: %h\nresult: %h\nmatching: %b\n\n", 
                  message1, hashed1, result1, (result1 == hashed1));
	vectornum = vectornum + 1;
	if (testvectors[vectornum] === 352'bx) 
          begin 
             $display("%d tests completed with %d errors", 
                      vectornum, errors);
             $finish;
          end
     end   //1


endmodule // stimulus
