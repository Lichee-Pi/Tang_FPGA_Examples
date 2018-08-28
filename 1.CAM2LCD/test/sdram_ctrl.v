module sys_sdram (
    input wire clk,
    input wire rst_n,
    input wire i_valid,
    output reg o_ready,
    input wire [31:0] i_addr,
    input wire [15:0] i_wdata,
    input wire [3:0] i_wstrb,
    output reg [15:0] o_rdata
);

parameter CLK_CYCLE_NS = 20;
parameter POWERON_DELAY_NS = 200000;
parameter REFRESH_INTERVAL_NS = 15000;
parameter T_RC = 3+1;
parameter T_RP = 1+1;
parameter T_WR = 2+1;
parameter T_MRD = 2+1;
parameter T_RFC = 3+1;
parameter T_RCD = 1+1;
parameter T_RRD = 1+1;
parameter CL = 3+1;

reg sdram_ras_n;
reg sdram_cas_n;
reg sdram_we_n;
reg [10:0] sdram_addr;
reg [1:0] sdram_ba;

wire [15:0] sdram_dq;
reg [15:0] sdram_dq_r;
reg sdram_dq_ie;
assign sdram_dq = sdram_dq_ie ? sdram_dq_r : 'hz;

reg sdram_cs_n;
reg [3:0] sdram_dm;
reg sdram_cke;

