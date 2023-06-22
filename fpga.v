/*

Copyright (c) 2020-2021 Alex Forencich

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

*/

// Language: Verilog 2001

`resetall
`timescale 1ns / 1ps
`default_nettype none

/*
 * FPGA top-level module
 */
module fpga (
    /*
     * Clock: 125MHz LVDS
     * Reset: Push button, active low
     */
    input  wire       clk_125mhz, 
    input  wire       rst_125mhz,
    
    
    // udp parameters
    input wire [47:0] sfp0_local_mac_user,
    input wire [31:0] sfp0_local_ip_user,
    input wire [31:0] sfp0_server_ip_user,
    input wire [31:0] sfp0_gateway_ip_user,
    input wire [31:0] sfp0_subnet_mask_user,
    input wire [15:0] sfp0_udp_port_user,
    input wire [15:0] sfp0_udp_length_user, // 1032
    input wire        sfp0_udp_hdr_valid_user,
    
       // udp parameters
    input wire [47:0] sfp1_local_mac_user,
    input wire [31:0] sfp1_local_ip_user,
    input wire [31:0] sfp1_server_ip_user,
    input wire [31:0] sfp1_gateway_ip_user,
    input wire [31:0] sfp1_subnet_mask_user,
    input wire [15:0] sfp1_udp_port_user,
    input wire [15:0] sfp1_udp_length_user, // 1032
    input wire        sfp1_udp_hdr_valid_user,
    
    
       // udp parameters
    input wire [47:0] sfp2_local_mac_user,
    input wire [31:0] sfp2_local_ip_user,
    input wire [31:0] sfp2_server_ip_user,
    input wire [31:0] sfp2_gateway_ip_user,
    input wire [31:0] sfp2_subnet_mask_user,
    input wire [15:0] sfp2_udp_port_user,
    input wire [15:0] sfp2_udp_length_user, // 1032
    input wire        sfp2_udp_hdr_valid_user,
    
    
       // udp parameters
    input wire [47:0] sfp3_local_mac_user,
    input wire [31:0] sfp3_local_ip_user,
    input wire [31:0] sfp3_server_ip_user,
    input wire [31:0] sfp3_gateway_ip_user,
    input wire [31:0] sfp3_subnet_mask_user,
    input wire [15:0] sfp3_udp_port_user,
    input wire [15:0] sfp3_udp_length_user, // 1032
    input wire        sfp3_udp_hdr_valid_user,
    
    /*
     * Ethernet: SFP+
     */
    input  wire       sfp0_rx_p,
    input  wire       sfp0_rx_n,
    output wire       sfp0_tx_p,
    output wire       sfp0_tx_n,
    input  wire       sfp1_rx_p,
    input  wire       sfp1_rx_n,
    output wire       sfp1_tx_p,
    output wire       sfp1_tx_n,
    input  wire       sfp2_rx_p,
    input  wire       sfp2_rx_n,
    output wire       sfp2_tx_p,
    output wire       sfp2_tx_n,
    input  wire       sfp3_rx_p,
    input  wire       sfp3_rx_n,
    output wire       sfp3_tx_p,
    output wire       sfp3_tx_n,
    input  wire       sfp_mgt_refclk_0_p,
    input  wire       sfp_mgt_refclk_0_n,
    output wire       sfp0_tx_disable_b,
    output wire       sfp1_tx_disable_b,
    output wire       sfp2_tx_disable_b,
    output wire       sfp3_tx_disable_b,
   
   
    input wire [63:0] sfp0_tx_fifo_udp_payload_axis_tdata,
    input wire [7:0] sfp0_tx_fifo_udp_payload_axis_tkeep,
    input wire sfp0_tx_fifo_udp_payload_axis_tvalid,
    output wire sfp0_tx_fifo_udp_payload_axis_tready,
    input wire sfp0_tx_fifo_udp_payload_axis_tlast,
    input wire sfp0_tx_fifo_udp_payload_axis_tuser,
    
    input wire [63:0] sfp1_tx_fifo_udp_payload_axis_tdata,
    input wire [7:0] sfp1_tx_fifo_udp_payload_axis_tkeep,
    input wire sfp1_tx_fifo_udp_payload_axis_tvalid,
    output wire sfp1_tx_fifo_udp_payload_axis_tready,
    input wire sfp1_tx_fifo_udp_payload_axis_tlast,
    input wire sfp1_tx_fifo_udp_payload_axis_tuser,
    
    input wire [63:0] sfp2_tx_fifo_udp_payload_axis_tdata,
    input wire [7:0] sfp2_tx_fifo_udp_payload_axis_tkeep,
    input wire sfp2_tx_fifo_udp_payload_axis_tvalid,
    output wire sfp2_tx_fifo_udp_payload_axis_tready,
    input wire sfp2_tx_fifo_udp_payload_axis_tlast,
    input wire sfp2_tx_fifo_udp_payload_axis_tuser,
    
    input wire [63:0] sfp3_tx_fifo_udp_payload_axis_tdata,
    input wire [7:0] sfp3_tx_fifo_udp_payload_axis_tkeep,
    input wire sfp3_tx_fifo_udp_payload_axis_tvalid,
    output wire sfp3_tx_fifo_udp_payload_axis_tready,
    input wire sfp3_tx_fifo_udp_payload_axis_tlast,
    input wire sfp3_tx_fifo_udp_payload_axis_tuser,
    
    
    output wire fifo_clk_156mhz_sfp0,
    output wire fifo_clk_rst_156mhz_sfp0,
    output wire fifo_clk_156mhz_sfp1,
    output wire fifo_clk_rst_156mhz_sfp1
);

// Clock and reset

wire clk_125mhz_ibufg;
wire clk_125mhz_bufg;

// Internal 125 MHz clock
wire clk_125mhz_int;
wire rst_125mhz_int;

// Internal 156.25 MHz clock
wire clk_156mhz_int_sfp0;
wire rst_156mhz_int_sfp0;

wire clk_156mhz_int_sfp1;
wire rst_156mhz_int_sfp1;

wire clk_156mhz_int_sfp2;
wire rst_156mhz_int_sfp2;

wire clk_156mhz_int_sfp2;
wire rst_156mhz_int_sfp2;

wire clk_156mhz_int_sfp3;
wire rst_156mhz_int_sfp3;


wire [63:0] sfp0_rx_fifo_udp_payload_axis_tdata;
wire [7:0] sfp0_rx_fifo_udp_payload_axis_tkeep;
wire sfp0_rx_fifo_udp_payload_axis_tvalid;
wire sfp0_rx_fifo_udp_payload_axis_tready;
wire sfp0_rx_fifo_udp_payload_axis_tlast;
wire sfp0_rx_fifo_udp_payload_axis_tuser;

wire [63:0] sfp1_rx_fifo_udp_payload_axis_tdata;
wire [7:0] sfp1_rx_fifo_udp_payload_axis_tkeep;
wire sfp1_rx_fifo_udp_payload_axis_tvalid;
wire sfp1_rx_fifo_udp_payload_axis_tready;
wire sfp1_rx_fifo_udp_payload_axis_tlast;
wire sfp1_rx_fifo_udp_payload_axis_tuser;


wire [63:0] sfp2_rx_fifo_udp_payload_axis_tdata;
wire [7:0] sfp2_rx_fifo_udp_payload_axis_tkeep;
wire sfp2_rx_fifo_udp_payload_axis_tvalid;
wire sfp2_rx_fifo_udp_payload_axis_tready;
wire sfp2_rx_fifo_udp_payload_axis_tlast;
wire sfp2_rx_fifo_udp_payload_axis_tuser;


wire [63:0] sfp3_rx_fifo_udp_payload_axis_tdata;
wire [7:0] sfp3_rx_fifo_udp_payload_axis_tkeep;
wire sfp3_rx_fifo_udp_payload_axis_tvalid;
wire sfp3_rx_fifo_udp_payload_axis_tready;
wire sfp3_rx_fifo_udp_payload_axis_tlast;
wire sfp3_rx_fifo_udp_payload_axis_tuser;




// XGMII 10G PHY
assign sfp0_tx_disable_b = 1'b1;
assign sfp1_tx_disable_b = 1'b1;
assign sfp2_tx_disable_b = 1'b1;
assign sfp3_tx_disable_b = 1'b1;

wire        sfp0_tx_clk_int;
wire        sfp0_tx_rst_int;
wire [63:0] sfp0_txd_int;
wire [7:0]  sfp0_txc_int;
wire        sfp0_rx_clk_int;
wire        sfp0_rx_rst_int;
wire [63:0] sfp0_rxd_int;
wire [7:0]  sfp0_rxc_int;

wire        sfp1_tx_clk_int;
wire        sfp1_tx_rst_int;
wire [63:0] sfp1_txd_int;
wire [7:0]  sfp1_txc_int;
wire        sfp1_rx_clk_int;
wire        sfp1_rx_rst_int;
wire [63:0] sfp1_rxd_int;
wire [7:0]  sfp1_rxc_int;

wire        sfp2_tx_clk_int;
wire        sfp2_tx_rst_int;
wire [63:0] sfp2_txd_int;
wire [7:0]  sfp2_txc_int;
wire        sfp2_rx_clk_int;
wire        sfp2_rx_rst_int;
wire [63:0] sfp2_rxd_int;
wire [7:0]  sfp2_rxc_int;

wire        sfp3_tx_clk_int;
wire        sfp3_tx_rst_int;
wire [63:0] sfp3_txd_int;
wire [7:0]  sfp3_txc_int;
wire        sfp3_rx_clk_int;
wire        sfp3_rx_rst_int;
wire [63:0] sfp3_rxd_int;
wire [7:0]  sfp3_rxc_int;

assign clk_156mhz_int_sfp0 = sfp0_tx_clk_int;
assign rst_156mhz_int_sfp0 = sfp0_tx_rst_int;

assign clk_156mhz_int_sfp1 = sfp1_tx_clk_int;
assign rst_156mhz_int_sfp1 = sfp1_tx_rst_int;

assign clk_156mhz_int_sfp2 = sfp2_tx_clk_int;
assign rst_156mhz_int_sfp2 = sfp2_tx_rst_int;

assign clk_156mhz_int_sfp3 = sfp3_tx_clk_int;
assign rst_156mhz_int_sfp3 = sfp3_tx_rst_int;


assign clk_125mhz_int=clk_125mhz;
assign rst_125mhz_int=rst_125mhz;

wire sfp0_rx_block_lock;
wire sfp1_rx_block_lock;
wire sfp2_rx_block_lock;
wire sfp3_rx_block_lock;

wire sfp_mgt_refclk_0;

IBUFDS_GTE4 ibufds_gte4_sfp_mgt_refclk_0_inst (
    .I     (sfp_mgt_refclk_0_p),
    .IB    (sfp_mgt_refclk_0_n),
    .CEB   (1'b0),
    .O     (sfp_mgt_refclk_0),
    .ODIV2 ()
);

wire sfp_qpll0lock;
wire sfp_qpll0outclk;
wire sfp_qpll0outrefclk;

eth_xcvr_phy_wrapper #(
    .HAS_COMMON(1)
)
sfp0_phy_inst (
    .xcvr_ctrl_clk(clk_125mhz_int),
    .xcvr_ctrl_rst(rst_125mhz_int),

    // Common
    .xcvr_gtpowergood_out(),

    // PLL out
    .xcvr_gtrefclk00_in(sfp_mgt_refclk_0),
    .xcvr_qpll0lock_out(sfp_qpll0lock),
    .xcvr_qpll0outclk_out(sfp_qpll0outclk),
    .xcvr_qpll0outrefclk_out(sfp_qpll0outrefclk),

    // PLL in
    .xcvr_qpll0lock_in(1'b0),
    .xcvr_qpll0reset_out(),
    .xcvr_qpll0clk_in(1'b0),
    .xcvr_qpll0refclk_in(1'b0),

    // Serial data
    .xcvr_txp(sfp0_tx_p),
    .xcvr_txn(sfp0_tx_n),
    .xcvr_rxp(sfp0_rx_p),
    .xcvr_rxn(sfp0_rx_n),

    // PHY connections
    .phy_tx_clk(sfp0_tx_clk_int),
    .phy_tx_rst(sfp0_tx_rst_int),
    .phy_xgmii_txd(sfp0_txd_int),
    .phy_xgmii_txc(sfp0_txc_int),
    .phy_rx_clk(sfp0_rx_clk_int),
    .phy_rx_rst(sfp0_rx_rst_int),
    .phy_xgmii_rxd(sfp0_rxd_int),
    .phy_xgmii_rxc(sfp0_rxc_int),
    .phy_tx_bad_block(),
    .phy_rx_error_count(),
    .phy_rx_bad_block(),
    .phy_rx_sequence_error(),
    .phy_rx_block_lock(sfp0_rx_block_lock),
    .phy_rx_high_ber(),
    .phy_tx_prbs31_enable(),
    .phy_rx_prbs31_enable()
);

eth_xcvr_phy_wrapper #(
    .HAS_COMMON(0)
)
sfp1_phy_inst (
    .xcvr_ctrl_clk(clk_125mhz_int),
    .xcvr_ctrl_rst(rst_125mhz_int),

    // Common
    .xcvr_gtpowergood_out(),

    // PLL out
    .xcvr_gtrefclk00_in(1'b0),
    .xcvr_qpll0lock_out(),
    .xcvr_qpll0outclk_out(),
    .xcvr_qpll0outrefclk_out(),

    // PLL in
    .xcvr_qpll0lock_in(sfp_qpll0lock),
    .xcvr_qpll0reset_out(),
    .xcvr_qpll0clk_in(sfp_qpll0outclk),
    .xcvr_qpll0refclk_in(sfp_qpll0outrefclk),

    // Serial data
    .xcvr_txp(sfp1_tx_p),
    .xcvr_txn(sfp1_tx_n),
    .xcvr_rxp(sfp1_rx_p),
    .xcvr_rxn(sfp1_rx_n),

    // PHY connections
    .phy_tx_clk(sfp1_tx_clk_int),
    .phy_tx_rst(sfp1_tx_rst_int),
    .phy_xgmii_txd(sfp1_txd_int),
    .phy_xgmii_txc(sfp1_txc_int),
    .phy_rx_clk(sfp1_rx_clk_int),
    .phy_rx_rst(sfp1_rx_rst_int),
    .phy_xgmii_rxd(sfp1_rxd_int),
    .phy_xgmii_rxc(sfp1_rxc_int),
    .phy_tx_bad_block(),
    .phy_rx_error_count(),
    .phy_rx_bad_block(),
    .phy_rx_sequence_error(),
    .phy_rx_block_lock(sfp1_rx_block_lock),
    .phy_rx_high_ber(),
    .phy_tx_prbs31_enable(),
    .phy_rx_prbs31_enable()
);

eth_xcvr_phy_wrapper #(
    .HAS_COMMON(0)
)
sfp2_phy_inst (
    .xcvr_ctrl_clk(clk_125mhz_int),
    .xcvr_ctrl_rst(rst_125mhz_int),

    // Common
    .xcvr_gtpowergood_out(),

    // PLL out
    .xcvr_gtrefclk00_in(1'b0),
    .xcvr_qpll0lock_out(),
    .xcvr_qpll0outclk_out(),
    .xcvr_qpll0outrefclk_out(),

    // PLL in
    .xcvr_qpll0lock_in(sfp_qpll0lock),
    .xcvr_qpll0reset_out(),
    .xcvr_qpll0clk_in(sfp_qpll0outclk),
    .xcvr_qpll0refclk_in(sfp_qpll0outrefclk),

    // Serial data
    .xcvr_txp(sfp2_tx_p),
    .xcvr_txn(sfp2_tx_n),
    .xcvr_rxp(sfp2_rx_p),
    .xcvr_rxn(sfp2_rx_n),

    // PHY connections
    .phy_tx_clk(sfp2_tx_clk_int),
    .phy_tx_rst(sfp2_tx_rst_int),
    .phy_xgmii_txd(sfp2_txd_int),
    .phy_xgmii_txc(sfp2_txc_int),
    .phy_rx_clk(sfp2_rx_clk_int),
    .phy_rx_rst(sfp2_rx_rst_int),
    .phy_xgmii_rxd(sfp2_rxd_int),
    .phy_xgmii_rxc(sfp2_rxc_int),
    .phy_tx_bad_block(),
    .phy_rx_error_count(),
    .phy_rx_bad_block(),
    .phy_rx_sequence_error(),
    .phy_rx_block_lock(sfp2_rx_block_lock),
    .phy_rx_high_ber(),
    .phy_tx_prbs31_enable(),
    .phy_rx_prbs31_enable()
);

eth_xcvr_phy_wrapper #(
    .HAS_COMMON(0)
)
sfp3_phy_inst (
    .xcvr_ctrl_clk(clk_125mhz_int),
    .xcvr_ctrl_rst(rst_125mhz_int),

    // Common
    .xcvr_gtpowergood_out(),

    // PLL out
    .xcvr_gtrefclk00_in(1'b0),
    .xcvr_qpll0lock_out(),
    .xcvr_qpll0outclk_out(),
    .xcvr_qpll0outrefclk_out(),

    // PLL in
    .xcvr_qpll0lock_in(sfp_qpll0lock),
    .xcvr_qpll0reset_out(),
    .xcvr_qpll0clk_in(sfp_qpll0outclk),
    .xcvr_qpll0refclk_in(sfp_qpll0outrefclk),

    // Serial data
    .xcvr_txp(sfp3_tx_p),
    .xcvr_txn(sfp3_tx_n),
    .xcvr_rxp(sfp3_rx_p),
    .xcvr_rxn(sfp3_rx_n),

    // PHY connections
    .phy_tx_clk(sfp3_tx_clk_int),
    .phy_tx_rst(sfp3_tx_rst_int),
    .phy_xgmii_txd(sfp3_txd_int),
    .phy_xgmii_txc(sfp3_txc_int),
    .phy_rx_clk(sfp3_rx_clk_int),
    .phy_rx_rst(sfp3_rx_rst_int),
    .phy_xgmii_rxd(sfp3_rxd_int),
    .phy_xgmii_rxc(sfp3_rxc_int),
    .phy_tx_bad_block(),
    .phy_rx_error_count(),
    .phy_rx_bad_block(),
    .phy_rx_sequence_error(),
    .phy_rx_block_lock(sfp3_rx_block_lock),
    .phy_rx_high_ber(),
    .phy_tx_prbs31_enable(),
    .phy_rx_prbs31_enable()
);

fpga_core
sfp0_core_inst (
    /*
     * Clock: 156.25 MHz
     * Synchronous reset
     */
    .clk(clk_156mhz_int_sfp0),
    .rst(rst_156mhz_int_sfp0),

    .local_mac_user(sfp0_local_mac_user),
    .local_ip_user(sfp0_local_ip_user),
    .server_ip_user(sfp0_server_ip_user),
    .gateway_ip_user(sfp0_gateway_ip_user),
    .subnet_mask_user(sfp0_subnet_mask_user),
    .udp_port_user(sfp0_udp_port_user),
    .udp_length_user(sfp0_udp_length_user), // 1032
    .udp_hdr_valid_user(sfp0_udp_hdr_valid_user),
    /*
     * Ethernet: SFP+
     */
    .sfp_tx_clk(sfp0_tx_clk_int),
    .sfp_tx_rst(sfp0_tx_rst_int),
    .sfp_txd(sfp0_txd_int),
    .sfp_txc(sfp0_txc_int),
    .sfp_rx_clk(sfp0_rx_clk_int),
    .sfp_rx_rst(sfp0_rx_rst_int),
    .sfp_rxd(sfp0_rxd_int),
    .sfp_rxc(sfp0_rxc_int),
 
    .rx_fifo_udp_payload_axis_tdata(sfp0_rx_fifo_udp_payload_axis_tdata),
    .rx_fifo_udp_payload_axis_tkeep(sfp0_rx_fifo_udp_payload_axis_tkeep),
    .rx_fifo_udp_payload_axis_tvalid(sfp0_rx_fifo_udp_payload_axis_tvalid),
    .rx_fifo_udp_payload_axis_tready(sfp0_rx_fifo_udp_payload_axis_tready),
    .rx_fifo_udp_payload_axis_tlast(sfp0_rx_fifo_udp_payload_axis_tlast),
    .rx_fifo_udp_payload_axis_tuser(sfp0_rx_fifo_udp_payload_axis_tuser),
    
    .tx_fifo_udp_payload_axis_tdata(sfp0_tx_fifo_udp_payload_axis_tdata),
    .tx_fifo_udp_payload_axis_tkeep(sfp0_tx_fifo_udp_payload_axis_tkeep),
    .tx_fifo_udp_payload_axis_tvalid(sfp0_tx_fifo_udp_payload_axis_tvalid),
    .tx_fifo_udp_payload_axis_tready(sfp0_tx_fifo_udp_payload_axis_tready),
    .tx_fifo_udp_payload_axis_tlast(sfp0_tx_fifo_udp_payload_axis_tlast),
    .tx_fifo_udp_payload_axis_tuser(sfp0_tx_fifo_udp_payload_axis_tuser)
);



fpga_core
sfp1_core_inst (
    /*
     * Clock: 156.25 MHz
     * Synchronous reset
     */
    .clk(clk_156mhz_int_sfp1),
    .rst(rst_156mhz_int_sfp1),

    .local_mac_user(sfp1_local_mac_user),
    .local_ip_user(sfp1_local_ip_user),
    .server_ip_user(sfp1_server_ip_user),
    .gateway_ip_user(sfp1_gateway_ip_user),
    .subnet_mask_user(sfp1_subnet_mask_user),
    .udp_port_user(sfp1_udp_port_user),
    .udp_length_user(sfp1_udp_length_user), // 1032
    .udp_hdr_valid_user(sfp1_udp_hdr_valid_user),
    /*
     * Ethernet: SFP+
     */
    .sfp_tx_clk(sfp1_tx_clk_int),
    .sfp_tx_rst(sfp1_tx_rst_int),
    .sfp_txd(sfp1_txd_int),
    .sfp_txc(sfp1_txc_int),
    .sfp_rx_clk(sfp1_rx_clk_int),
    .sfp_rx_rst(sfp1_rx_rst_int),
    .sfp_rxd(sfp1_rxd_int),
    .sfp_rxc(sfp1_rxc_int),
 
    .rx_fifo_udp_payload_axis_tdata(sfp1_rx_fifo_udp_payload_axis_tdata),
    .rx_fifo_udp_payload_axis_tkeep(sfp1_rx_fifo_udp_payload_axis_tkeep),
    .rx_fifo_udp_payload_axis_tvalid(sfp1_rx_fifo_udp_payload_axis_tvalid),
    .rx_fifo_udp_payload_axis_tready(sfp1_rx_fifo_udp_payload_axis_tready),
    .rx_fifo_udp_payload_axis_tlast(sfp1_rx_fifo_udp_payload_axis_tlast),
    .rx_fifo_udp_payload_axis_tuser(sfp1_rx_fifo_udp_payload_axis_tuser),
    
    .tx_fifo_udp_payload_axis_tdata(sfp1_tx_fifo_udp_payload_axis_tdata),
    .tx_fifo_udp_payload_axis_tkeep(sfp1_tx_fifo_udp_payload_axis_tkeep),
    .tx_fifo_udp_payload_axis_tvalid(sfp1_tx_fifo_udp_payload_axis_tvalid),
    .tx_fifo_udp_payload_axis_tready(sfp1_tx_fifo_udp_payload_axis_tready),
    .tx_fifo_udp_payload_axis_tlast(sfp1_tx_fifo_udp_payload_axis_tlast),
    .tx_fifo_udp_payload_axis_tuser(sfp1_tx_fifo_udp_payload_axis_tuser)
);


fpga_core
sfp2_core_inst (
    /*
     * Clock: 156.25 MHz
     * Synchronous reset
     */
    .clk(clk_156mhz_int_sfp2),
    .rst(rst_156mhz_int_sfp2),

    .local_mac_user(sfp2_local_mac_user),
    .local_ip_user(sfp2_local_ip_user),
    .server_ip_user(sfp2_server_ip_user),
    .gateway_ip_user(sfp2_gateway_ip_user),
    .subnet_mask_user(sfp2_subnet_mask_user),
    .udp_port_user(sfp2_udp_port_user),
    .udp_length_user(sfp2_udp_length_user), // 1032
    .udp_hdr_valid_user(sfp2_udp_hdr_valid_user),
    /*
     * Ethernet: SFP+
     */
    .sfp_tx_clk(sfp2_tx_clk_int),
    .sfp_tx_rst(sfp2_tx_rst_int),
    .sfp_txd(sfp2_txd_int),
    .sfp_txc(sfp2_txc_int),
    .sfp_rx_clk(sfp2_rx_clk_int),
    .sfp_rx_rst(sfp2_rx_rst_int),
    .sfp_rxd(sfp2_rxd_int),
    .sfp_rxc(sfp2_rxc_int),
 
    .rx_fifo_udp_payload_axis_tdata(sfp2_rx_fifo_udp_payload_axis_tdata),
    .rx_fifo_udp_payload_axis_tkeep(sfp2_rx_fifo_udp_payload_axis_tkeep),
    .rx_fifo_udp_payload_axis_tvalid(sfp2_rx_fifo_udp_payload_axis_tvalid),
    .rx_fifo_udp_payload_axis_tready(sfp2_rx_fifo_udp_payload_axis_tready),
    .rx_fifo_udp_payload_axis_tlast(sfp2_rx_fifo_udp_payload_axis_tlast),
    .rx_fifo_udp_payload_axis_tuser(sfp2_rx_fifo_udp_payload_axis_tuser),
    
    .tx_fifo_udp_payload_axis_tdata(sfp2_tx_fifo_udp_payload_axis_tdata),
    .tx_fifo_udp_payload_axis_tkeep(sfp2_tx_fifo_udp_payload_axis_tkeep),
    .tx_fifo_udp_payload_axis_tvalid(sfp2_tx_fifo_udp_payload_axis_tvalid),
    .tx_fifo_udp_payload_axis_tready(sfp2_tx_fifo_udp_payload_axis_tready),
    .tx_fifo_udp_payload_axis_tlast(sfp2_tx_fifo_udp_payload_axis_tlast),
    .tx_fifo_udp_payload_axis_tuser(sfp2_tx_fifo_udp_payload_axis_tuser)
);



fpga_core
sfp3_core_inst (
    /*
     * Clock: 156.25 MHz
     * Synchronous reset
     */
    .clk(clk_156mhz_int_sfp3),
    .rst(rst_156mhz_int_sfp3),

    .local_mac_user(sfp3_local_mac_user),
    .local_ip_user(sfp3_local_ip_user),
    .server_ip_user(sfp3_server_ip_user),
    .gateway_ip_user(sfp3_gateway_ip_user),
    .subnet_mask_user(sfp3_subnet_mask_user),
    .udp_port_user(sfp3_udp_port_user),
    .udp_length_user(sfp3_udp_length_user), // 1032
    .udp_hdr_valid_user(sfp3_udp_hdr_valid_user),
    /*
     * Ethernet: SFP+
     */
    .sfp_tx_clk(sfp3_tx_clk_int),
    .sfp_tx_rst(sfp3_tx_rst_int),
    .sfp_txd(sfp3_txd_int),
    .sfp_txc(sfp3_txc_int),
    .sfp_rx_clk(sfp3_rx_clk_int),
    .sfp_rx_rst(sfp3_rx_rst_int),
    .sfp_rxd(sfp3_rxd_int),
    .sfp_rxc(sfp3_rxc_int),
 
    .rx_fifo_udp_payload_axis_tdata(sfp3_rx_fifo_udp_payload_axis_tdata),
    .rx_fifo_udp_payload_axis_tkeep(sfp3_rx_fifo_udp_payload_axis_tkeep),
    .rx_fifo_udp_payload_axis_tvalid(sfp3_rx_fifo_udp_payload_axis_tvalid),
    .rx_fifo_udp_payload_axis_tready(sfp3_rx_fifo_udp_payload_axis_tready),
    .rx_fifo_udp_payload_axis_tlast(sfp3_rx_fifo_udp_payload_axis_tlast),
    .rx_fifo_udp_payload_axis_tuser(sfp3_rx_fifo_udp_payload_axis_tuser),
    
    .tx_fifo_udp_payload_axis_tdata(sfp3_tx_fifo_udp_payload_axis_tdata),
    .tx_fifo_udp_payload_axis_tkeep(sfp3_tx_fifo_udp_payload_axis_tkeep),
    .tx_fifo_udp_payload_axis_tvalid(sfp3_tx_fifo_udp_payload_axis_tvalid),
    .tx_fifo_udp_payload_axis_tready(sfp3_tx_fifo_udp_payload_axis_tready),
    .tx_fifo_udp_payload_axis_tlast(sfp3_tx_fifo_udp_payload_axis_tlast),
    .tx_fifo_udp_payload_axis_tuser(sfp3_tx_fifo_udp_payload_axis_tuser)
);

assign fifo_clk_156mhz_sfp0=clk_156mhz_int_sfp0;
assign fifo_clk_rst_156mhz_sfp0=rst_156mhz_int_sfp0;

assign fifo_clk_156mhz_sfp1=clk_156mhz_int_sfp1;
assign fifo_clk_rst_156mhz_sfp1=rst_156mhz_int_sfp1;

endmodule

`resetall
