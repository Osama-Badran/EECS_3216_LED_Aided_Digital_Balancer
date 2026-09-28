module AngleConverter (
	input [15:0] data_x,
	input [15:0] data_z,
	output logic [15:0] angle
	);
	
	
	

always @(data_z, data_x)
begin
	if (data_x < 4) angle = 0;
	else if (data_x < 8) angle = 1;
	else if (data_x < 12) angle = 2;
	else if (data_x < 16) angle = 3;
	else if (data_x < 20) angle = 4;
	
	else if (data_x < 24) angle = 5;
	else if (data_x < 28) angle = 6;
	else if (data_x < 30) angle = 7;
	else if (data_x < 32) angle = 8;
	else if (data_x < 36) angle = 9;
	
	else if (data_x < 40) angle = 10;
	else if (data_x < 44) angle = 11;
	else if (data_x < 48) angle = 12;
	else if (data_x < 52) angle = 13;
	else if (data_x < 56) angle = 14;
	
	else if (data_x < 60) angle = 15;
	else if (data_x < 64) angle = 16;
	else if (data_x < 68) angle = 17;
	else if (data_x < 72) angle = 18;
	else if (data_x < 76) angle = 19;
	
	else if (data_x < 80) angle = 20;
	else if (data_x < 84) angle = 21; 
	else if (data_x < 88) angle = 22; 
	else if (data_x < 92) angle = 23; 
	else if (data_x < 96) angle = 24;
	
	else if (data_x < 100) angle = 25;
	else if (data_x < 104) angle = 26;
	else if (data_x < 108) angle = 27;
	else if (data_x < 112) angle = 28;
	else if (data_x < 116) angle = 29;
	
	else if (data_x < 120) angle = 30;
	else if (data_x < 124) angle = 31;
	else if (data_x < 128) angle = 32;
	else if (data_x < 132) angle = 33;
	else if (data_x < 136) angle = 34;

	else if (data_x < 140) angle = 35;
	else if (data_x < 144) angle = 36;
	else if (data_x < 148) angle = 37;
	else if (data_x < 152) angle = 38;
	else if (data_x < 155) angle = 39;

	else if (data_x < 158) angle = 40;
	else if (data_x < 161) angle = 41;
	else if (data_x < 164) angle = 42;
	else if (data_x < 167) angle = 43;
	else if (data_x < 170) angle = 44;
	
	else if (data_z >= 170) angle = 45;
	else if (data_z < 170 && data_z >= 167) angle = 46;
	else if (data_z < 167 && data_z >= 164) angle = 47;
	else if (data_z < 164 && data_z >= 161) angle = 48;
	else if (data_z < 161 && data_z >= 158) angle = 49;
	
	else if (data_z < 158 && data_z >= 155) angle = 50;
	else if (data_z < 155 && data_z >= 152) angle = 51;
	else if (data_z < 152 && data_z >= 149) angle = 52;
	else if (data_z < 149 && data_z >= 146) angle = 53;
	else if (data_z < 146 && data_z >= 143) angle = 54;
	
	else if (data_z < 143 && data_z >= 140) angle = 55;
	else if (data_z < 140 && data_z >= 136) angle = 56;
	else if (data_z < 136 && data_z >= 132) angle = 57;
	else if (data_z < 132 && data_z >= 128) angle = 58;
	else if (data_z < 128 && data_z >= 124) angle = 59;
	
	else if (data_z < 124 && data_z >= 120) angle = 60;
	else if (data_z < 120 && data_z >= 116) angle = 61;
	else if (data_z < 116 && data_z >= 112) angle = 62;
	else if (data_z < 112 && data_z >= 108) angle = 63;
	else if (data_z < 108 && data_z >= 104) angle = 64;
	
	else if (data_z < 104 && data_z >= 100) angle = 65;
	else if (data_z < 100 && data_z >= 96) angle = 66;
	else if (data_z < 96 && data_z >= 92) angle = 67;
	else if (data_z < 92 && data_z >= 88) angle = 68;
	else if (data_z < 88 && data_z >= 84) angle = 69;
	
	else if (data_z < 84 && data_z >= 80) angle = 70;
	else if (data_z < 80 && data_z >= 76) angle = 71;
	else if (data_z < 76 && data_z >= 72) angle = 72;
	else if (data_z < 72 && data_z >= 68) angle = 73;
	else if (data_z < 68 && data_z >= 64) angle = 74;
	
	else if (data_z < 64 && data_z >= 60) angle = 75;
	else if (data_z < 60 && data_z >= 56) angle = 76;
	else if (data_z < 56 && data_z >= 52) angle = 77;
	else if (data_z < 52 && data_z >= 48) angle = 78;
	else if (data_z < 48 && data_z >= 44) angle = 79;
	
	else if (data_z < 44 && data_z >= 40) angle = 80;
	else if (data_z < 40 && data_z >= 36) angle = 81;
	else if (data_z < 36 && data_z >= 32) angle = 82;
	else if (data_z < 32 && data_z >= 28) angle = 83;
	else if (data_z < 28 && data_z >= 24) angle = 84;
	
	else if (data_z < 24 && data_z >= 20) angle = 85;	
	else if (data_z < 20 && data_z >= 16) angle = 86;
	else if (data_z < 16 && data_z >= 12) angle = 87;
	else if (data_z < 12 && data_z >= 8) angle = 88;
	else if (data_z < 8 && data_z >= 4) angle = 89;
	
	else if (data_z < 4 && data_z >= 0) angle = 90;


end 
	
	
	
	
endmodule