/*
*/
EG_PHY_SDRAM_2M_32 sdr_sdram(
    .clk(clk),
    .ras_n(sdram_ras_n),
    .cas_n(sdram_cas_n),
    .we_n(sdram_we_n),
    .addr(sdram_addr),
    .ba(sdram_ba),
    .dq(sdram_dq),
    .cs_n(sdram_cs_n),
    .dm0(sdram_dm[0]),
    .dm1(sdram_dm[1]),
    .dm2(1'b1),
    .dm3(1'b1),
    .cke(sdram_cke)
);

reg [31:0] counter;
reg [31:0] counter_refresh;
// 0: power up wait
// 1: power up precharge all banks
// 2: power up auto refresh 2 times
// 3: power up set mode
// 4: idle
// 5: refresh
// 6: reada
// 7: writea
reg [4:0] stage;

always @ (posedge clk) begin
    if (!rst_n) begin
        counter <= 0;
        counter_refresh <= 0;
        stage <= 0;
    end
    if (rst_n) begin
        counter_refresh <= counter_refresh + 1;
        if (stage == 'h0) begin
            // nop
            sdram_cke <= 1;
            sdram_cs_n <= 0;
            sdram_ras_n <= 1;
            sdram_cas_n <= 1;
            sdram_we_n <= 1;

            sdram_dm <= 4'b1;
            // wait for 200us
            if (counter < POWERON_DELAY_NS/CLK_CYCLE_NS) begin
                counter <= counter + 1;
            end else begin
                counter <= 0;
                // nop
                sdram_cke <= 1;
                sdram_cs_n <= 0;
                sdram_ras_n <= 1;
                sdram_cas_n <= 1;
                sdram_we_n <= 1;
                // next stage
                stage <= 1;
            end
        end
        if (stage == 'h1) begin
            if (counter == 0) begin
                // precharge all
                sdram_cke <= 1;
                sdram_addr[10] <= 1;
                sdram_cs_n <= 0;
                sdram_ras_n <= 0;
                sdram_cas_n <= 1;
                sdram_we_n <= 0;
            end else begin
                // nop
                sdram_cke <= 1;
                sdram_cs_n <= 0;
                sdram_ras_n <= 1;
                sdram_cas_n <= 1;
                sdram_we_n <= 1;
            end
            if (counter < T_RP) begin
                counter <= counter + 1;
            end else begin
                counter <= 0;
                // nop
                sdram_cke <= 1;
                sdram_cs_n <= 0;
                sdram_ras_n <= 1;
                sdram_cas_n <= 1;
                sdram_we_n <= 1;
                // next stage
                stage <= 2;
            end
        end
        if (stage == 'h2) begin
            if (counter == 0) begin
                // auto refresh
                sdram_cke <= 1;
                sdram_cs_n <= 0;
                sdram_ras_n <= 0;
                sdram_cas_n <= 0;
                sdram_we_n <= 1;
            end else if (counter == T_RFC) begin
                // auto refresh
                sdram_cke <= 1;
                sdram_cs_n <= 0;
                sdram_ras_n <= 0;
                sdram_cas_n <= 0;
                sdram_we_n <= 1;
            end else begin
                // nop
                sdram_cke <= 1;
                sdram_cs_n <= 0;
                sdram_ras_n <= 1;
                sdram_cas_n <= 1;
                sdram_we_n <= 1;
            end
            if (counter < T_RFC*2) begin
                counter <= counter + 1;
            end else begin
                counter <= 0;
                // nop
                sdram_cke <= 1;
                sdram_cs_n <= 0;
                sdram_ras_n <= 1;
                sdram_cas_n <= 1;
                sdram_we_n <= 1;
                // next stage
                stage <= 3;
            end
        end
        if (stage == 'h3) begin
            if (counter == 0) begin
                // Mode Register Set
                sdram_cke <= 1;
                sdram_cs_n <= 0;
                sdram_ras_n <= 0;
                sdram_cas_n <= 0;
                sdram_we_n <= 0;

                // reserved
                sdram_ba <= 2'b00;
                sdram_addr[10] <= 1'b0;
                // Write Burst Length: Single Bit
                sdram_addr[9] <= 1;
                // Test Mode: Normal
                sdram_addr[8:7] <= 2'b00;
                // CAS Latency: 3
                sdram_addr[6:4] <= 3'b011;
                // Burst Type: Sequential
                sdram_addr[3] <= 1'b0;
                // Burst Length: 1
                sdram_addr[2:0] <= 3'b000;
            end else begin
                // nop
                sdram_cke <= 1;
                sdram_cs_n <= 0;
                sdram_ras_n <= 1;
                sdram_cas_n <= 1;
                sdram_we_n <= 1;
            end
            if (counter < T_MRD) begin
                counter <= counter + 1;
            end else begin
                counter <= 0;
                counter_refresh <= 0;
                // nop
                sdram_cke <= 1;
                sdram_cs_n <= 0;
                sdram_ras_n <= 1;
                sdram_cas_n <= 1;
                sdram_we_n <= 1;
                // next stage
                stage <= 4;
            end
        end
        if (stage == 'h4) begin
            if (counter_refresh > REFRESH_INTERVAL_NS/CLK_CYCLE_NS) begin
                // goto refresh
                counter <= 0;
                counter_refresh <= 0;
                // nop
                sdram_cke <= 1;
                sdram_cs_n <= 0;
                sdram_ras_n <= 1;
                sdram_cas_n <= 1;
                sdram_we_n <= 1;
                // next stage
                stage <= 5;
            end else if (i_valid) begin
                if (i_wstrb == 'h0) begin
                    // goto read
                    counter <= 0;
                    // nop
                    sdram_cke <= 1;
                    sdram_cs_n <= 0;
                    sdram_ras_n <= 1;
                    sdram_cas_n <= 1;
                    sdram_we_n <= 1;
                    // next stage
                    stage <= 6;
                end else begin
                    // goto write
                    counter <= 0;
                    // nop
                    sdram_cke <= 1;
                    sdram_cs_n <= 0;
                    sdram_ras_n <= 1;
                    sdram_cas_n <= 1;
                    sdram_we_n <= 1;
                    // next stage
                    stage <= 7;
                end
            end else begin
                // nop
                sdram_cke <= 1;
                sdram_cs_n <= 0;
                sdram_ras_n <= 1;
                sdram_cas_n <= 1;
                sdram_we_n <= 1;
            end
        end
        if (stage == 'h5) begin
            if (counter == 0) begin
                // PrechargeAll
                sdram_cke <= 1;
                sdram_addr[10] <= 1;
                sdram_cs_n <= 0;
                sdram_ras_n <= 0;
                sdram_cas_n <= 1;
                sdram_we_n <= 0;

                sdram_dm <= 4'b0;
            end else if (counter == T_RP) begin
                // AutoRefresh
                sdram_cke <= 1;
                sdram_cs_n <= 0;
                sdram_ras_n <= 0;
                sdram_cas_n <= 0;
                sdram_we_n <= 1;
            end else begin
                // nop
                sdram_cke <= 1;
                sdram_cs_n <= 0;
                sdram_ras_n <= 1;
                sdram_cas_n <= 1;
                sdram_we_n <= 1;
            end
            if (counter < T_RP+T_RFC) begin
                counter <= counter + 1;
            end else begin
                counter <= 0;
                // nop
                sdram_cke <= 1;
                sdram_cs_n <= 0;
                sdram_ras_n <= 1;
                sdram_cas_n <= 1;
                sdram_we_n <= 1;
                // next stage
                stage <= 4;
            end
        end
        if (stage == 'h6) begin
            if (counter == 0) begin
                // BankActivate
                sdram_cke <= 1;
                sdram_ba <= i_addr[3:2];
                sdram_addr <= i_addr[22:12];
                sdram_cs_n <= 0;
                sdram_ras_n <= 0;
                sdram_cas_n <= 1;
                sdram_we_n <= 1;

                sdram_dm <= 4'b0;
            end else if (counter == T_RCD) begin
                // Read and Autoprecharge
                sdram_cke <= 1;
                sdram_dm <= 4'b0;
                sdram_ba <= i_addr[3:2];
                sdram_addr[10] <= 1;
                sdram_addr[7:0] <= i_addr[11:4];
                sdram_cs_n <= 0;
                sdram_ras_n <= 1;
                sdram_cas_n <= 0;
                sdram_we_n <= 1;

                sdram_dq_ie <= 0;
            end else if (counter == T_RCD+CL) begin
                // read complete
                o_rdata <= sdram_dq;
                o_ready <= 1;
            end else begin
                o_ready <= 0;
                // nop
                sdram_cke <= 1;
                sdram_cs_n <= 0;
                sdram_ras_n <= 1;
                sdram_cas_n <= 1;
                sdram_we_n <= 1;
            end
            if (counter < T_RCD+CL+T_RP) begin
                counter <= counter + 1;
            end else begin
                counter <= 0;
                // nop
                sdram_cke <= 1;
                sdram_cs_n <= 0;
                sdram_ras_n <= 1;
                sdram_cas_n <= 1;
                sdram_we_n <= 1;
                // next stage
                stage <= 4;
            end
        end
        if (stage == 'h7) begin
            if (counter == 0) begin
                // BankActivate
                sdram_cke <= 1;
                sdram_ba <= i_addr[3:2];
                sdram_addr <= i_addr[22:12];
                sdram_cs_n <= 0;
                sdram_ras_n <= 0;
                sdram_cas_n <= 1;
                sdram_we_n <= 1;

                sdram_dm <= ~i_wstrb;
            end else if (counter == T_RCD) begin
                // Write and Autoprecharge
                sdram_cke <= 1;
                sdram_dm <= ~i_wstrb;
                sdram_ba <= i_addr[3:2];
                sdram_addr[10] <= 1;
                sdram_addr[7:0] <= i_addr[11:4];
                sdram_cs_n <= 0;
                sdram_ras_n <= 1;
                sdram_cas_n <= 0;
                sdram_we_n <= 0;

                sdram_dq_ie <= 1;
                sdram_dq_r <= i_wdata;
                o_ready <= 1;
            end else begin
                o_ready <= 0;
                // nop
                sdram_cke <= 1;
                sdram_cs_n <= 0;
                sdram_ras_n <= 1;
                sdram_cas_n <= 1;
                sdram_we_n <= 1;
            end
            if (counter < T_RCD+T_WR+T_RP) begin
                counter <= counter + 1;
            end else begin
                counter <= 0;
                // nop
                sdram_cke <= 1;
                sdram_cs_n <= 0;
                sdram_ras_n <= 1;
                sdram_cas_n <= 1;
                sdram_we_n <= 1;
                // next stage
                stage <= 4;
            end
        end
    end
end

endmodule