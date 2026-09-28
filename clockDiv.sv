module clockDiv(
	input clk,rst,
	output seconds);
	
	int counter;
	int DIVISOR = 2;
	
	initial 
	begin
	seconds=1;
	counter=0;
	end
	
	always@(posedge clk)
	begin
	if(rst==0)
	begin
		counter=counter+1;
	
		if(counter>=DIVISOR) begin 
		counter=0;
		seconds=!seconds;
		end
	end
	else seconds=0;
		
	end

endmodule
