////////////////////////////////////////////////////////////////////////////////////////////////////////
// I2C_Interface.v
//
// Author:			Thanh Tien Truong
//
// Description:
// ------------
// SCCB interface to communicate with OV7670
//  - Implementing two-wire data transmission of SCCB protocol
//	- Using 3-phase write transmission cycle of SCCB protocol
//
//////////////////////////////////////////////////////////////////////////////////////////////////////
`include "global.h"
`ifndef SCCB_V1
module I2C_Interface ( 
    input clk,                                  // 50Mhz clock signal
    inout siod,                                 // Data signal for SCCB
    output sioc,                                // Clock signal for SCCB
    output taken,                               // Flag to go to next address of LUT
    input send,                                 // Flag to indicate if configuration is finshed
    input [7:0] rega,                           // Resgister address
    input [7:0] value);                         // Data to write into a regsiter address
                            
    
    // Internal signals
    reg [7:0] divider = 8'b00000001;
    reg [31:0] busy_sr = {32{1'b0}};
    reg [31:0] data_sr = {32{1'b1}};
    reg sioc_temp;
    reg taken_temp;
    reg siod_temp;
    
    // ID of an OV7670 for SCCB protocol
//    localparam id = 8'h42;
	// ID of an OV2640 for SCCB protocol
    localparam id = 8'h60;
    
    // Assign value for outputs
    assign siod = siod_temp;
    assign sioc = sioc_temp;
    assign taken = taken_temp;
    
    always @ (busy_sr or data_sr[31]) begin
        // when the bus is idle SIOD must be tri-state
        if(busy_sr[11:10] == 2'b10 || busy_sr[20:19] == 2'b10 || busy_sr[29:28] == 2'b10) begin
            siod_temp <= 1'bZ;
        end
        // else SIOD will be driven my master (FPGA board)
        else begin
            siod_temp <= data_sr[31];
        end
    end
        
    always @ (posedge clk) begin
        taken_temp <= 1'b0;
        
        // If all 31 bits are transmitted 
        if(busy_sr[31] == 0) begin
            // Assert SIOC high for starting new transmission
            sioc_temp <= 1;
            
            // If New data is arrived from LUT 
            if(send == 1) begin
                if(divider == 8'b00000000) begin
                    // Create an data to send through the data signal of the SCCB
                    // The data is created using 3-phase write transmission cycle of SCCB protocol
                    //
                    // Data:  
                    // 3'b100 --> SIOD will go from 1 to 0 to indicate a start transmission
                    //            the last bit is an don't care bit
                    // id     --> the ID of a slave (8'h60). The last bit of the slave is 0 inidicate a write transaction
                    // 1'b0   --> don't care bit to seperate phases
                    // rega   --> register address that want to write into
                    // 1'b0   --> don't care bit to seperate phases
                    // value  --> data to write into the register address
                    // 1'b0   --> don't care bit to seperate phases
                    // 2'b01  --> SIOD will go from 0 to 1 to indicate a stop tranmission
                    
                    data_sr <= {3'b100, id, 1'b0, rega, 1'b0, value, 1'b0, 2'b01};
                    busy_sr <= {3'b111, 9'b111111111, 9'b111111111, 9'b111111111, 2'b11};
                    taken_temp <= 1'b1;
                end
                else begin
                    divider <= divider + 1;
                end
            end
            
        end
        
        // Implement two-write data transmission of SCCB protocol
        else begin
            case ({busy_sr[31:29],busy_sr[2:0]})        // Checking for the start and stop condition
                // For START condition
                6'b111_111: begin                       // bit 31th of data_sr is transmitted, SIOC must be high
                    case (divider[7:6])                 // --> SIOD goes from tri-state to high             
                        2'b00: sioc_temp <= 1;          
                        2'b01: sioc_temp <= 1;          
                        2'b10: sioc_temp <= 1;          
                        default: sioc_temp <= 1;
                    endcase
                end
                
                6'b111_110: begin                       // bit 30th of data_sr is transmitted
                    case (divider[7:6])                 // --> SIOD goes from high to low, SIOC must be high
                        2'b00: sioc_temp <= 1;          // --> complete START condition
                        2'b01: sioc_temp <= 1;
                        2'b10: sioc_temp <= 1;
                        default: sioc_temp <= 1;
                    endcase
                end
            
                6'b111_100: begin                       // bit 29th of data_sr is transmitted (don't care bit)
                    case (divider[7:6])                 // --> SIOD goes from tri-state to high, then high to low 
                        2'b00: sioc_temp <= 0;          //     after SIOC goes from high to low 
                        2'b01: sioc_temp <= 0;          // --> Ready for first transmission from Master to Slave
                        2'b10: sioc_temp <= 0;
                        default: sioc_temp <= 0;
                    endcase
                end
            
                // For STOP condition
                6'b110_000: begin                       // bit 2nd of data_sr is transmitted (don't care bit)
                    case (divider[7:6])                 // SIOC waits for 1 clock cyle of 200Khz then go high    
                        2'b00: sioc_temp <= 0;
                        2'b01: sioc_temp <= 1;
                        2'b10: sioc_temp <= 1;
                        default: sioc_temp <= 1;
                    endcase
                end
            
                6'b100_000: begin                       // bit 1st of data_sr is transmitted
                    case (divider[7:6])                 // SIOD is low
                        2'b00: sioc_temp <= 1;          // SIOC must be high
                        2'b01: sioc_temp <= 1;
                        2'b10: sioc_temp <= 1;
                        default: sioc_temp <= 1;
                    endcase
                end
            
                6'b000_000: begin                       // bit 0th of data_sr is transmitted
                    case (divider[7:6])                 // SIOD is high
                        2'b00: sioc_temp <= 1;          // --> SIOD goes from low to high while SIOC is high
                        2'b01: sioc_temp <= 1;          // --> complete STOP condition for SCCB protocol    
                        2'b10: sioc_temp <= 1;
                        default: sioc_temp <= 1;
                    endcase
                end
                
                // Between START and STOP condition
                // SIOC is high on 2 cycles of 400Khz and low on 2 cycle of 400Khz
                // --> SIOC is 200Khz
                default: begin                          
                    case (divider[7:6])
                        2'b00: sioc_temp <= 0;          
                        2'b01: sioc_temp <= 1;          
                        2'b10: sioc_temp <= 1;
                        default: sioc_temp <= 0;
                    endcase
                end
            endcase
        
            // Create a frequency for SCCB with is 200KHz
            if(divider == 8'b11111111) begin
                busy_sr <= {busy_sr[30:0], 1'b0};        // Update number of bit that get transmitted
                data_sr <= {data_sr[30:0], 1'b1};        // Update new bit 31th by bit 30th
                divider <= {8{1'b0}};                   // Reset counter for clock divider
            end
            else begin
                divider <= divider + 1;
            end
        
        end
    end
endmodule
`endif