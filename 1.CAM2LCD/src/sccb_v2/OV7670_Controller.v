//////////////////////////////////////////////////////////////////////////////////
// OV7670_Controller.v
//
// Author:			Thanh Tien Truong
//
// Description:
// ------------
// - Sending data to OV7670 registers through SCCB interface
//   to configure the mode of the OV7670
//
// - The module has 2 instances:
//   OV7670_Registers    - Like a LUT containing all the registers address 
//                              and data to write into a registers
//   I2C_Interface       - SCCB interface to communicate with OV7670
//	
//////////////////////////////////////////////////////////////////////////////////
`include "global.h"
`ifndef SCCB_V1
module OV7670_Controller (
    input clk,                              // 50Mhz clock signal
    input resend,                           // Reset signal
    output config_finished,                 // Flag to indicate that the configuration is finished
    output sioc,                            // SCCB interface - clock signal
    inout siod,                             // SCCB interface - data signal
    output reset,                           // RESET signal for OV7670
    output pwdn                             // PWDN signal for OV7670
);

    // Internal signals
    wire [15:0] command;
    wire finished;
    wire taken;
    reg send = 0;
   
    // Signal for testing
    assign config_finished = finished;
    
    // Signals for RESET and PWDN OV7670
    assign reset = 1'b1;
    assign pwdn = 1'b0;
    
    // Signal to indicate that the configuration is finshied    
    always @ (finished) begin
        send = ~finished;
    end
    
    // Create an instance of a LUT table 
    OV7670_Registers u_OV7670_Registers(
        .clk(clk),                          // 50Mhz clock signal
        .advance(taken),                    // Flag to advance to next register
        .command(command),                  // register value and data for OV7670
        .finished(finished),                // Flag to indicate the configuration is finshed
        .resend(resend)                     // Re-configure flag for OV7670
    );
    
    // Create an instance of a SCCB interface
    I2C_Interface u_I2C_Interface(
        .clk(clk),                          // 50Mhz clock signal
        .taken(taken),                      // Flag to advance to next register
        .siod(siod),                        // Clock signal for SCCB interface
        .sioc(sioc),                        // Data signal for SCCB interface 
        .send(send),                        // Continue to configure OV7670
        .rega(command[15:8]),               // Register address
        .value(command[7:0])                // Data to write into register
    );
    
endmodule
`endif