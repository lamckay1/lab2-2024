`timescale 1ns/1ps
module stimulus;

   parameter MSG_SIZE = 24;   

   logic [MSG_SIZE-1:0] message;   
   logic [255:0] hashed;
   

   logic 	 clk;
   logic [31:0]  errors;
   logic [31:0]  vectornum;
   logic [255:0]  result;
   // Size of [351:0] is size of vector in file: 24 + 256 = 352 bits
   logic [279:0] testvectors[511:0];
   integer 	 handle3;
   integer 	 desc3;
   integer 	 i;  
   integer       j;

   // Instantiate DUT
   top #(MSG_SIZE, 512) dut (message, hashed);
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
	// Add message here	
	      #1 message = testvectors[vectornum][279:256];
	// Expected result 
        #0 result = testvectors[vectornum][255:0];	
	
     end  

     
      

   // check results on falling edge of clk
   always @(negedge clk)
     begin
	if (result != hashed)
          errors = errors + 1;
        $fdisplay(desc3, "message: %h\nhashed: %h\nresult: %h\nmatching: %b\n\n", 
                  message, hashed, result, (result == hashed));
	
	if (testvectors[vectornum] === {280{1'bx}}) 
          begin 
             $display("%d tests completed with %d errors", 
                      vectornum, errors);
             $finish;
          end else begin 
vectornum = vectornum + 1;
          end
     end   //1


endmodule // stimulus
