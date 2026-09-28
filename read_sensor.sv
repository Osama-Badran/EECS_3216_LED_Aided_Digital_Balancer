module read_sensor(
		input reset_n,
		input clk,
		input KEY0,
		output logic data_valid,

      // SPI Signals
      output SPI_SDI,
      input SPI_SDO,
      output SPI_CSN,
      output SPI_CLK,
		output logic [6:0] seg_left,
		output logic [6:0] seg_right,
		output sign,
		output [15:0] angle_reading
		);
		
		
logic [15:0] data_x;
logic [15:0] data_y;
logic [15:0] data_z;
logic div;

//real atan_result;
//real angle_x;

gsensor l(reset_n, clk, data_valid, 
			data_x, data_y, data_z, 
			SPI_SDI, SPI_SDO, SPI_CSN, SPI_CLK);

ClockDivider vi(clk, div);
			

//Convert the twos complement number to decimal
logic [15:0] datax;
logic [15:0] dataz;


always @(data_x, data_z)
begin
	if (data_z[15]) begin // z number is negative
		dataz = 0;
  	end
	else begin //z number is positive
		dataz = data_z;
		if (data_x[15]) begin //x number is negative
		datax = ~data_x + 1;
		sign = 0; // sign
		end
		else begin //x number is positive
		datax = data_x;
		sign = 1; // sign
		end
	end
end

  logic [15:0] angle;
  logic [3:0] digit1, digit2;
  AngleConverter convert(datax, dataz, angle);


always @(posedge div)
begin
	if (KEY0)
	begin
	digit2 = angle / 10;
	digit1 = angle % 10;
	end
end

    
    

assign seg_left = get_segment_display1(digit2);
assign seg_right = get_segment_display1(digit1);


  assign angle_reading = angle;
  function logic [6:0] get_segment_display1(input integer digit);
  case (digit)
    0: return 7'b1000000;
    1: return 7'b1111001;
    2: return 7'b0100100;
    3: return 7'b0110000;
    4: return 7'b0011001;
    5: return 7'b0010010;
    6: return 7'b0000010;
    7: return 7'b1111000;
    8: return 7'b0000000;
    9: return 7'b0010000;
    default: return 7'b1111111;
  endcase
endfunction
endmodule