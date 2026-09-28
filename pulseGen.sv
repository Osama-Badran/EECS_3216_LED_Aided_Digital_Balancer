module pulseGen(
	input [0:311]signal,
	input slc,
	output strip);

	int i=0;
	int pw;
	int count=0;

	always@(posedge slc)
	begin

	if(count>14)
	begin
		if(signal[i]==0)pw=5;
		else if(signal[i]==1)pw=9;
		
		if(i>310)
		begin
			strip = 0;
			count=count+1;
			i=311;
			if(count>10000)
			begin
			i=0;
			count=0;
			end
		end
		else 
		begin
			i=i+1;
			count = 0;
		end
		
	end
	else if(count>pw)
	begin
		strip=0;
		count = count + 1;
	end
	else
	begin
		strip=1;
		count = count + 1;
	end
	
	end	
	
	

endmodule
