typedef enum logic [1:0] {
  DISPLAY, SET
  }state_t;

module Digital_Level_Project(
  input logic clk, 
  input logic [9:0] SW,
  input logic [1:0] KEY,
  output logic [6:0] HEX0,
  output logic [6:0] HEX1,
  output logic HEX2,
  
  //Accelerometer IO
  input logic SPI_SDO,
  output logic SPI_SDI,
  output logic SPI_CSN,
  output logic SPI_CLK,
  
  //LED Strip IO
  output logic led_data);
  
  logic reset;
  assign reset = KEY[0];

  //Signed angle reading
  logic [15:0] angle_reading;
  logic sign;
  logic [6:0] seg_left, seg_right;

  logic [15:0]angle_al;
  
  //= {sign, angle_reading[14:0]};
  
  assign angle_al[15] = sign;
  
  assign angle_al[14:0]=angle_reading[14:0];
  
  assign angle_reading_s = angle_al; 
  
  //Signed set angle
  logic set_mode;
  
  assign set_mode= KEY[1];
  logic last_set_mode;

  logic [15:0] set_angle;
  logic set_sign;
  logic [6:0] set_seg_left, set_seg_right;

  logic [15:0]set_angle_al;
  // = {set_sign, set_angle[14:0]};
  
  assign set_angle_al[15] = set_sign;
  assign set_angle [14:0] = set_angle[14:0];
 
  assign set_angle_s = set_angle_al; 

  //Initialize acceleromter module
  read_sensor rs(
    .clk(clk),
    .reset_n(reset), 
    .SPI_SDI(SPI_SDI),
    .SPI_SDO(SPI_SDO),
    .SPI_CSN(SPI_CSN),
    .SPI_CLK(SPI_CLK),
    .seg_right(seg_right),
    .seg_left(seg_left),
    .sign(sign),
    .angle_reading(angle_reading)
  );

  //Get LED index (of reading)
  int reading_id;
  int set_id;
  always_comb begin
    reading_id = led_idx(angle_reading_s);
    set_id = led_idx(set_angle_s);
  end

  output_led_strip ols(.clk(clk), .curr(reading_id), .set(set_id), .strip(led_data));
  
  //State Machine - we only have 2 states so nx_state is not very useful
  //Set mode and reset are the only 2 events that will change current state
  state_t state;
  state_t nx_state;

  always_ff@(negedge reset) begin
    if (!reset) begin
      state <= DISPLAY;
		last_set_mode <=set_mode;
    end
	 else
	 begin
	 state<=nx_state;
	 last_set_mode <=set_mode;
	 end
  end

	always@(state)
	begin
		case(state)
			DISPLAY:
				begin
					if((set_mode != last_set_mode)&(!set_mode))
					begin
						nx_state <= SET;
					end
				end
			SET:
				begin
					if((set_mode !=last_set_mode) &(!set_mode))
					begin
						nx_state <=DISPLAY;
						set_angle <= {7'd0,SW[8:0]};
						set_sign <=SW[9];
					end
				end
		endcase
	end
			

  //Determine digits for set number (only needed when switches are changed)
  logic [3:0] digit1, digit2;
  always_ff@(SW) begin
    digit2 = set_angle / 10;
    digit1 = set_angle % 10;
  end
  assign set_seg_left = get_segment_display(digit2);
  assign set_seg_right = get_segment_display(digit1);

  //Output logic
  always_comb begin
    case (state)
      DISPLAY: begin
        HEX0 <= seg_right;
        HEX1 <= seg_left;
        HEX2 <= sign;
      end
      SET: begin
        HEX0 <= set_seg_right;
        HEX1 <= set_seg_left;
        HEX2 <= set_sign;
      end
    endcase
  end
  
function int led_idx(int signed angle_reading_s);
  int id;
  if (angle_reading_s <= -90) begin
    id = 13;
  end else if (angle_reading_s >= 90) begin 
    id = 1;
  end else begin 
    id = 7 - int'(angle_reading_s / (180/13));
    if (id <= 0) begin
      id += 13;
    end
  end
  return id;
endfunction

function logic [6:0] get_segment_display(input integer digit);
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

  