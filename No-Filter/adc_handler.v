// ADC handler/interface code for TI ADS7816 analog-digital converter
// Writen by James Dalton 7/6/18

`define SYS_CLK_RATE	100_000_000 // Hz
`define ADC_SAMP_RATE	62_500		// Hz

module adc_handler # (
    parameter V_REF = 2.0
    )(
	input 	d_clk	    ,     // Clock source is generated from an external module
	input 	d_out	    ,
	output reg	not_cs	,
	output reg [11:0] adc_data_latched//,
	//output reg  data_valid   // Pulse tells top module that current data string is valid
	);
	
	reg [11:0] adc_data; 	// 12-bit data coming from ADC	
	reg [7:0]  clk_num;	
	
	// Initially set the chip to be inactive
	//not_cs = 1'b1;
	
	always@(negedge d_clk) begin
		case (clk_num)
			'd0: not_cs <= 1'b1;
			'd1: not_cs <= 1'b0; // Enable output, data is valid after 2 clock periods
			'd2: clk_num <= clk_num; // Data still not valid, NOP
			'd3: clk_num <= clk_num; // Data still not valid, NOP
			'd4: adc_data[11] <= d_out;
			'd5: adc_data[10] <= d_out;
			'd6: adc_data[9]  <= d_out;
			'd7: adc_data[8]  <= d_out;
			'd8: adc_data[7]  <= d_out;
			'd9: adc_data[6]  <= d_out;
			'd10: adc_data[5] <= d_out;
			'd11: adc_data[4] <= d_out;
			'd12: adc_data[3] <= d_out;
			'd13: adc_data[2] <= d_out;
			'd14: adc_data[1] <= d_out;
			'd15: adc_data[0] <= d_out;
			'd16: not_cs <= 1'b1;
			default: begin clk_num  <= 1'b0;
					 adc_data_latched <= adc_data;
					 not_cs   <= 1'b1;
					 end
		endcase
		clk_num = clk_num + 1'b1;
	end
	
endmodule