`timescale 1ns / 1ps

module no_filter_top (
    input  CLK100MHZ    ,
    input  ADC_IN       ,
    output DAC_OUT      ,
    output ADC_CLK      , 
    output ADC_CS       
);
    wire sample_clk;
    assign ADC_CLK = sample_clk;
    reg [11:0] DATA;
    assign DAC_OUT = 0;
    
    ext_clk_gen CLK_GEN ( .sys_clk(CLK100MHZ), .clk_out(sample_clk) );	
    adc_handler #( .V_REF(2.0) ) ADC_INST ( .d_clk(sample_clk), .d_out(ADC_IN), .not_cs(ADC_CS), .adc_data_latched(DATA) );
    
endmodule