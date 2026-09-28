module output_led_strip(
	input clk, 
	input[9:0]sw,
	input curr, set,
	output LED,strip,ck);
	
	logic slC;
	logic [0:311]signal = 312'd0;
	//111111111111111111111111, 000000000000000000000000
	//312'd0; 312'b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
	initial 
	begin 
		strip=0;
	end
	
	int i = 0;
	//int curr,set=0;
	int LED1_l=1, LED1_h=1, LED2_l=1, LED2_h=1;

	clockDiv c(clk,sw[0],slc);	
	
	assign ck=slc;
	assign LED=slc;
	
	
	
	//for testing purposes
//	always@(sw)
//	begin
//		if(sw[1])
//		begin
//			curr=1;
//		end
//		if(sw[2])
//		begin
//			curr=2;
//		end
//		if(sw[3])
//		begin
//			curr=3;
//		end
//		if(sw[4])
//		begin
//			curr=4;
//		end
//		
//		if(sw[5])
//		begin
//			set=1;
//		end
//		if(sw[6])
//		begin
//			set=2;
//		end
//		if(sw[7])
//		begin
//			set=3;
//		end
//		if(sw[8])
//		begin
//			set=4;
//		end
//		if(sw[9])
//		begin
//			set=0;
//			curr=0;
//		end
//	end	

	
	always@(curr,set)
	begin
		case(curr)
			0:
			begin
				LED1_l=0;
				LED1_h=0;
			end
			1:
			begin
				LED1_l=0;
				LED1_h=15;
			end
			2:
			begin
				LED1_l=23;
				LED1_h=39 ;
			end
			3:
			begin
				LED1_l=47;
				LED1_h=63;
			end
			4:
			begin
				LED1_l=71;
				LED1_h=87; 
			end
			5:
			begin
				LED1_l=95;
				LED1_h=111; 
			end
			6:
			begin
				LED1_l=119;
				LED1_h=135; 
			end
			7:
			begin
				LED1_l=143;
				LED1_h=159; 
			end
			8:
			begin
				LED1_l=167;
				LED1_h=183; 
			end
			9:
			begin
				LED1_l=191;
				LED1_h=207; 
			end
			10:
			begin
				LED1_l=215;
				LED1_h=231; 
			end
			11:
			begin
				LED1_l=239;
				LED1_h=255; 
			end
			12:
			begin
				LED1_l=263;
				LED1_h=279; 
			end
			13:
			begin
				LED1_l=287;
				LED1_h=303; 
			end
	
		endcase
		case(set)
			0:
			begin
				LED2_l=0;
				LED2_h=0;
			end
			1:
			begin
				LED2_l=0;
				LED2_h=15;
			end
			2:
			begin
				LED2_l=23;
				LED2_h=39;
			end
			3:
			begin
				LED2_l=47;
				LED2_h=63;
			end
			4:
			begin
				LED2_l=71;
				LED2_h=87;
			end
			5:
			begin
				LED2_l=95;
				LED2_h=111; 
			end
			6:
			begin
				LED2_l=119;
				LED2_h=135; 
			end
			7:
			begin
				LED2_l=143;
				LED2_h=159; 
			end
			8:
			begin
				LED2_l=167;
				LED2_h=183; 
			end
			9:
			begin
				LED2_l=191;
				LED2_h=207; 
			end
			10:
			begin
				LED2_l=215;
				LED2_h=231; 
			end
			11:
			begin
				LED2_l=239;
				LED2_h=255; 
			end
			12:
			begin
				LED2_l=263;
				LED2_h=279; 
			end
			13:
			begin
				LED2_l=287;
				LED2_h=303; 
			end
		endcase
	
	end

	always@(LED1_l,LED1_h,LED2_l,LED2_h)
	begin
	for(i=0;i<312;i = i+1)
			begin
				if((LED1_h==LED2_h)&LED1_h!=0)
				begin
					if((i>=LED1_l)&(i<LED1_h-8))signal[i] = 1;
					else signal[i] = 0;
				end
				else
				begin
					if(((i>=LED1_l)&(i<LED1_h))|((i>=LED2_l)&(i<LED2_h)))signal[i] = 1;
					else signal[i] = 0;
				end
			end
	end
	
	pulseGen p(signal, slc, strip);


endmodule
