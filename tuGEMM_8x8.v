//`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////
//// Company: 
//// Engineer: 
//// 
//// Create Date: 26.09.2024 07:20:03
//// Design Name: 
//// Module Name: tuGEMM_4
//// Project Name: 
//// Target Devices: 
//// Tool Versions: 
//// Description: 
//// 
//// Dependencies: 
//// 
//// Revision:
//// Revision 0.01 - File Created
//// Additional Comments:
//// 
////////////////////////////////////////////////////////////////////////////////////


//module tuGEMM_8x8(
//input clk,
//input rst,
//input [511:0] vector_a,
//input [511:0] vector_b,
//output wire signed [15:0] Row_00,
//output wire signed [15:0] Row_01,
//output wire signed [15:0] Row_02,
//output wire signed [15:0] Row_03,
//output wire signed [15:0] Row_04,
//output wire signed [15:0] Row_05,
//output wire signed [15:0] Row_06,
//output wire signed [15:0] Row_07,
//output wire signed [15:0] Row_10,
//output wire signed [15:0] Row_11,
//output wire signed [15:0] Row_12,
//output wire signed [15:0] Row_13,
//output wire signed [15:0] Row_14,
//output wire signed [15:0] Row_15,
//output wire signed [15:0] Row_16,
//output wire signed [15:0] Row_17,
//output wire signed [15:0] Row_20,
//output wire signed [15:0] Row_21,
//output wire signed [15:0] Row_22,
//output wire signed [15:0] Row_23,
//output wire signed [15:0] Row_24,
//output wire signed [15:0] Row_25,
//output wire signed [15:0] Row_26,
//output wire signed [15:0] Row_27,
//output wire signed [15:0] Row_30,
//output wire signed [15:0] Row_31,
//output wire signed [15:0] Row_32,
//output wire signed [15:0] Row_33,
//output wire signed [15:0] Row_34,
//output wire signed [15:0] Row_35,
//output wire signed [15:0] Row_36,
//output wire signed [15:0] Row_37,
//output wire signed [15:0] Row_40,
//output wire signed [15:0] Row_41,
//output wire signed [15:0] Row_42,
//output wire signed [15:0] Row_43,
//output wire signed [15:0] Row_44,
//output wire signed [15:0] Row_45,
//output wire signed [15:0] Row_46,
//output wire signed [15:0] Row_47,
//output wire signed [15:0] Row_50,
//output wire signed [15:0] Row_51,
//output wire signed [15:0] Row_52,
//output wire signed [15:0] Row_53,
//output wire signed [15:0] Row_54,
//output wire signed [15:0] Row_55,
//output wire signed [15:0] Row_56,
//output wire signed [15:0] Row_57,
//output wire signed [15:0] Row_60,
//output wire signed [15:0] Row_61,
//output wire signed [15:0] Row_62,
//output wire signed [15:0] Row_63,
//output wire signed [15:0] Row_64,
//output wire signed [15:0] Row_65,
//output wire signed [15:0] Row_66,
//output wire signed [15:0] Row_67,
//output wire signed [15:0] Row_70,
//output wire signed [15:0] Row_71,
//output wire signed [15:0] Row_72,
//output wire signed [15:0] Row_73,
//output wire signed [15:0] Row_74,
//output wire signed [15:0] Row_75,
//output wire signed [15:0] Row_76,
//output wire signed [15:0] Row_77
//    );
//integer i,j;
//integer k,l;
//integer m, n;
//integer o, p, t;

//// reg [7:0] store_A[15:0];
//// reg [7:0] store_B [15:0];

//    reg signed unary_col ;
//   reg signed unary_row ;
//   reg signed neg_row;
//   reg signed neg_col ;
//   wire signed xor_out ;
//   wire signed and_out;
//    reg signed [7:0] counta;
//    reg signed [7:0] countb;   // 8-bit counters
//    reg [7:0] index_a;            // Index for vector selection
//    reg [7:0] index_b;
//    reg [7:0] done_A;
//    reg [7:0] done_B;
//    reg [2:0] state;            // State variable
//     reg done;
//     reg signed [15:0] C00 [0:63];
//     reg signed [15:0] counter;
//    localparam IDLE     = 3'b00,  // IDLE state
//               LOAD     = 3'b01,  // Load state for vector values
//               COUNT_A  = 3'b10,  // Decrement/Increment counta state
//               COUNT_B  = 3'b11,  // Decrement/Increment countb state
//               CHANGE   = 3'b100;

//    // State machine
//    always @(posedge clk) begin
//        if (rst) begin
//        for (t = 0; t < 64; t = t + 1) begin
//                C00[t] <= 'd0;
//            end
//            counta <= 8'd0;
//            countb <= 8'd0;
//            index_a <= 7'd0;
//            index_b <= 7'd0;
//            done_A <= 0;
//            done_B <= 0;
//            state <= IDLE;
//            done <= 1'b0;
//            counter <= 0;
//            unary_col <= 0;
//            unary_row <= 0;
//            neg_row <= 0;
//            neg_col <= 0;
            
//            j <= 0;
//        end else begin
//            case (state)
//                IDLE: begin
//                    // Wait in idle, start processing when index is within bounds
//                    if (index_a < 7'd64) begin
//                        state <= LOAD;
//                    end else begin
//                        done <= 1'b1;  // Done when all vectors processed
//                    end
//                end

//                LOAD: begin
//                    // Load the nth value from vector_a and vector_b into counta and countb
//                    counta <= vector_a[index_a*8+:8];
//                    countb <= vector_b[index_b*8+:8];
                    
//                    state <= COUNT_A;  // Start with counta
//                end

//                COUNT_A: begin
                
//                if (counta == 0) begin
//                        done_A <= done_A + 1;
//                        C00[j] = C00[j] + counter;
//                        done_B <= done_B + 1;
//                        state <= CHANGE;
//                    end
//                    // First, decrement or increment counta
//                  else if (counta > 0) begin
//                        counta <= counta - 1;
//                        state <= COUNT_B;
//                    end else if (counta < 0) begin
//                        counta <= counta + 1;
//                        state <= COUNT_B;
//                    end

//                    if (counta > 0) begin
//                      unary_col <= 1;
//                      neg_col <= 0; end
//                  else if  (counta < 0) begin
//                       unary_col <= 0;
//                       neg_col <= 1; end
//                 if (countb > 0)   begin 
//                      unary_row <= 1;
//                      neg_row <= 0; end
//                 else if (countb < 0) begin
//                    unary_row <= 0;
//                    neg_row <= 1; end
//                    // After one decrement/increment of counta, go to countb state
                    
//                end

//                 COUNT_B: begin
//                // Now decrement or increment countb until it reaches 0
//                if (countb > 0) begin
//                    countb <= countb - 1;
//                    if (xor_out == 0) begin
             
//                counter <= counter + 1; end 
             
//             else if (xor_out == 1) begin
             
//                counter <= counter - 1; end
//                end else if (countb < 0) begin
//                    countb <= countb + 1;
//                    if (xor_out == 0) begin
             
//                counter <= counter + 1; end 
             
//             else if (xor_out == 1) begin
             
//                counter <= counter - 1; end
//                end else begin
//                    // When countb reaches 0, go back to counta if counta > 0
//                    if (counta != 0) begin
//                        state <= COUNT_A;  // Continue with counta
//                        countb <= vector_b[index_b*8+:8];
//                    end else if (counta == 0) begin
//                        done_A <= done_A + 1;
//                        C00[j] = C00[j] + counter;
//                        done_B <= done_B + 1;
//                        state <= CHANGE;
//                    end
//                end
//            end

//            CHANGE: begin
//                j = j+1;
//                counter <= 0;
                
//                // Both counta and countb are 0, load next values
//                case (done_A)
//                    0: index_a <= 7'd0;
//                    1: index_a <= 7'd0;
//                    2: index_a <= 7'd0;
//                    3: index_a <= 7'd0;
//                    4: index_a <= 7'd0;
//                    5: index_a <= 7'd0;
//                    6: index_a <= 7'd0;
//                    7: index_a <= 7'd0;
//                    8: index_a <= 7'd8;
//                    9: index_a <= 7'd8;
//                    10: index_a <= 7'd8;
//                    11: index_a <= 7'd8;
//                    12: index_a <= 7'd8;
//                    13: index_a <= 7'd8;
//                    14: index_a <= 7'd8;
//                    15: index_a <= 7'd8;
//                    16: index_a <= 7'd16;
//                    17: index_a <= 7'd16;
//                    18: index_a <= 7'd16;
//                    19: index_a <= 7'd16;
//                    20: index_a <= 7'd16;
//                    21: index_a <= 7'd16;
//                    22: index_a <= 7'd16;
//                    23: index_a <= 7'd16;
//                    24: index_a <= 7'd24;
//                    25: index_a <= 7'd24;
//                    26: index_a <= 7'd24;
//                    27: index_a <= 7'd24;
//                    28: index_a <= 7'd24;
//                    29: index_a <= 7'd24;
//                    30: index_a <= 7'd24;
//                    31: index_a <= 7'd24;
//                    32: index_a <= 7'd32;
//                    33: index_a <= 7'd32;
//                    34: index_a <= 7'd32;
//                    35: index_a <= 7'd32;
//                    36: index_a <= 7'd32;
//                    37: index_a <= 7'd32;
//                    38: index_a <= 7'd32;
//                    39: index_a <= 7'd32;
//                    40: index_a <= 7'd40;
//                    41: index_a <= 7'd40;
//                    42: index_a <= 7'd40;
//                    43: index_a <= 7'd40;
//                    44: index_a <= 7'd40;
//                    45: index_a <= 7'd40;
//                    46: index_a <= 7'd40;
//                    47: index_a <= 7'd40;
//                    48: index_a <= 7'd48;
//                    49: index_a <= 7'd48;
//                    50: index_a <= 7'd48;
//                    51: index_a <= 7'd48;
//                    52: index_a <= 7'd48;
//                    53: index_a <= 7'd48;
//                    54: index_a <= 7'd48;
//                    55: index_a <= 7'd48;
//                    56: index_a <= 7'd56;
//                    57: index_a <= 7'd56;
//                    58: index_a <= 7'd56;
//                    59: index_a <= 7'd56;
//                    60: index_a <= 7'd56;
//                    61: index_a <= 7'd56;
//                    62: index_a <= 7'd56;
//                    63: index_a <= 7'd56;
                   
                   
//                endcase

//                case (done_B)
//                    0: index_b <= 7'd0;
//                    1: index_b <= 7'd1;
//                    2: index_b <= 7'd2;
//                    3: index_b <= 7'd3;
//                    4: index_b <= 7'd4;
//                    5: index_b <= 7'd5;
//                    6: index_b <= 7'd6;
//                    7: index_b <= 7'd7;
//                    8: index_b <= 7'd0;
//                    9: index_b <= 7'd1;
//                    10: index_b <= 7'd2;
//                    11: index_b <= 7'd3;
//                    12: index_b <= 7'd4;
//                    13: index_b <= 7'd5;
//                    14: index_b <= 7'd6;
//                    15: index_b <= 7'd7;
//                    16: index_b <= 7'd0;
//                    17: index_b <= 7'd1;
//                    18: index_b <= 7'd2;
//                    19: index_b <= 7'd3;
//                    20: index_b <= 7'd4;
//                    21: index_b <= 7'd5;
//                    22: index_b <= 7'd6;
//                    23: index_b <= 7'd7;
//                    24: index_b <= 7'd0;
//                    25: index_b <= 7'd1;
//                    26: index_b <= 7'd2;
//                    27: index_b <= 7'd3;
//                    28: index_b <= 7'd4;
//                    29: index_b <= 7'd5;
//                    30: index_b <= 7'd6;
//                    31: index_b <= 7'd7;
//                    32: index_b <= 7'd0;
//                    33: index_b <= 7'd1;
//                    34: index_b <= 7'd2;
//                    35: index_b <= 7'd3;
//                    36: index_b <= 7'd4;
//                    37: index_b <= 7'd5;
//                    38: index_b <= 7'd6;
//                    39: index_b <= 7'd7;
//                    40: index_b <= 7'd0;
//                    41: index_b <= 7'd1;
//                    42: index_b <= 7'd2;
//                    43: index_b <= 7'd3;
//                    44: index_b <= 7'd4;
//                    45: index_b <= 7'd5;
//                    46: index_b <= 7'd6;
//                    47: index_b <= 7'd7;
//                    48: index_b <= 7'd0;
//                    49: index_b <= 7'd1;
//                    50: index_b <= 7'd2;
//                    51: index_b <= 7'd3;
//                    52: index_b <= 7'd4;
//                    53: index_b <= 7'd5;
//                    54: index_b <= 7'd6;
//                    55: index_b <= 7'd7;
//                    56: index_b <= 7'd0;
//                    57: index_b <= 7'd1;
//                    58: index_b <= 7'd2;
//                    59: index_b <= 7'd3;
//                    60: index_b <= 7'd4;
//                    61: index_b <= 7'd5;
//                    62: index_b <= 7'd6;
//                    63: index_b <= 7'd7;
//                endcase

//                state <= LOAD;  // Load next vector values
//            end

//        endcase
//    end
//end

//            assign xor_out = neg_col ^ neg_row;
//            assign and_out = unary_col && unary_row;

///// second state machine
//    reg signed unary_col_1 ;
//    reg signed unary_row_1 ;
//    reg signed neg_row_1;
//    reg signed neg_col_1 ;
//    wire signed xor_out_1 ;
//    wire signed and_out_1 ;
//    reg signed [7:0] counta_1;
//    reg signed [7:0] countb_1;   // 8-bit counters
//    reg [7:0] index_a_1;            // Index for vector selection
//    reg [7:0] index_b_1;
//    reg [7:0] done_A_1;
//    reg [7:0] done_B_1;
//    reg [2:0] state_1;            // State variable
////     reg done_1;
//     //reg signed [9:0] C00_1 [0:63];
//     reg signed [15:0] counter_1;
//    localparam IDLE_1     = 3'b00,  // IDLE state
//               LOAD_1     = 3'b01,  // Load state for vector values
//               COUNT_A_1  = 3'b10,  // Decrement/Increment counta state
//               COUNT_B_1  = 3'b11,  // Decrement/Increment countb state
//               CHANGE_1   = 3'b100;



//always @(posedge clk) begin
//        if (rst) begin
//            counta_1 <= 8'd0;
//            countb_1 <= 8'd0;
//            index_a_1 <= 7'd1;
//            index_b_1 <= 7'd8;
//            done_A_1 <= 0;
//            done_B_1 <= 0;
//            counter_1 <= 0;
//            unary_col_1 <= 0;
//            unary_row_1 <= 0;
//            neg_row_1 <= 0;
//            neg_col_1 <= 0;
            
//            i <= 0;
//            state_1 <= IDLE_1;
//            //done_1 <= 1'b0;
//        end else begin
//            case (state_1)
//                IDLE_1: begin
//                    // Wait in idle, start processing when index is within bounds
//                    if (index_a_1 < 7'd64) begin
//                        state_1 <= LOAD_1;
//                    end else begin
//                       // done_1 <= 1'b1;  // Done when all vectors processed
//                    end
//                end

//                LOAD_1: begin
//                    // Load the nth value from vector_a and vector_b into counta and countb
//                    counta_1 <= vector_a[index_a_1*8+:8];
//                    countb_1 <= vector_b[index_b_1*8+:8];
//                    state_1 <= COUNT_A_1;  // Start with counta
//                end

//                COUNT_A_1: begin
                
//                if (counta_1 == 0) begin
//                        done_A_1 <= done_A_1 + 1;
//                        C00[i] = C00[i] + counter_1;
//                        done_B_1 <= done_B_1 + 1;
//                        state_1 <= CHANGE_1;
//                    end
//                    // First, decrement or increment counta
//                   else if (counta_1 > 0) begin
//                        counta_1 <= counta_1 - 1;
//                        state_1 <= COUNT_B_1;
//                    end else if (counta_1 < 0) begin
//                        counta_1 <= counta_1 + 1;
//                        state_1 <= COUNT_B_1;
//                    end

//                    if (counta_1 > 0) begin
//                      unary_col_1 <= 1;
//                      neg_col_1 <= 0; end
//                  else if  (counta_1 < 0) begin
//                       unary_col_1 <= 0;
//                       neg_col_1 <= 1; end
//                 if (countb_1 > 0)   begin 
//                      unary_row_1 <= 1;
//                      neg_row_1 <= 0; end
//                 else if (countb_1 < 0) begin
//                    unary_row_1 <= 0;
//                    neg_row_1 <= 1; end
                    
//                    // After one decrement/increment of counta, go to countb state
                    
//                end

//                 COUNT_B_1: begin
//                // Now decrement or increment countb until it reaches 0
//                if (countb_1 > 0) begin
//                    countb_1 <= countb_1 - 1;
//                    if (xor_out_1 == 0) begin
             
//                counter_1 <= counter_1 + 1; end 
             
//             else if (xor_out_1 == 1) begin
             
//                counter_1 <= counter_1 - 1; end
//                end else if (countb_1 < 0) begin
//                    countb_1 <= countb_1 + 1;
//                    if (xor_out_1 == 0) begin
             
//                counter_1 <= counter_1 + 1; end 
             
//             else if (xor_out_1 == 1) begin
             
//                counter_1 <= counter_1 - 1; end
//                end else begin
//                    // When countb reaches 0, go back to counta if counta > 0
//                    if (counta_1 != 0) begin
//                        state_1 <= COUNT_A_1;  // Continue with counta
//                        countb_1 <= vector_b[index_b_1*8+:8];
//                    end else if (counta_1 == 0) begin
//                        done_A_1 <= done_A_1 + 1;
//                        C00[i] = C00[i] + counter_1;
//                        done_B_1 <= done_B_1 + 1;
//                        state_1 <= CHANGE_1;
//                    end
//                end
//            end

//            CHANGE_1: begin
            
//                i = i+1;
//                counter_1 <= 0;
//                // Both counta and countb are 0, load next values
//                case (done_A_1)
//                    0: index_a_1 <= 7'd0;
//                    1: index_a_1 <= 7'd1;
//                    2: index_a_1 <= 7'd1;
//                    3: index_a_1 <= 7'd1;
//                    4: index_a_1 <= 7'd1;
//                    5: index_a_1 <= 7'd1;
//                    6: index_a_1 <= 7'd1;
//                    7: index_a_1 <= 7'd1;
//                    8: index_a_1 <= 7'd9;
//                    9: index_a_1 <= 7'd9;
//                    10: index_a_1 <= 7'd9;
//                    11: index_a_1 <= 7'd9;
//                    12: index_a_1 <= 7'd9;
//                    13: index_a_1 <= 7'd9;
//                    14: index_a_1 <= 7'd9;
//                    15: index_a_1 <= 7'd9;
//                    16: index_a_1 <= 7'd17;
//                    17: index_a_1 <= 7'd17;
//                    18: index_a_1 <= 7'd17;
//                    19: index_a_1 <= 7'd17;
//                    20: index_a_1 <= 7'd17;
//                    21: index_a_1 <= 7'd17;
//                    22: index_a_1 <= 7'd17;
//                    23: index_a_1 <= 7'd17;
//                    24: index_a_1 <= 7'd25;
//                    25: index_a_1 <= 7'd25;
//                    26: index_a_1 <= 7'd25;
//                    27: index_a_1 <= 7'd25;
//                    28: index_a_1 <= 7'd25;
//                    29: index_a_1 <= 7'd25;
//                    30: index_a_1 <= 7'd25;
//                    31: index_a_1 <= 7'd25;
//                    32: index_a_1 <= 7'd33;
//                    33: index_a_1 <= 7'd33;
//                    34: index_a_1 <= 7'd33;
//                    35: index_a_1 <= 7'd33;
//                    36: index_a_1 <= 7'd33;
//                    37: index_a_1 <= 7'd33;
//                    38: index_a_1 <= 7'd33;
//                    39: index_a_1 <= 7'd33;
//                    40: index_a_1 <= 7'd41;
//                    41: index_a_1 <= 7'd41;
//                    42: index_a_1 <= 7'd41;
//                    43: index_a_1 <= 7'd41;
//                    44: index_a_1 <= 7'd41;
//                    45: index_a_1 <= 7'd41;
//                    46: index_a_1 <= 7'd41;
//                    47: index_a_1 <= 7'd41;
//                    48: index_a_1 <= 7'd49;
//                    49: index_a_1 <= 7'd49;
//                    50: index_a_1 <= 7'd49;
//                    51: index_a_1 <= 7'd49;
//                    52: index_a_1 <= 7'd49;
//                    53: index_a_1 <= 7'd49;
//                    54: index_a_1 <= 7'd49;
//                    55: index_a_1 <= 7'd49;
//                    56: index_a_1 <= 7'd57;
//                    57: index_a_1 <= 7'd57;
//                    58: index_a_1 <= 7'd57;
//                    59: index_a_1 <= 7'd57;
//                    60: index_a_1 <= 7'd57;
//                    61: index_a_1 <= 7'd57;
//                    62: index_a_1 <= 7'd57;
//                    63: index_a_1 <= 7'd57;
//                endcase

//                case (done_B_1)
//                    0: index_b_1 <= 7'd0;
//                    1: index_b_1 <= 7'd9;
//                    2: index_b_1 <= 7'd10;
//                    3: index_b_1 <= 7'd11;
//                    4: index_b_1 <= 7'd12;
//                    5: index_b_1 <= 7'd13;
//                    6: index_b_1 <= 7'd14;
//                    7: index_b_1 <= 7'd15;
//                    8: index_b_1 <= 7'd8;
//                    9: index_b_1 <= 7'd9;
//                    10: index_b_1 <= 7'd10;
//                    11: index_b_1 <= 7'd11;
//                    12: index_b_1 <= 7'd12;
//                    13: index_b_1 <= 7'd13;
//                    14: index_b_1 <= 7'd14;
//                    15: index_b_1 <= 7'd15;
//                    16: index_b_1 <= 7'd8;
//                    17: index_b_1 <= 7'd9;
//                    18: index_b_1 <= 7'd10;
//                    19: index_b_1 <= 7'd11;
//                    20: index_b_1 <= 7'd12;
//                    21: index_b_1 <= 7'd13;
//                    22: index_b_1 <= 7'd14;
//                    23: index_b_1 <= 7'd15;
//                    24: index_b_1 <= 7'd8;
//                    25: index_b_1 <= 7'd9;
//                    26: index_b_1 <= 7'd10;
//                    27: index_b_1 <= 7'd11;
//                    28: index_b_1 <= 7'd12;
//                    29: index_b_1 <= 7'd13;
//                    30: index_b_1 <= 7'd14;
//                    31: index_b_1 <= 7'd15;
//                    32: index_b_1 <= 7'd8;
//                    33: index_b_1 <= 7'd9;
//                    34: index_b_1 <= 7'd10;
//                    35: index_b_1 <= 7'd11;
//                    36: index_b_1 <= 7'd12;
//                    37: index_b_1 <= 7'd13;
//                    38: index_b_1 <= 7'd14;
//                    39: index_b_1 <= 7'd15;
//                    40: index_b_1 <= 7'd8;
//                    41: index_b_1 <= 7'd9;
//                    42: index_b_1 <= 7'd10;
//                    43: index_b_1 <= 7'd11;
//                    44: index_b_1 <= 7'd12;
//                    45: index_b_1 <= 7'd13;
//                    46: index_b_1 <= 7'd14;
//                    47: index_b_1 <= 7'd15;
//                    48: index_b_1 <= 7'd8;
//                    49: index_b_1 <= 7'd9;
//                    50: index_b_1 <= 7'd10;
//                    51: index_b_1 <= 7'd11;
//                    52: index_b_1 <= 7'd12;
//                    53: index_b_1 <= 7'd13;
//                    54: index_b_1 <= 7'd14;
//                    55: index_b_1 <= 7'd15;
//                    56: index_b_1 <= 7'd8;
//                    57: index_b_1 <= 7'd9;
//                    58: index_b_1 <= 7'd10;
//                    59: index_b_1 <= 7'd11;
//                    60: index_b_1 <= 7'd12;
//                    61: index_b_1 <= 7'd13;
//                    62: index_b_1 <= 7'd14;
//                    63: index_b_1 <= 7'd15;
//                endcase

//                state_1 <= LOAD_1;  // Load next vector values
//            end

//        endcase
//    end
//end


//            assign xor_out_1 = neg_col_1 ^ neg_row_1;
//            assign and_out_1 = unary_col_1 && unary_row_1;

///// third state machine
//    reg signed unary_col_2 ;
//    reg signed unary_row_2 ;
//    reg signed neg_row_2;
//    reg signed neg_col_2 ;
//    wire signed xor_out_2 ;
//    wire signed and_out_2 ;
//    reg  signed [7:0] counta_2;
//    reg signed [7:0] countb_2;   // 8-bit counters
//    reg [7:0] index_a_2;            // Index for vector selection
//    reg [7:0] index_b_2;
//    reg [7:0] done_A_2;
//    reg [7:0] done_B_2;
//    reg [2:0] state_2;            // State variable
//  //   reg done_1;
//     //reg signed [9:0] C00_2 [0:63];
//     reg signed [15:0] counter_2;
//    localparam IDLE_2     = 3'b00,  // IDLE state
//               LOAD_2     = 3'b01,  // Load state for vector values
//               COUNT_A_2  = 3'b10,  // Decrement/Increment counta state
//               COUNT_B_2  = 3'b11,  // Decrement/Increment countb state
//               CHANGE_2   = 3'b100;



//always @(posedge clk) begin
//        if (rst) begin
//            counta_2 <= 8'd0;
//            countb_2 <= 8'd0;
//            index_a_2 <= 7'd2;
//            index_b_2 <= 7'd16;
//            done_A_2 <= 0;
//            done_B_2 <= 0;
//            counter_2 <= 0;
//            unary_col_2 <= 0;
//            unary_row_2 <= 0;
//            neg_row_2 <= 0;
//            neg_col_2 <= 0;
            
//            k <= 0;
//            state_2 <= IDLE_2;
//            //done_1 <= 1'b0;
//        end else begin
//            case (state_2)
//                IDLE_2: begin
//                    // Wait in idle, start processing when index is within bounds
//                    if (index_a_2 < 7'd64) begin
//                        state_2 <= LOAD_2;
//                    end else begin
//                       // done_1 <= 1'b1;  // Done when all vectors processed
//                    end
//                end

//                LOAD_2: begin
//                    // Load the nth value from vector_a and vector_b into counta and countb
//                    counta_2 <= vector_a[index_a_2*8+:8];
//                    countb_2 <= vector_b[index_b_2*8+:8];
//                    state_2 <= COUNT_A_2;  // Start with counta
//                end

//                COUNT_A_2: begin
                
//                if (counta_2 == 0) begin
//                        done_A_2 <= done_A_2 + 1;
//                        C00[k] = C00[k] + counter_2;
//                        done_B_2 <= done_B_2 + 1;
//                        state_2 <= CHANGE_2;
//                    end
//                    // First, decrement or increment counta
//                   else if (counta_2 > 0) begin
//                        counta_2 <= counta_2 - 1;
//                         state_2 <= COUNT_B_2;
//                    end else if (counta_2 < 0) begin
//                        counta_2 <= counta_2 + 1;
//                         state_2 <= COUNT_B_2;
//                    end

//                    if (counta_2 > 0) begin
//                      unary_col_2 <= 1;
//                      neg_col_2 <= 0; end
//                  else if  (counta_2 < 0) begin
//                       unary_col_2 <= 0;
//                       neg_col_2 <= 1; end
//                 if (countb_2 > 0)   begin 
//                      unary_row_2 <= 1;
//                      neg_row_2 <= 0; end
//                 else if (countb_2 < 0) begin
//                    unary_row_2 <= 0;
//                    neg_row_2 <= 1; end

//                    // After one decrement/increment of counta, go to countb state
                   
//                end

//                 COUNT_B_2: begin
//                // Now decrement or increment countb until it reaches 0
//                if (countb_2 > 0) begin
//                    countb_2 <= countb_2 - 1;
//                     if (xor_out_2 == 0) begin
             
//                counter_2 <= counter_2 + 1; end 
             
//             else if (xor_out_2 == 1) begin
             
//                counter_2 <= counter_2 - 1; end
                
//                end else if (countb_2 < 0) begin
//                    countb_2 <= countb_2 + 1;
//                     if (xor_out_2 == 0) begin
             
//                counter_2 <= counter_2 + 1; end 
             
//             else if (xor_out_2 == 1) begin
             
//                counter_2 <= counter_2 - 1; end
//                end else begin
//                    // When countb reaches 0, go back to counta if counta > 0
//                    if (counta_2 != 0) begin
//                        state_2 <= COUNT_A_2;  // Continue with counta
//                        countb_2 <= vector_b[index_b_2*8+:8];
//                    end else if (counta_2 == 0) begin
//                        done_A_2 <= done_A_2 + 1;
//                        C00[k] = C00[k] + counter_2;
//                        done_B_2 <= done_B_2 + 1;
//                        state_2 <= CHANGE_2;
//                    end
//                end
//            end

//            CHANGE_2: begin
            
//                k = k+1;
//                counter_2 <= 0;
//                // Both counta and countb are 0, load next values
//                case (done_A_2)
//                    0: index_a_2 <= 7'd0;
//                    1: index_a_2 <= 7'd2;
//                    2: index_a_2 <= 7'd2;
//                    3: index_a_2 <= 7'd2;
//                    4: index_a_2 <= 7'd2;
//                    5: index_a_2 <= 7'd2;
//                    6: index_a_2 <= 7'd2;
//                    7: index_a_2 <= 7'd2;
//                    8: index_a_2 <= 7'd10;
//                    9: index_a_2 <= 7'd10;
//                    10: index_a_2 <= 7'd10;
//                    11: index_a_2 <= 7'd10;
//                    12: index_a_2 <= 7'd10;
//                    13: index_a_2 <= 7'd10;
//                    14: index_a_2 <= 7'd10;
//                    15: index_a_2 <= 7'd10;
//                    16: index_a_2 <= 7'd18;
//                    17: index_a_2 <= 7'd18;
//                    18: index_a_2 <= 7'd18;
//                    19: index_a_2 <= 7'd18;
//                    20: index_a_2 <= 7'd18;
//                    21: index_a_2 <= 7'd18;
//                    22: index_a_2 <= 7'd18;
//                    23: index_a_2 <= 7'd18;
//                    24: index_a_2 <= 7'd26;
//                    25: index_a_2 <= 7'd26;
//                    26: index_a_2 <= 7'd26;
//                    27: index_a_2 <= 7'd26;
//                    28: index_a_2 <= 7'd26;
//                    29: index_a_2 <= 7'd26;
//                    30: index_a_2 <= 7'd26;
//                    31: index_a_2 <= 7'd26;
//                    32: index_a_2 <= 7'd34;
//                    33: index_a_2 <= 7'd34;
//                    34: index_a_2 <= 7'd34;
//                    35: index_a_2 <= 7'd34;
//                    36: index_a_2 <= 7'd34;
//                    37: index_a_2 <= 7'd34;
//                    38: index_a_2 <= 7'd34;
//                    39: index_a_2 <= 7'd34;
//                    40: index_a_2 <= 7'd42;
//                    41: index_a_2 <= 7'd42;
//                    42: index_a_2 <= 7'd42;
//                    43: index_a_2 <= 7'd42;
//                    44: index_a_2 <= 7'd42;
//                    45: index_a_2 <= 7'd42;
//                    46: index_a_2 <= 7'd42;
//                    47: index_a_2 <= 7'd42;
//                    48: index_a_2 <= 7'd50;
//                    49: index_a_2 <= 7'd50;
//                    50: index_a_2 <= 7'd50;
//                    51: index_a_2 <= 7'd50;
//                    52: index_a_2 <= 7'd50;
//                    53: index_a_2 <= 7'd50;
//                    54: index_a_2 <= 7'd50;
//                    55: index_a_2 <= 7'd50;
//                    56: index_a_2 <= 7'd58;
//                    57: index_a_2 <= 7'd58;
//                    58: index_a_2 <= 7'd58;
//                    59: index_a_2 <= 7'd58;
//                    60: index_a_2 <= 7'd58;
//                    61: index_a_2 <= 7'd58;
//                    62: index_a_2 <= 7'd58;
//                    63: index_a_2 <= 7'd58;
//                endcase

//                case (done_B_2)
//                    0: index_b_2 <= 7'd0;
//                    1: index_b_2 <= 7'd17;
//                    2: index_b_2 <= 7'd18;
//                    3: index_b_2 <= 7'd19;
//                    4: index_b_2 <= 7'd20;
//                    5: index_b_2 <= 7'd21;
//                    6: index_b_2 <= 7'd22;
//                    7: index_b_2 <= 7'd23;
//                    8: index_b_2 <= 7'd16;
//                    9: index_b_2 <= 7'd17;
//                    10: index_b_2 <= 7'd18;
//                    11: index_b_2 <= 7'd19;
//                    12: index_b_2 <= 7'd20;
//                    13: index_b_2 <= 7'd21;
//                    14: index_b_2 <= 7'd22;
//                    15: index_b_2 <= 7'd23;
//                    16: index_b_2 <= 7'd16;
//                    17: index_b_2 <= 7'd17;
//                    18: index_b_2 <= 7'd18;
//                    19: index_b_2 <= 7'd19;
//                    20: index_b_2 <= 7'd20;
//                    21: index_b_2 <= 7'd21;
//                    22: index_b_2 <= 7'd22;
//                    23: index_b_2 <= 7'd23;
//                    24: index_b_2 <= 7'd16;
//                    25: index_b_2 <= 7'd17;
//                    26: index_b_2 <= 7'd18;
//                    27: index_b_2 <= 7'd19;
//                    28: index_b_2 <= 7'd20;
//                    29: index_b_2 <= 7'd21;
//                    30: index_b_2 <= 7'd22;
//                    31: index_b_2 <= 7'd23;
//                    32: index_b_2 <= 7'd16;
//                    33: index_b_2 <= 7'd17;
//                    34: index_b_2 <= 7'd18;
//                    35: index_b_2 <= 7'd19;
//                    36: index_b_2 <= 7'd20;
//                    37: index_b_2 <= 7'd21;
//                    38: index_b_2 <= 7'd22;
//                    39: index_b_2 <= 7'd23;
//                    40: index_b_2 <= 7'd16;
//                    41: index_b_2 <= 7'd17;
//                    42: index_b_2 <= 7'd18;
//                    43: index_b_2 <= 7'd19;
//                    44: index_b_2 <= 7'd20;
//                    45: index_b_2 <= 7'd21;
//                    46: index_b_2 <= 7'd22;
//                    47: index_b_2 <= 7'd23;
//                    48: index_b_2 <= 7'd16;
//                    49: index_b_2 <= 7'd17;
//                    50: index_b_2 <= 7'd18;
//                    51: index_b_2 <= 7'd19;
//                    52: index_b_2 <= 7'd20;
//                    53: index_b_2 <= 7'd21;
//                    54: index_b_2 <= 7'd22;
//                    55: index_b_2 <= 7'd23;
//                    56: index_b_2 <= 7'd16;
//                    57: index_b_2 <= 7'd17;
//                    58: index_b_2 <= 7'd18;
//                    59: index_b_2 <= 7'd19;
//                    60: index_b_2 <= 7'd20;
//                    61: index_b_2 <= 7'd21;
//                    62: index_b_2 <= 7'd22;
//                    63: index_b_2 <= 7'd23;
//                endcase

//                state_2 <= LOAD_2;  // Load next vector values
//            end

//        endcase
//    end
//end

//            assign xor_out_2 = neg_col_2 ^ neg_row_2;
//            assign and_out_2 = unary_col_2 && unary_row_2;


///// FOURTH state machine
//    reg signed unary_col_3 ;
//    reg signed unary_row_3 ;
//    reg signed neg_row_3;
//    reg signed neg_col_3 ;
//    wire signed xor_out_3 ;
//    wire signed and_out_3 ;
//    reg signed[7:0] counta_3;
//    reg signed [7:0] countb_3;   // 8-bit counters
//    reg [7:0] index_a_3;            // Index for vector selection
//    reg [7:0] index_b_3;
//    reg [7:0] done_A_3;
//    reg [7:0] done_B_3;
//    reg [2:0] state_3;            // State variable
//  //   reg done_1;
////     reg signed [9:0] C00_3 [0:63];
//     reg signed [15:0] counter_3;
//    localparam IDLE_3     = 3'b00,  // IDLE state
//               LOAD_3     = 3'b01,  // Load state for vector values
//               COUNT_A_3  = 3'b10,  // Decrement/Increment counta state
//               COUNT_B_3  = 3'b11,  // Decrement/Increment countb state
//               CHANGE_3   = 3'b100;



//always @(posedge clk) begin
//        if (rst) begin
//            counta_3 <= 8'd0;
//            countb_3 <= 8'd0;
//            index_a_3 <= 7'd3;
//            index_b_3 <= 5'd24;
//            done_A_3 <= 0;
//            done_B_3 <= 0;
//            counter_3 <= 0;
//            unary_col_3 <= 0;
//            unary_row_3 <= 0;
//            neg_row_3 <= 0;
//            neg_col_3 <= 0;
            
//            l <= 0;
//            state_3 <= IDLE_3;
//            //done_1 <= 1'b0;
//        end else begin
//            case (state_3)
//                IDLE_3: begin
//                    // Wait in idle, start processing when index is within bounds
//                    if (index_a_3 < 7'd64) begin
//                        state_3 <= LOAD_3;
//                    end else begin
//                       // done_1 <= 1'b1;  // Done when all vectors processed
//                    end
//                end

//                LOAD_3: begin
//                    // Load the nth value from vector_a and vector_b into counta and countb
//                    counta_3 <= vector_a[index_a_3*8+:8];
//                    countb_3 <= vector_b[index_b_3*8+:8];
                    
                
//                    state_3 <= COUNT_A_3;  // Start with counta
//                end

//                COUNT_A_3: begin
                
//                if (counta_3 == 0) begin
//                        done_A_3 <= done_A_3 + 1;
//                        C00[l] = C00[l] + counter_3;
//                        done_B_3 <= done_B_3 + 1;
//                        state_3 <= CHANGE_3;
//                    end
//                    // First, decrement or increment counta
//                   else if (counta_3 > 0) begin
//                        counta_3 <= counta_3 - 1;
//                        state_3 <= COUNT_B_3;
//                    end else if (counta_3 < 0) begin
//                        counta_3 <= counta_3 + 1;
//                        state_3 <= COUNT_B_3;
//                    end

//                    if (counta_3 > 0) begin
//                      unary_col_3 <= 1;
//                      neg_col_3 <= 0; end
//                  else if  (counta_3 < 0) begin
//                       unary_col_3 <= 0;
//                       neg_col_3 <= 1; end
//                 if (countb_3 > 0)   begin 
//                      unary_row_3 <= 1;
//                      neg_row_3 <= 0; end
//                 else if (countb_3 < 0) begin
//                    unary_row_3 <= 0;
//                    neg_row_3 <= 1; end

//                    // After one decrement/increment of counta, go to countb state
                    
//                end

//                 COUNT_B_3: begin
//                // Now decrement or increment countb until it reaches 0
//                if (countb_3 > 0) begin
//                    countb_3 <= countb_3 - 1;
//                    if (xor_out_3 == 0) begin
             
//                counter_3 <= counter_3 + 1; end 
             
//             else if (xor_out_3 == 1) begin
             
//                counter_3 <= counter_3 - 1; end
//                end else if (countb_3 < 0) begin
//                    countb_3 <= countb_3 + 1;
//                    if (xor_out_3 == 0) begin
             
//                counter_3 <= counter_3 + 1; end 
             
//             else if (xor_out_3 == 1) begin
             
//                counter_3 <= counter_3 - 1; end
//                end else begin
//                    // When countb reaches 0, go back to counta if counta > 0
//                    if (counta_3 != 0) begin
//                        state_3 <= COUNT_A_3;  // Continue with counta
//                        countb_3 <= vector_b[index_b_3*8+:8];
//                    end else if (counta_3 == 0) begin
//                        done_A_3 <= done_A_3 + 1;
//                        C00[l] = C00[l] + counter_3;
//                        done_B_3 <= done_B_3 + 1;
//                        state_3 <= CHANGE_3;
//                    end
//                end
//            end

//            CHANGE_3: begin
            
//                l = l+1;
//                counter_3 <= 0;
//                // Both counta and countb are 0, load next values
//                case (done_A_3)
//                    0: index_a_3 <= 7'd0;
//                    1: index_a_3 <= 7'd3;
//                    2: index_a_3 <= 7'd3;
//                    3: index_a_3 <= 7'd3;
//                    4: index_a_3 <= 7'd3;
//                    5: index_a_3 <= 7'd3;
//                    6: index_a_3 <= 7'd3;
//                    7: index_a_3 <= 7'd3;
//                    8: index_a_3 <= 7'd11;
//                    9: index_a_3 <= 7'd11;
//                    10: index_a_3 <= 7'd11;
//                    11: index_a_3 <= 7'd11;
//                    12: index_a_3 <= 7'd11;
//                    13: index_a_3 <= 7'd11;
//                    14: index_a_3 <= 7'd11;
//                    15: index_a_3 <= 7'd11;
//                    16: index_a_3 <= 7'd19;
//                    17: index_a_3 <= 7'd19;
//                    18: index_a_3 <= 7'd19;
//                    19: index_a_3 <= 7'd19;
//                    20: index_a_3 <= 7'd19;
//                    21: index_a_3 <= 7'd19;
//                    22: index_a_3 <= 7'd19;
//                    23: index_a_3 <= 7'd19;
//                    24: index_a_3 <= 7'd27;
//                    25: index_a_3 <= 7'd27;
//                    26: index_a_3 <= 7'd27;
//                    27: index_a_3 <= 7'd27;
//                    28: index_a_3 <= 7'd27;
//                    29: index_a_3 <= 7'd27;
//                    30: index_a_3 <= 7'd27;
//                    31: index_a_3 <= 7'd27;
//                    32: index_a_3 <= 7'd35;
//                    33: index_a_3 <= 7'd35;
//                    34: index_a_3 <= 7'd35;
//                    35: index_a_3 <= 7'd35;
//                    36: index_a_3 <= 7'd35;
//                    37: index_a_3 <= 7'd35;
//                    38: index_a_3 <= 7'd35;
//                    39: index_a_3 <= 7'd35;
//                    40: index_a_3 <= 7'd43;
//                    41: index_a_3 <= 7'd43;
//                    42: index_a_3 <= 7'd43;
//                    43: index_a_3 <= 7'd43;
//                    44: index_a_3 <= 7'd43;
//                    45: index_a_3 <= 7'd43;
//                    46: index_a_3 <= 7'd43;
//                    47: index_a_3 <= 7'd43;
//                    48: index_a_3 <= 7'd51;
//                    49: index_a_3 <= 7'd51;
//                    50: index_a_3 <= 7'd51;
//                    51: index_a_3 <= 7'd51;
//                    52: index_a_3 <= 7'd51;
//                    53: index_a_3 <= 7'd51;
//                    54: index_a_3 <= 7'd51;
//                    55: index_a_3 <= 7'd51;
//                    56: index_a_3 <= 7'd59;
//                    57: index_a_3 <= 7'd59;
//                    58: index_a_3 <= 7'd59;
//                    59: index_a_3 <= 7'd59;
//                    60: index_a_3 <= 7'd59;
//                    61: index_a_3 <= 7'd59;
//                    62: index_a_3 <= 7'd59;
//                    63: index_a_3 <= 7'd59;
//                endcase

//                case (done_B_3)
//                    0: index_b_3 <= 7'd0;
//                    1: index_b_3 <= 7'd25;
//                    2: index_b_3 <= 7'd26;
//                    3: index_b_3 <= 7'd27;
//                    4: index_b_3 <= 7'd28;
//                    5: index_b_3 <= 7'd29;
//                    6: index_b_3 <= 7'd30;
//                    7: index_b_3 <= 7'd31;
//                    8: index_b_3 <= 7'd24;
//                    9: index_b_3 <= 7'd25;
//                    10: index_b_3 <= 7'd26;
//                    11: index_b_3 <= 7'd27;
//                    12: index_b_3 <= 7'd28;
//                    13: index_b_3 <= 7'd29;
//                    14: index_b_3 <= 7'd30;
//                    15: index_b_3 <= 7'd31;
//                    16: index_b_3 <= 7'd24;
//                    17: index_b_3 <= 7'd25;
//                    18: index_b_3 <= 7'd26;
//                    19: index_b_3 <= 7'd27;
//                    20: index_b_3 <= 7'd28;
//                    21: index_b_3 <= 7'd29;
//                    22: index_b_3 <= 7'd30;
//                    23: index_b_3 <= 7'd31;
//                    24: index_b_3 <= 7'd24;
//                    25: index_b_3 <= 7'd25;
//                    26: index_b_3 <= 7'd26;
//                    27: index_b_3 <= 7'd27;
//                    28: index_b_3 <= 7'd28;
//                    29: index_b_3 <= 7'd29;
//                    30: index_b_3 <= 7'd30;
//                    31: index_b_3 <= 7'd31;
//                    32: index_b_3 <= 7'd24;
//                    33: index_b_3 <= 7'd25;
//                    34: index_b_3 <= 7'd26;
//                    35: index_b_3 <= 7'd27;
//                    36: index_b_3 <= 7'd28;
//                    37: index_b_3 <= 7'd29;
//                    38: index_b_3 <= 7'd30;
//                    39: index_b_3 <= 7'd31;
//                    40: index_b_3 <= 7'd24;
//                    41: index_b_3 <= 7'd25;
//                    42: index_b_3 <= 7'd26;
//                    43: index_b_3 <= 7'd27;
//                    44: index_b_3 <= 7'd28;
//                    45: index_b_3 <= 7'd29;
//                    46: index_b_3 <= 7'd30;
//                    47: index_b_3 <= 7'd31;
//                    48: index_b_3 <= 7'd24;
//                    49: index_b_3 <= 7'd25;
//                    50: index_b_3 <= 7'd26;
//                    51: index_b_3 <= 7'd27;
//                    52: index_b_3 <= 7'd28;
//                    53: index_b_3 <= 7'd29;
//                    54: index_b_3 <= 7'd30;
//                    55: index_b_3 <= 7'd31;
//                    56: index_b_3 <= 7'd24;
//                    57: index_b_3 <= 7'd25;
//                    58: index_b_3 <= 7'd26;
//                    59: index_b_3 <= 7'd27;
//                    60: index_b_3 <= 7'd28;
//                    61: index_b_3 <= 7'd29;
//                    62: index_b_3 <= 7'd30;
//                    63: index_b_3 <= 7'd31;
//                endcase

//                state_3 <= LOAD_3;  // Load next vector values
//            end

//        endcase
//    end
//end


//            assign xor_out_3 = neg_col_3 ^ neg_row_3;
//            assign and_out_3 = unary_col_3 && unary_row_3;




//// Fifth State Machine

//    reg signed unary_col_4 ;
//    reg signed unary_row_4 ;
//    reg signed neg_row_4;
//    reg signed neg_col_4 ;
//    wire signed xor_out_4 ;
//    wire signed and_out_4 ;
//    reg signed [7:0] counta_4;
//    reg signed [7:0] countb_4;   // 8-bit counters
//    reg [7:0] index_a_4;            // Index for vector selection
//    reg [7:0] index_b_4;
//    reg [7:0] done_A_4;
//    reg [7:0] done_B_4;
//    reg [2:0] state_4;            // State variable
//  //   reg done_1;
////     reg signed [9:0] C00_4 [0:63];
//     reg signed [15:0] counter_4;
//    localparam IDLE_4     = 3'b00,  // IDLE state
//               LOAD_4     = 3'b01,  // Load state for vector values
//               COUNT_A_4  = 3'b10,  // Decrement/Increment counta state
//               COUNT_B_4  = 3'b11,  // Decrement/Increment countb state
//               CHANGE_4   = 3'b100;



//always @(posedge clk) begin
//        if (rst) begin
//            counta_4 <= 8'd0;
//            countb_4 <= 8'd0;
//            index_a_4 <= 7'd4;
//            index_b_4 <= 7'd32;
//            done_A_4 <= 0;
//            done_B_4 <= 0;
//            counter_4 <= 0;
//            unary_col_4 <= 0;
//            unary_row_4 <= 0;
//            neg_row_4 <= 0;
//            neg_col_4 <= 0;
            
//            m <= 0;
//            state_4 <= IDLE_4;
//            //done_1 <= 1'b0;
//        end else begin
//            case (state_4)
//                IDLE_3: begin
//                    // Wait in idle, start processing when index is within bounds
//                    if (index_a_4 < 7'd64) begin
//                        state_4 <= LOAD_4;
//                    end else begin
//                       // done_1 <= 1'b1;  // Done when all vectors processed
//                    end
//                end

//                LOAD_3: begin
//                    // Load the nth value from vector_a and vector_b into counta and countb
//                    counta_4 <= vector_a[index_a_4*8+:8];
//                    countb_4 <= vector_b[index_b_4*8+:8];
                    
                
//                    state_4 <= COUNT_A_4;  // Start with counta
//                end

//                COUNT_A_4: begin
                
//                if (counta_4 == 0) begin
//                        done_A_4 <= done_A_4 + 1;
//                        C00[m] = C00[m] + counter_4;
//                        done_B_4 <= done_B_4 + 1;
//                        state_4 <= CHANGE_4;
//                    end
//                    // First, decrement or increment counta
//                    else if (counta_4 > 0) begin
//                        counta_4 <= counta_4 - 1;
//                        state_4 <= COUNT_B_4;
//                    end else if (counta_4 < 0) begin
//                        counta_4 <= counta_4 + 1;
//                        state_4 <= COUNT_B_4;
//                    end

//                    if (counta_4 > 0) begin
//                      unary_col_4 <= 1;
//                      neg_col_4 <= 0; end
//                  else if  (counta_4 < 0) begin
//                       unary_col_4 <= 0;
//                       neg_col_4 <= 1; end
//                 if (countb_4 > 0)   begin 
//                      unary_row_4 <= 1;
//                      neg_row_4 <= 0; end
//                 else if (countb_4 < 0) begin
//                    unary_row_4 <= 0;
//                    neg_row_4 <= 1; end

//                    // After one decrement/increment of counta, go to countb state
                    
//                end

//                 COUNT_B_4: begin
//                // Now decrement or increment countb until it reaches 0
//                if (countb_4 > 0) begin
//                    countb_4 <= countb_4 - 1;
//                    if (xor_out_4 == 0) begin
             
//                counter_4 <= counter_4 + 1; end 
             
//             else if (xor_out_4 == 1) begin
             
//                counter_4 <= counter_4 - 1; end
//                end else if (countb_4 < 0) begin
//                    countb_4 <= countb_4 + 1;
//                    if (xor_out_4 == 0) begin
             
//                counter_4 <= counter_4 + 1; end 
             
//             else if (xor_out_4 == 1) begin
             
//                counter_4 <= counter_4 - 1; end
//                end else begin
//                    // When countb reaches 0, go back to counta if counta > 0
//                    if (counta_4 != 0) begin
//                        state_4 <= COUNT_A_4;  // Continue with counta
//                        countb_4 <= vector_b[index_b_4*8+:8];
//                    end else if (counta_4 == 0) begin
//                        done_A_4 <= done_A_4 + 1;
//                        C00[m] = C00[m] + counter_4;
//                        done_B_4 <= done_B_4 + 1;
//                        state_4 <= CHANGE_4;
//                    end
//                end
//            end

//            CHANGE_4: begin
            
//                m = m+1;
//                counter_4 <= 0;
//                // Both counta and countb are 0, load next values
//                case (done_A_4)
//                    0: index_a_4 <= 7'd0;
//                    1: index_a_4 <= 7'd4;
//                    2: index_a_4 <= 7'd4;
//                    3: index_a_4 <= 7'd4;
//                    4: index_a_4 <= 7'd4;
//                    5: index_a_4 <= 7'd4;
//                    6: index_a_4 <= 7'd4;
//                    7: index_a_4 <= 7'd4;
//                    8: index_a_4 <= 7'd12;
//                    9: index_a_4 <= 7'd12;
//                    10: index_a_4 <= 7'd12;
//                    11: index_a_4 <= 7'd12;
//                    12: index_a_4 <= 7'd12;
//                    13: index_a_4 <= 7'd12;
//                    14: index_a_4 <= 7'd12;
//                    15: index_a_4 <= 7'd12;
//                    16: index_a_4 <= 7'd20;
//                    17: index_a_4 <= 7'd20;
//                    18: index_a_4 <= 7'd20;
//                    19: index_a_4 <= 7'd20;
//                    20: index_a_4 <= 7'd20;
//                    21: index_a_4 <= 7'd20;
//                    22: index_a_4 <= 7'd20;
//                    23: index_a_4 <= 7'd20;
//                    24: index_a_4 <= 7'd28;
//                    25: index_a_4 <= 7'd28;
//                    26: index_a_4 <= 7'd28;
//                    27: index_a_4 <= 7'd28;
//                    28: index_a_4 <= 7'd28;
//                    29: index_a_4 <= 7'd28;
//                    30: index_a_4 <= 7'd28;
//                    31: index_a_4 <= 7'd28;
//                    32: index_a_4 <= 7'd36;
//                    33: index_a_4 <= 7'd36;
//                    34: index_a_4 <= 7'd36;
//                    35: index_a_4 <= 7'd36;
//                    36: index_a_4 <= 7'd36;
//                    37: index_a_4 <= 7'd36;
//                    38: index_a_4 <= 7'd36;
//                    39: index_a_4 <= 7'd36;
//                    40: index_a_4 <= 7'd44;
//                    41: index_a_4 <= 7'd44;
//                    42: index_a_4 <= 7'd44;
//                    43: index_a_4 <= 7'd44;
//                    44: index_a_4 <= 7'd44;
//                    45: index_a_4 <= 7'd44;
//                    46: index_a_4 <= 7'd44;
//                    47: index_a_4 <= 7'd44;
//                    48: index_a_4 <= 7'd52;
//                    49: index_a_4 <= 7'd52;
//                    50: index_a_4 <= 7'd52;
//                    51: index_a_4 <= 7'd52;
//                    52: index_a_4 <= 7'd52;
//                    53: index_a_4 <= 7'd52;
//                    54: index_a_4 <= 7'd52;
//                    55: index_a_4 <= 7'd52;
//                    56: index_a_4 <= 7'd60;
//                    57: index_a_4 <= 7'd60;
//                    58: index_a_4 <= 7'd60;
//                    59: index_a_4 <= 7'd60;
//                    60: index_a_4 <= 7'd60;
//                    61: index_a_4 <= 7'd60;
//                    62: index_a_4 <= 7'd60;
//                    63: index_a_4 <= 7'd60;
//                endcase

//                case (done_B_4)
//                    0: index_b_4 <= 7'd0;
//                    1: index_b_4 <= 7'd33;
//                    2: index_b_4 <= 7'd34;
//                    3: index_b_4 <= 7'd35;
//                    4: index_b_4 <= 7'd36;
//                    5: index_b_4 <= 7'd37;
//                    6: index_b_4 <= 7'd38;
//                    7: index_b_4 <= 7'd39;
//                    8: index_b_4 <= 7'd32;
//                    9: index_b_4 <= 7'd33;
//                    10: index_b_4 <= 7'd34;
//                    11: index_b_4 <= 7'd35;
//                    12: index_b_4 <= 7'd36;
//                    13: index_b_4 <= 7'd37;
//                    14: index_b_4 <= 7'd38;
//                    15: index_b_4 <= 7'd39;
//                    16: index_b_4 <= 7'd32;
//                    17: index_b_4 <= 7'd33;
//                    18: index_b_4 <= 7'd34;
//                    19: index_b_4 <= 7'd35;
//                    20: index_b_4 <= 7'd36;
//                    21: index_b_4 <= 7'd37;
//                    22: index_b_4 <= 7'd38;
//                    23: index_b_4 <= 7'd39;
//                    24: index_b_4 <= 7'd32;
//                    25: index_b_4 <= 7'd33;
//                    26: index_b_4 <= 7'd34;
//                    27: index_b_4 <= 7'd35;
//                    28: index_b_4 <= 7'd36;
//                    29: index_b_4 <= 7'd37;
//                    30: index_b_4 <= 7'd38;
//                    31: index_b_4 <= 7'd39;
//                    32: index_b_4 <= 7'd32;
//                    33: index_b_4 <= 7'd33;
//                    34: index_b_4 <= 7'd34;
//                    35: index_b_4 <= 7'd35;
//                    36: index_b_4 <= 7'd36;
//                    37: index_b_4 <= 7'd37;
//                    38: index_b_4 <= 7'd38;
//                    39: index_b_4 <= 7'd39;
//                    40: index_b_4 <= 7'd32;
//                    41: index_b_4 <= 7'd33;
//                    42: index_b_4 <= 7'd34;
//                    43: index_b_4 <= 7'd35;
//                    44: index_b_4 <= 7'd36;
//                    45: index_b_4 <= 7'd37;
//                    46: index_b_4 <= 7'd38;
//                    47: index_b_4 <= 7'd39;
//                    48: index_b_4 <= 7'd32;
//                    49: index_b_4 <= 7'd33;
//                    50: index_b_4 <= 7'd34;
//                    51: index_b_4 <= 7'd35;
//                    52: index_b_4 <= 7'd36;
//                    53: index_b_4 <= 7'd37;
//                    54: index_b_4 <= 7'd38;
//                    55: index_b_4 <= 7'd39;
//                    56: index_b_4 <= 7'd32;
//                    57: index_b_4 <= 7'd33;
//                    58: index_b_4 <= 7'd34;
//                    59: index_b_4 <= 7'd35;
//                    60: index_b_4 <= 7'd36;
//                    61: index_b_4 <= 7'd37;
//                    62: index_b_4 <= 7'd38;
//                    63: index_b_4 <= 7'd39;
//                endcase

//                state_4 <= LOAD_4;  // Load next vector values
//            end

//        endcase
//    end
//end


//            assign xor_out_4 = neg_col_4 ^ neg_row_4;
//            assign and_out_4 = unary_col_4 && unary_row_4;



//// Sixth State Machine

//    reg signed unary_col_5 ;
//    reg signed unary_row_5 ;
//    reg signed neg_row_5;
//    reg signed neg_col_5 ;
//    wire signed xor_out_5 ;
//    wire signed and_out_5 ;
//    reg signed [7:0] counta_5;
//    reg signed [7:0] countb_5;   // 8-bit counters
//    reg [7:0] index_a_5;            // Index for vector selection
//    reg [7:0] index_b_5;
//    reg [7:0] done_A_5;
//    reg [7:0] done_B_5;
//    reg [2:0] state_5;            // State variable
//  //   reg done_1;
////     reg signed [9:0] C00_5 [0:63];
//     reg signed [15:0] counter_5;
//    localparam IDLE_5     = 3'b00,  // IDLE state
//               LOAD_5     = 3'b01,  // Load state for vector values
//               COUNT_A_5  = 3'b10,  // Decrement/Increment counta state
//               COUNT_B_5  = 3'b11,  // Decrement/Increment countb state
//               CHANGE_5   = 3'b100;



//always @(posedge clk) begin
//        if (rst) begin
//            counta_5 <= 8'd0;
//            countb_5 <= 8'd0;
//            index_a_5 <= 7'd5;
//            index_b_5 <= 7'd40;
//            done_A_5 <= 0;
//            done_B_5 <= 0;
//            counter_5 <= 0;
//            unary_col_5 <= 0;
//            unary_row_5 <= 0;
//            neg_row_5 <= 0;
//            neg_col_5 <= 0;
            
//            n <= 0;
//            state_5 <= IDLE_5;
//            //done_1 <= 1'b0;
//        end else begin
//            case (state_5)
//                IDLE_3: begin
//                    // Wait in idle, start processing when index is within bounds
//                    if (index_a_5 < 7'd64) begin
//                        state_5 <= LOAD_5;
//                    end else begin
//                       // done_1 <= 1'b1;  // Done when all vectors processed
//                    end
//                end

//                LOAD_3: begin
//                    // Load the nth value from vector_a and vector_b into counta and countb
//                    counta_5 <= vector_a[index_a_5*8+:8];
//                    countb_5 <= vector_b[index_b_5*8+:8];
                    
                
//                    state_5 <= COUNT_A_5;  // Start with counta
//                end

//                COUNT_A_5: begin
                
//                if (counta_5 == 0) begin
//                        done_A_5 <= done_A_5 + 1;
//                        C00[n] = C00[n] + counter_5;
//                        done_B_5 <= done_B_5 + 1;
//                        state_5 <= CHANGE_5;
//                    end
//                    // First, decrement or increment counta
//                    else if (counta_5 > 0) begin
//                        counta_5 <= counta_5 - 1;
//                        state_5 <= COUNT_B_5;
//                    end else if (counta_5 < 0) begin
//                        counta_5 <= counta_5 + 1;
//                        state_5 <= COUNT_B_5;
//                    end

//                    if (counta_5 > 0) begin
//                      unary_col_5 <= 1;
//                      neg_col_5 <= 0; end
//                  else if  (counta_5 < 0) begin
//                       unary_col_5 <= 0;
//                       neg_col_5 <= 1; end
//                 if (countb_5 > 0)   begin 
//                      unary_row_5 <= 1;
//                      neg_row_5 <= 0; end
//                 else if (countb_5 < 0) begin
//                    unary_row_5 <= 0;
//                    neg_row_5 <= 1; end

//                    // After one decrement/increment of counta, go to countb state
                    
//                end

//                 COUNT_B_5: begin
//                // Now decrement or increment countb until it reaches 0
//                if (countb_5 > 0) begin
//                    countb_5 <= countb_5 - 1;
//                    if (xor_out_5 == 0) begin
             
//                counter_5 <= counter_5 + 1; end 
             
//             else if (xor_out_5 == 1) begin
             
//                counter_5 <= counter_5 - 1; end
//                end else if (countb_5 < 0) begin
//                    countb_5 <= countb_5 + 1;
//                    if (xor_out_5 == 0) begin
             
//                counter_5 <= counter_5 + 1; end 
             
//             else if (xor_out_5 == 1) begin
             
//                counter_5 <= counter_5 - 1; end
//                end else begin
//                    // When countb reaches 0, go back to counta if counta > 0
//                    if (counta_5 != 0) begin
//                        state_5 <= COUNT_A_5;  // Continue with counta
//                        countb_5 <= vector_b[index_b_5*8+:8];
//                    end else if (counta_5 == 0) begin
//                        done_A_5 <= done_A_5 + 1;
//                        C00[n] = C00[n] + counter_5;
//                        done_B_5 <= done_B_5 + 1;
//                        state_5 <= CHANGE_5;
//                    end
//                end
//            end

//            CHANGE_5: begin
            
//                n = n+1;
//                counter_5 <= 0;
//                // Both counta and countb are 0, load next values
//                case (done_A_5)
//                    0: index_a_5 <= 7'd0;
//                    1: index_a_5 <= 7'd5;
//                    2: index_a_5 <= 7'd5;
//                    3: index_a_5 <= 7'd5;
//                    4: index_a_5 <= 7'd5;
//                    5: index_a_5 <= 7'd5;
//                    6: index_a_5 <= 7'd5;
//                    7: index_a_5 <= 7'd5;
//                    8: index_a_5 <= 7'd13;
//                    9: index_a_5 <= 7'd13;
//                    10: index_a_5 <= 7'd13;
//                    11: index_a_5 <= 7'd13;
//                    12: index_a_5 <= 7'd13;
//                    13: index_a_5 <= 7'd13;
//                    14: index_a_5 <= 7'd13;
//                    15: index_a_5 <= 7'd13;
//                    16: index_a_5 <= 7'd21;
//                    17: index_a_5 <= 7'd21;
//                    18: index_a_5 <= 7'd21;
//                    19: index_a_5 <= 7'd21;
//                    20: index_a_5 <= 7'd21;
//                    21: index_a_5 <= 7'd21;
//                    22: index_a_5 <= 7'd21;
//                    23: index_a_5 <= 7'd21;
//                    24: index_a_5 <= 7'd29;
//                    25: index_a_5 <= 7'd29;
//                    26: index_a_5 <= 7'd29;
//                    27: index_a_5 <= 7'd29;
//                    28: index_a_5 <= 7'd29;
//                    29: index_a_5 <= 7'd29;
//                    30: index_a_5 <= 7'd29;
//                    31: index_a_5 <= 7'd29;
//                    32: index_a_5 <= 7'd37;
//                    33: index_a_5 <= 7'd37;
//                    34: index_a_5 <= 7'd37;
//                    35: index_a_5 <= 7'd37;
//                    36: index_a_5 <= 7'd37;
//                    37: index_a_5 <= 7'd37;
//                    38: index_a_5 <= 7'd37;
//                    39: index_a_5 <= 7'd37;
//                    40: index_a_5 <= 7'd45;
//                    41: index_a_5 <= 7'd45;
//                    42: index_a_5 <= 7'd45;
//                    43: index_a_5 <= 7'd45;
//                    44: index_a_5 <= 7'd45;
//                    45: index_a_5 <= 7'd45;
//                    46: index_a_5 <= 7'd45;
//                    47: index_a_5 <= 7'd45;
//                    48: index_a_5 <= 7'd53;
//                    49: index_a_5 <= 7'd53;
//                    50: index_a_5 <= 7'd53;
//                    51: index_a_5 <= 7'd53;
//                    52: index_a_5 <= 7'd53;
//                    53: index_a_5 <= 7'd53;
//                    54: index_a_5 <= 7'd53;
//                    55: index_a_5 <= 7'd53;
//                    56: index_a_5 <= 7'd61;
//                    57: index_a_5 <= 7'd61;
//                    58: index_a_5 <= 7'd61;
//                    59: index_a_5 <= 7'd61;
//                    60: index_a_5 <= 7'd61;
//                    61: index_a_5 <= 7'd61;
//                    62: index_a_5 <= 7'd61;
//                    63: index_a_5 <= 7'd61;
//                endcase

//                case (done_B_5)
//                    0: index_b_5 <= 7'd0;
//                    1: index_b_5 <= 7'd41;
//                    2: index_b_5 <= 7'd42;
//                    3: index_b_5 <= 7'd43;
//                    4: index_b_5 <= 7'd44;
//                    5: index_b_5 <= 7'd45;
//                    6: index_b_5 <= 7'd46;
//                    7: index_b_5 <= 7'd47;
//                    8: index_b_5 <= 7'd40;
//                    9: index_b_5 <= 7'd41;
//                    10: index_b_5 <= 7'd42;
//                    11: index_b_5 <= 7'd43;
//                    12: index_b_5 <= 7'd44;
//                    13: index_b_5 <= 7'd45;
//                    14: index_b_5 <= 7'd46;
//                    15: index_b_5 <= 7'd47;
//                    16: index_b_5 <= 7'd40;
//                    17: index_b_5 <= 7'd41;
//                    18: index_b_5 <= 7'd42;
//                    19: index_b_5 <= 7'd43;
//                    20: index_b_5 <= 7'd44;
//                    21: index_b_5 <= 7'd45;
//                    22: index_b_5 <= 7'd46;
//                    23: index_b_5 <= 7'd47;
//                    24: index_b_5 <= 7'd40;
//                    25: index_b_5 <= 7'd41;
//                    26: index_b_5 <= 7'd42;
//                    27: index_b_5 <= 7'd43;
//                    28: index_b_5 <= 7'd44;
//                    29: index_b_5 <= 7'd45;
//                    30: index_b_5 <= 7'd46;
//                    31: index_b_5 <= 7'd47;
//                    32: index_b_5 <= 7'd40;
//                    33: index_b_5 <= 7'd41;
//                    34: index_b_5 <= 7'd42;
//                    35: index_b_5 <= 7'd43;
//                    36: index_b_5 <= 7'd44;
//                    37: index_b_5 <= 7'd45;
//                    38: index_b_5 <= 7'd46;
//                    39: index_b_5 <= 7'd47;
//                    40: index_b_5 <= 7'd40;
//                    41: index_b_5 <= 7'd41;
//                    42: index_b_5 <= 7'd42;
//                    43: index_b_5 <= 7'd43;
//                    44: index_b_5 <= 7'd44;
//                    45: index_b_5 <= 7'd45;
//                    46: index_b_5 <= 7'd46;
//                    47: index_b_5 <= 7'd47;
//                    48: index_b_5 <= 7'd40;
//                    49: index_b_5 <= 7'd41;
//                    50: index_b_5 <= 7'd42;
//                    51: index_b_5 <= 7'd43;
//                    52: index_b_5 <= 7'd44;
//                    53: index_b_5 <= 7'd45;
//                    54: index_b_5 <= 7'd46;
//                    55: index_b_5 <= 7'd47;
//                    56: index_b_5 <= 7'd40;
//                    57: index_b_5 <= 7'd41;
//                    58: index_b_5 <= 7'd42;
//                    59: index_b_5 <= 7'd43;
//                    60: index_b_5 <= 7'd44;
//                    61: index_b_5 <= 7'd45;
//                    62: index_b_5 <= 7'd46;
//                    63: index_b_5 <= 7'd47;
//                endcase

//                state_5 <= LOAD_5;  // Load next vector values
//            end

//        endcase
//    end
//end


//            assign xor_out_5 = neg_col_5 ^ neg_row_5;
//            assign and_out_5 = unary_col_5 && unary_row_5;






//// Seventh State Machine


//reg signed unary_col_6 ;
//    reg signed unary_row_6 ;
//    reg signed neg_row_6;
//    reg signed neg_col_6 ;
//    wire signed xor_out_6 ;
//    wire signed and_out_6 ;
//    reg signed [7:0] counta_6;
//    reg signed [7:0] countb_6;   // 8-bit counters
//    reg [7:0] index_a_6;            // Index for vector selection
//    reg [7:0] index_b_6;
//    reg [7:0] done_A_6;
//    reg [7:0] done_B_6;
//    reg [2:0] state_6;            // State variable
//  //   reg done_1;
////     reg signed [9:0] C00_6 [0:63];
//     reg signed [15:0] counter_6;
//    localparam IDLE_6     = 3'b00,  // IDLE state
//               LOAD_6     = 3'b01,  // Load state for vector values
//               COUNT_A_6  = 3'b10,  // Decrement/Increment counta state
//               COUNT_B_6  = 3'b11,  // Decrement/Increment countb state
//               CHANGE_6   = 3'b100;



//always @(posedge clk) begin
//        if (rst) begin
//            counta_6 <= 8'd0;
//            countb_6 <= 8'd0;
//            index_a_6 <= 7'd6;
//            index_b_6 <= 7'd48;
//            done_A_6 <= 0;
//            done_B_6 <= 0;
//            counter_6 <= 0;
//            unary_col_6 <= 0;
//            unary_row_6 <= 0;
//            neg_row_6 <= 0;
//            neg_col_6 <= 0;
            
//            o <= 0;
//            state_6 <= IDLE_6;
//            //done_1 <= 1'b0;
//        end else begin
//            case (state_6)
//                IDLE_3: begin
//                    // Wait in idle, start processing when index is within bounds
//                    if (index_a_6 < 7'd64) begin
//                        state_6 <= LOAD_6;
//                    end else begin
//                       // done_1 <= 1'b1;  // Done when all vectors processed
//                    end
//                end

//                LOAD_3: begin
//                    // Load the nth value from vector_a and vector_b into counta and countb
//                    counta_6 <= vector_a[index_a_6*8+:8];
//                    countb_6 <= vector_b[index_b_6*8+:8];
                    
                
//                    state_6 <= COUNT_A_6;  // Start with counta
//                end

//                COUNT_A_6: begin
//                if (counta_6 == 0) begin
//                        done_A_6 <= done_A_6 + 1;
//                        C00[o] = C00[o] + counter_6;
//                        done_B_6 <= done_B_6 + 1;
//                        state_6 <= CHANGE_6;
//                    end
//                    // First, decrement or increment counta
//                   else if (counta_6 > 0) begin
//                        counta_6 <= counta_6 - 1;
//                        state_6 <= COUNT_B_6;
//                    end else if (counta_6 < 0) begin
//                        counta_6 <= counta_6 + 1;
//                        state_6 <= COUNT_B_6;
//                    end

//                    if (counta_6 > 0) begin
//                      unary_col_6 <= 1;
//                      neg_col_6 <= 0; end
//                  else if  (counta_6 < 0) begin
//                       unary_col_6 <= 0;
//                       neg_col_6 <= 1; end
//                 if (countb_6 > 0)   begin 
//                      unary_row_6 <= 1;
//                      neg_row_6 <= 0; end
//                 else if (countb_6 < 0) begin
//                    unary_row_6 <= 0;
//                    neg_row_6 <= 1; end

//                    // After one decrement/increment of counta, go to countb state
                    
//                end

//                 COUNT_B_6: begin
//                // Now decrement or increment countb until it reaches 0
//                if (countb_6 > 0) begin
//                    countb_6 <= countb_6 - 1;
//                    if (xor_out_6 == 0) begin
             
//                counter_6 <= counter_6 + 1; end 
             
//             else if (xor_out_6 == 1) begin
             
//                counter_6 <= counter_6 - 1; end
//                end else if (countb_6 < 0) begin
//                    countb_6 <= countb_6 + 1;
//                    if (xor_out_6 == 0) begin
             
//                counter_6 <= counter_6 + 1; end 
             
//             else if (xor_out_6 == 1) begin
             
//                counter_6 <= counter_6 - 1; end
//                end else begin
//                    // When countb reaches 0, go back to counta if counta > 0
//                    if (counta_6 != 0) begin
//                        state_6 <= COUNT_A_6;  // Continue with counta
//                        countb_6 <= vector_b[index_b_6*8+:8];
//                    end else if (counta_6 == 0) begin
//                        done_A_6 <= done_A_6 + 1;
//                        C00[o] = C00[o] + counter_6;
//                        done_B_6 <= done_B_6 + 1;
//                        state_6 <= CHANGE_6;
//                    end
//                end
//            end

//            CHANGE_6: begin
            
//                o = o + 1;
//                counter_6 <= 0;
//                // Both counta and countb are 0, load next values
//                case (done_A_6)
//                    0: index_a_6 <= 7'd0;
//                    1: index_a_6 <= 7'd6;
//                    2: index_a_6 <= 7'd6;
//                    3: index_a_6 <= 7'd6;
//                    4: index_a_6 <= 7'd6;
//                    5: index_a_6 <= 7'd6;
//                    6: index_a_6 <= 7'd6;
//                    7: index_a_6 <= 7'd6;
//                    8: index_a_6 <= 7'd14;
//                    9: index_a_6 <= 7'd14;
//                    10: index_a_6 <= 7'd14;
//                    11: index_a_6 <= 7'd14;
//                    12: index_a_6 <= 7'd14;
//                    13: index_a_6 <= 7'd14;
//                    14: index_a_6 <= 7'd14;
//                    15: index_a_6 <= 7'd14;
//                    16: index_a_6 <= 7'd22;
//                    17: index_a_6 <= 7'd22;
//                    18: index_a_6 <= 7'd22;
//                    19: index_a_6 <= 7'd22;
//                    20: index_a_6 <= 7'd22;
//                    21: index_a_6 <= 7'd22;
//                    22: index_a_6 <= 7'd22;
//                    23: index_a_6 <= 7'd22;
//                    24: index_a_6 <= 7'd30;
//                    25: index_a_6 <= 7'd30;
//                    26: index_a_6 <= 7'd30;
//                    27: index_a_6 <= 7'd30;
//                    28: index_a_6 <= 7'd30;
//                    29: index_a_6 <= 7'd30;
//                    30: index_a_6 <= 7'd30;
//                    31: index_a_6 <= 7'd30;
//                    32: index_a_6 <= 7'd38;
//                    33: index_a_6 <= 7'd38;
//                    34: index_a_6 <= 7'd38;
//                    35: index_a_6 <= 7'd38;
//                    36: index_a_6 <= 7'd38;
//                    37: index_a_6 <= 7'd38;
//                    38: index_a_6 <= 7'd38;
//                    39: index_a_6 <= 7'd38;
//                    40: index_a_6 <= 7'd46;
//                    41: index_a_6 <= 7'd46;
//                    42: index_a_6 <= 7'd46;
//                    43: index_a_6 <= 7'd46;
//                    44: index_a_6 <= 7'd46;
//                    45: index_a_6 <= 7'd46;
//                    46: index_a_6 <= 7'd46;
//                    47: index_a_6 <= 7'd46;
//                    48: index_a_6 <= 7'd54;
//                    49: index_a_6 <= 7'd54;
//                    50: index_a_6 <= 7'd54;
//                    51: index_a_6 <= 7'd54;
//                    52: index_a_6 <= 7'd54;
//                    53: index_a_6 <= 7'd54;
//                    54: index_a_6 <= 7'd54;
//                    55: index_a_6 <= 7'd54;
//                    56: index_a_6 <= 7'd62;
//                    57: index_a_6 <= 7'd62;
//                    58: index_a_6 <= 7'd62;
//                    59: index_a_6 <= 7'd62;
//                    60: index_a_6 <= 7'd62;
//                    61: index_a_6 <= 7'd62;
//                    62: index_a_6 <= 7'd62;
//                    63: index_a_6 <= 7'd62;
//                endcase

//                case (done_B_6)
//                    0: index_b_6 <= 7'd0;
//                    1: index_b_6 <= 7'd49;
//                    2: index_b_6 <= 7'd50;
//                    3: index_b_6 <= 7'd51;
//                    4: index_b_6 <= 7'd52;
//                    5: index_b_6 <= 7'd53;
//                    6: index_b_6 <= 7'd54;
//                    7: index_b_6 <= 7'd55;
//                    8: index_b_6 <= 7'd48;
//                    9: index_b_6 <= 7'd49;
//                    10: index_b_6 <= 7'd50;
//                    11: index_b_6 <= 7'd51;
//                    12: index_b_6 <= 7'd52;
//                    13: index_b_6 <= 7'd53;
//                    14: index_b_6 <= 7'd54;
//                    15: index_b_6 <= 7'd55;
//                    16: index_b_6 <= 7'd48;
//                    17: index_b_6 <= 7'd49;
//                    18: index_b_6 <= 7'd50;
//                    19: index_b_6 <= 7'd51;
//                    20: index_b_6 <= 7'd52;
//                    21: index_b_6 <= 7'd53;
//                    22: index_b_6 <= 7'd54;
//                    23: index_b_6 <= 7'd55;
//                    24: index_b_6 <= 7'd48;
//                    25: index_b_6 <= 7'd49;
//                    26: index_b_6 <= 7'd50;
//                    27: index_b_6 <= 7'd51;
//                    28: index_b_6 <= 7'd52;
//                    29: index_b_6 <= 7'd53;
//                    30: index_b_6 <= 7'd54;
//                    31: index_b_6 <= 7'd55;
//                    32: index_b_6 <= 7'd48;
//                    33: index_b_6 <= 7'd49;
//                    34: index_b_6 <= 7'd50;
//                    35: index_b_6 <= 7'd51;
//                    36: index_b_6 <= 7'd52;
//                    37: index_b_6 <= 7'd53;
//                    38: index_b_6 <= 7'd54;
//                    39: index_b_6 <= 7'd55;
//                    40: index_b_6 <= 7'd48;
//                    41: index_b_6 <= 7'd49;
//                    42: index_b_6 <= 7'd50;
//                    43: index_b_6 <= 7'd51;
//                    44: index_b_6 <= 7'd52;
//                    45: index_b_6 <= 7'd53;
//                    46: index_b_6 <= 7'd54;
//                    47: index_b_6 <= 7'd55;
//                    48: index_b_6 <= 7'd48;
//                    49: index_b_6 <= 7'd49;
//                    50: index_b_6 <= 7'd50;
//                    51: index_b_6 <= 7'd51;
//                    52: index_b_6 <= 7'd52;
//                    53: index_b_6 <= 7'd53;
//                    54: index_b_6 <= 7'd54;
//                    55: index_b_6 <= 7'd55;
//                    56: index_b_6 <= 7'd48;
//                    57: index_b_6 <= 7'd49;
//                    58: index_b_6 <= 7'd50;
//                    59: index_b_6 <= 7'd51;
//                    60: index_b_6 <= 7'd52;
//                    61: index_b_6 <= 7'd53;
//                    62: index_b_6 <= 7'd54;
//                    63: index_b_6 <= 7'd55;
//                endcase

//                state_6 <= LOAD_6;  // Load next vector values
//            end

//        endcase
//    end
//end


//            assign xor_out_6 = neg_col_6 ^ neg_row_6;
//            assign and_out_6 = unary_col_6 && unary_row_6;


//// Eigth State Machine

//reg signed unary_col_7 ;
//    reg signed unary_row_7 ;
//    reg signed neg_row_7;
//    reg signed neg_col_7 ;
//    wire signed xor_out_7 ;
//    wire signed and_out_7 ;
//    reg signed [7:0] counta_7;
//    reg signed [7:0] countb_7;   // 8-bit counters
//    reg [7:0] index_a_7;            // Index for vector selection
//    reg [7:0] index_b_7;
//    reg [7:0] done_A_7;
//    reg [7:0] done_B_7;
//    reg [2:0] state_7;            // State variable
//  //   reg done_1;
////     reg signed [9:0] C00_7 [0:63];
//     reg signed [15:0] counter_7;
//    localparam IDLE_7     = 3'b00,  // IDLE state
//               LOAD_7     = 3'b01,  // Load state for vector values
//               COUNT_A_7  = 3'b10,  // Decrement/Increment counta state
//               COUNT_B_7  = 3'b11,  // Decrement/Increment countb state
//               CHANGE_7   = 3'b100;



//always @(posedge clk) begin
//        if (rst) begin
//            counta_7 <= 8'd0;
//            countb_7 <= 8'd0;
//            index_a_7 <= 7'd7;
//            index_b_7 <= 7'd56;
//            done_A_7 <= 0;
//            done_B_7 <= 0;
//            counter_7 <= 0;
//            unary_col_7 <= 0;
//            unary_row_7 <= 0;
//            neg_row_7 <= 0;
//            neg_col_7 <= 0;
            
//            p <= 0;
//            state_7 <= IDLE_7;
//            //done_1 <= 1'b0;
//        end else begin
//            case (state_7)
//                IDLE_3: begin
//                    // Wait in idle, start processing when index is within bounds
//                    if (index_a_7 < 7'd64) begin
//                        state_7 <= LOAD_7;
//                    end else begin
//                       // done_1 <= 1'b1;  // Done when all vectors processed
//                    end
//                end

//                LOAD_3: begin
//                    // Load the nth value from vector_a and vector_b into counta and countb
//                    counta_7 <= vector_a[index_a_7*8+:8];
//                    countb_7 <= vector_b[index_b_7*8+:8];
                    
                
//                    state_7 <= COUNT_A_7;  // Start with counta
//                end

//                COUNT_A_7: begin
                
//                if (counta_7 == 0) begin
//                        done_A_7 <= done_A_7 + 1;
//                        C00[p] = C00[p] + counter_7;
//                        done_B_7 <= done_B_7 + 1;
//                        state_7 <= CHANGE_7;
//                    end
//                    // First, decrement or increment counta
//                   else if (counta_7 > 0) begin
//                        counta_7 <= counta_7 - 1;
//                        state_7 <= COUNT_B_7;
//                    end else if (counta_7 < 0) begin
//                        counta_7 <= counta_7 + 1;
//                        state_7 <= COUNT_B_7;
//                    end

//                    if (counta_7 > 0) begin
//                      unary_col_7 <= 1;
//                      neg_col_7 <= 0; end
//                  else if  (counta_7 < 0) begin
//                       unary_col_7 <= 0;
//                       neg_col_7 <= 1; end
//                 if (countb_7 > 0)   begin 
//                      unary_row_7 <= 1;
//                      neg_row_7 <= 0; end
//                 else if (countb_7 < 0) begin
//                    unary_row_7 <= 0;
//                    neg_row_7 <= 1; end

//                    // After one decrement/increment of counta, go to countb state
                    
//                end

//                 COUNT_B_7: begin
//                // Now decrement or increment countb until it reaches 0
//                if (countb_7 > 0) begin
//                    countb_7 <= countb_7 - 1;
//                    if (xor_out_7 == 0) begin
             
//                counter_7 <= counter_7 + 1; end 
             
//             else if (xor_out_7 == 1) begin
             
//                counter_7 <= counter_7 - 1; end
//                end else if (countb_7 < 0) begin
//                    countb_7 <= countb_7 + 1;
//                    if (xor_out_7 == 0) begin
             
//                counter_7 <= counter_7 + 1; end 
             
//             else if (xor_out_7 == 1) begin
             
//                counter_7 <= counter_7 - 1; end
//                end else begin
//                    // When countb reaches 0, go back to counta if counta > 0
//                    if (counta_7 != 0) begin
//                        state_7 <= COUNT_A_7;  // Continue with counta
//                        countb_7 <= vector_b[index_b_7*8+:8];
//                    end else if (counta_7 == 0) begin
//                        done_A_7 <= done_A_7 + 1;
//                        C00[p] = C00[p] + counter_7;
//                        done_B_7 <= done_B_7 + 1;
//                        state_7 <= CHANGE_7;
//                    end
//                end
//            end

//            CHANGE_7: begin
            
//                p = p+1;
//                counter_7 <= 0;
//                // Both counta and countb are 0, load next values
//                case (done_A_7)
//                    0: index_a_7 <= 7'd0;
//                    1: index_a_7 <= 7'd7;
//                    2: index_a_7 <= 7'd7;
//                    3: index_a_7 <= 7'd7;
//                    4: index_a_7 <= 7'd7;
//                    5: index_a_7 <= 7'd7;
//                    6: index_a_7 <= 7'd7;
//                    7: index_a_7 <= 7'd7;
//                    8: index_a_7 <= 7'd15;
//                    9: index_a_7 <= 7'd15;
//                    10: index_a_7 <= 7'd15;
//                    11: index_a_7 <= 7'd15;
//                    12: index_a_7 <= 7'd15;
//                    13: index_a_7 <= 7'd15;
//                    14: index_a_7 <= 7'd15;
//                    15: index_a_7 <= 7'd15;
//                    16: index_a_7 <= 7'd23;
//                    17: index_a_7 <= 7'd23;
//                    18: index_a_7 <= 7'd23;
//                    19: index_a_7 <= 7'd23;
//                    20: index_a_7 <= 7'd23;
//                    21: index_a_7 <= 7'd23;
//                    22: index_a_7 <= 7'd23;
//                    23: index_a_7 <= 7'd23;
//                    24: index_a_7 <= 7'd31;
//                    25: index_a_7 <= 7'd31;
//                    26: index_a_7 <= 7'd31;
//                    27: index_a_7 <= 7'd31;
//                    28: index_a_7 <= 7'd31;
//                    29: index_a_7 <= 7'd31;
//                    30: index_a_7 <= 7'd31;
//                    31: index_a_7 <= 7'd31;
//                    32: index_a_7 <= 7'd39;
//                    33: index_a_7 <= 7'd39;
//                    34: index_a_7 <= 7'd39;
//                    35: index_a_7 <= 7'd39;
//                    36: index_a_7 <= 7'd39;
//                    37: index_a_7 <= 7'd39;
//                    38: index_a_7 <= 7'd39;
//                    39: index_a_7 <= 7'd39;
//                    40: index_a_7 <= 7'd47;
//                    41: index_a_7 <= 7'd47;
//                    42: index_a_7 <= 7'd47;
//                    43: index_a_7 <= 7'd47;
//                    44: index_a_7 <= 7'd47;
//                    45: index_a_7 <= 7'd47;
//                    46: index_a_7 <= 7'd47;
//                    47: index_a_7 <= 7'd47;
//                    48: index_a_7 <= 7'd55;
//                    49: index_a_7 <= 7'd55;
//                    50: index_a_7 <= 7'd55;
//                    51: index_a_7 <= 7'd55;
//                    52: index_a_7 <= 7'd55;
//                    53: index_a_7 <= 7'd55;
//                    54: index_a_7 <= 7'd55;
//                    55: index_a_7 <= 7'd55;
//                    56: index_a_7 <= 7'd63;
//                    57: index_a_7 <= 7'd63;
//                    58: index_a_7 <= 7'd63;
//                    59: index_a_7 <= 7'd63;
//                    60: index_a_7 <= 7'd63;
//                    61: index_a_7 <= 7'd63;
//                    62: index_a_7 <= 7'd63;
//                    63: index_a_7 <= 7'd63;
//                endcase

//                case (done_B_7)
//                    0: index_b_7 <= 7'd0;
//                    1: index_b_7 <= 7'd57;
//                    2: index_b_7 <= 7'd58;
//                    3: index_b_7 <= 7'd59;
//                    4: index_b_7 <= 7'd60;
//                    5: index_b_7 <= 7'd61;
//                    6: index_b_7 <= 7'd62;
//                    7: index_b_7 <= 7'd63;
//                    8: index_b_7 <= 7'd56;
//                    9: index_b_7 <= 7'd57;
//                    10: index_b_7 <= 7'd58;
//                    11: index_b_7 <= 7'd59;
//                    12: index_b_7 <= 7'd60;
//                    13: index_b_7 <= 7'd61;
//                    14: index_b_7 <= 7'd62;
//                    15: index_b_7 <= 7'd63;
//                    16: index_b_7 <= 7'd56;
//                    17: index_b_7 <= 7'd57;
//                    18: index_b_7 <= 7'd58;
//                    19: index_b_7 <= 7'd59;
//                    20: index_b_7 <= 7'd60;
//                    21: index_b_7 <= 7'd61;
//                    22: index_b_7 <= 7'd62;
//                    23: index_b_7 <= 7'd63;
//                    24: index_b_7 <= 7'd56;
//                    25: index_b_7 <= 7'd57;
//                    26: index_b_7 <= 7'd58;
//                    27: index_b_7 <= 7'd59;
//                    28: index_b_7 <= 7'd60;
//                    29: index_b_7 <= 7'd61;
//                    30: index_b_7 <= 7'd62;
//                    31: index_b_7 <= 7'd63;
//                    32: index_b_7 <= 7'd56;
//                    33: index_b_7 <= 7'd57;
//                    34: index_b_7 <= 7'd58;
//                    35: index_b_7 <= 7'd59;
//                    36: index_b_7 <= 7'd60;
//                    37: index_b_7 <= 7'd61;
//                    38: index_b_7 <= 7'd62;
//                    39: index_b_7 <= 7'd63;
//                    40: index_b_7 <= 7'd56;
//                    41: index_b_7 <= 7'd57;
//                    42: index_b_7 <= 7'd58;
//                    43: index_b_7 <= 7'd59;
//                    44: index_b_7 <= 7'd60;
//                    45: index_b_7 <= 7'd61;
//                    46: index_b_7 <= 7'd62;
//                    47: index_b_7 <= 7'd63;
//                    48: index_b_7 <= 7'd56;
//                    49: index_b_7 <= 7'd57;
//                    50: index_b_7 <= 7'd58;
//                    51: index_b_7 <= 7'd59;
//                    52: index_b_7 <= 7'd60;
//                    53: index_b_7 <= 7'd61;
//                    54: index_b_7 <= 7'd62;
//                    55: index_b_7 <= 7'd63;
//                    56: index_b_7 <= 7'd56;
//                    57: index_b_7 <= 7'd57;
//                    58: index_b_7 <= 7'd58;
//                    59: index_b_7 <= 7'd59;
//                    60: index_b_7 <= 7'd60;
//                    61: index_b_7 <= 7'd61;
//                    62: index_b_7 <= 7'd62;
//                    63: index_b_7 <= 7'd63;
//                endcase

//                state_7 <= LOAD_7;  // Load next vector values
//            end

//        endcase
//    end
//end


//            assign xor_out_7 = neg_col_7 ^ neg_row_7;
//            assign and_out_7 = unary_col_7 && unary_row_7;







//        assign Row_00 = C00[0];
//        assign Row_01 = C00[1] ;
//        assign Row_02 = C00[2] ;
//        assign Row_03 = C00[3];
//        assign Row_04 = C00[4];
//        assign Row_05 = C00[5];
//        assign Row_06 = C00[6];
//        assign Row_07 = C00[7];
//        assign Row_10 = C00[8];
//        assign Row_11 = C00[9];
//        assign Row_12 = C00[10];
//        assign Row_13 = C00[11];
//        assign Row_14 = C00[12];
//        assign Row_15 = C00[13];
//        assign Row_16 = C00[14];
//        assign Row_17 = C00[15];
//        assign Row_20 = C00[16];
//        assign Row_21 = C00[17];
//        assign Row_22 = C00[18];
//        assign Row_23 = C00[19];
//        assign Row_24 = C00[20];
//        assign Row_25 = C00[21];
//        assign Row_26 = C00[22];
//        assign Row_27 = C00[23];
//        assign Row_30 = C00[24];
//        assign Row_31 = C00[25];
//        assign Row_32 = C00[26];
//        assign Row_33 = C00[27];
//        assign Row_34 = C00[28];
//        assign Row_35 = C00[29];
//        assign Row_36 = C00[30];
//        assign Row_37 =  C00[31];
//        assign Row_40 = C00[32];
//        assign Row_41 = C00[33];
//        assign Row_42 = C00[34];
//        assign Row_43 = C00[35];
//        assign Row_44 = C00[36];
//        assign Row_45 = C00[37];
//        assign Row_46 = C00[38];
//        assign Row_47 = C00[39];
//        assign Row_50 = C00[40];
//        assign Row_51 = C00[41];
//        assign Row_52 = C00[42] ;
//        assign Row_53 = C00[43];
//        assign Row_54 = C00[44];
//        assign Row_55 = C00[45];
//        assign Row_56 = C00[46];         
//        assign Row_57 = C00[47];
//        assign Row_60 = C00[48];
//        assign Row_61 = C00[49];
//        assign Row_62 = C00[50];
//        assign Row_63 = C00[51];
//        assign Row_64 = C00[52];
//        assign Row_65 = C00[53];
//        assign Row_66 = C00[54];
//        assign Row_67 = C00[55];
//        assign Row_70 = C00[56];
//        assign Row_71 = C00[57];
//        assign Row_72 = C00[58];
//        assign Row_73 = C00[59];
//        assign Row_74 = C00[60];
//        assign Row_75 = C00[61];
//        assign Row_76 = C00[62];
//        assign Row_77 = C00[63];


//endmodule



`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.09.2024 07:20:03
// Design Name: 
// Module Name: tuGEMM_4
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tuGEMM_8x8(
input clk,
input rst,
input [511:0] vector_a,
input [511:0] vector_b,
output reg signed [15:0] Row_00,
output reg signed [15:0] Row_01,
output reg signed [15:0] Row_02,
output reg signed [15:0] Row_03,
output reg signed [15:0] Row_04,
output reg signed [15:0] Row_05,
output reg signed [15:0] Row_06,
output reg signed [15:0] Row_07,
output reg signed [15:0] Row_10,
output reg signed [15:0] Row_11,
output reg signed [15:0] Row_12,
output reg signed [15:0] Row_13,
output reg signed [15:0] Row_14,
output reg signed [15:0] Row_15,
output reg signed [15:0] Row_16,
output reg signed [15:0] Row_17,
output reg signed [15:0] Row_20,
output reg signed [15:0] Row_21,
output reg signed [15:0] Row_22,
output reg signed [15:0] Row_23,
output reg signed [15:0] Row_24,
output reg signed [15:0] Row_25,
output reg signed [15:0] Row_26,
output reg signed [15:0] Row_27,
output reg signed [15:0] Row_30,
output reg signed [15:0] Row_31,
output reg signed [15:0] Row_32,
output reg signed [15:0] Row_33,
output reg signed [15:0] Row_34,
output reg signed [15:0] Row_35,
output reg signed [15:0] Row_36,
output reg signed [15:0] Row_37,
output reg signed [15:0] Row_40,
output reg signed [15:0] Row_41,
output reg signed [15:0] Row_42,
output reg signed [15:0] Row_43,
output reg signed [15:0] Row_44,
output reg signed [15:0] Row_45,
output reg signed [15:0] Row_46,
output reg signed [15:0] Row_47,
output reg signed [15:0] Row_50,
output reg signed [15:0] Row_51,
output reg signed [15:0] Row_52,
output reg signed [15:0] Row_53,
output reg signed [15:0] Row_54,
output reg signed [15:0] Row_55,
output reg signed [15:0] Row_56,
output reg signed [15:0] Row_57,
output reg signed [15:0] Row_60,
output reg signed [15:0] Row_61,
output reg signed [15:0] Row_62,
output reg signed [15:0] Row_63,
output reg signed [15:0] Row_64,
output reg signed [15:0] Row_65,
output reg signed [15:0] Row_66,
output reg signed [15:0] Row_67,
output reg signed [15:0] Row_70,
output reg signed [15:0] Row_71,
output reg signed [15:0] Row_72,
output reg signed [15:0] Row_73,
output reg signed [15:0] Row_74,
output reg signed [15:0] Row_75,
output reg signed [15:0] Row_76,
output reg signed [15:0] Row_77

    );
    
//     reg signed [15:0] Row_00;
// reg signed [15:0] Row_01;
// reg signed [15:0] Row_02;
// reg signed [15:0] Row_03;
// reg signed [15:0] Row_04;
// reg signed [15:0] Row_05;
// reg signed [15:0] Row_06;
// reg signed [15:0] Row_07;
// reg signed [15:0] Row_10;
// reg signed [15:0] Row_11;
// reg signed [15:0] Row_12;
// reg signed [15:0] Row_13;
// reg signed [15:0] Row_14;
// reg signed [15:0] Row_15;
// reg signed [15:0] Row_16;
// reg signed [15:0] Row_17;
// reg signed [15:0] Row_20;
// reg signed [15:0] Row_21;
// reg signed [15:0] Row_22;
// reg signed [15:0] Row_23;
// reg signed [15:0] Row_24;
// reg signed [15:0] Row_25;
// reg signed [15:0] Row_26;
// reg signed [15:0] Row_27;
// reg signed [15:0] Row_30;
// reg signed [15:0] Row_31;
// reg signed [15:0] Row_32;
// reg signed [15:0] Row_33;
// reg signed [15:0] Row_34;
// reg signed [15:0] Row_35;
// reg signed [15:0] Row_36;
// reg signed [15:0] Row_37;
// reg signed [15:0] Row_40;
// reg signed [15:0] Row_41;
// reg signed [15:0] Row_42;
// reg signed [15:0] Row_43;
// reg signed [15:0] Row_44;
// reg signed [15:0] Row_45;
// reg signed [15:0] Row_46;
// reg signed [15:0] Row_47;
// reg signed [15:0] Row_50;
// reg signed [15:0] Row_51;
// reg signed [15:0] Row_52;
// reg signed [15:0] Row_53;
// reg signed [15:0] Row_54;
// reg signed [15:0] Row_55;
// reg signed [15:0] Row_56;
// reg signed [15:0] Row_57;
// reg signed [15:0] Row_60;
// reg signed [15:0] Row_61;
// reg signed [15:0] Row_62;
// reg signed [15:0] Row_63;
// reg signed [15:0] Row_64;
// reg signed [15:0] Row_65;
// reg signed [15:0] Row_66;
// reg signed [15:0] Row_67;
// reg signed [15:0] Row_70;
// reg signed [15:0] Row_71;
// reg signed [15:0] Row_72;
// reg signed [15:0] Row_73;
// reg signed [15:0] Row_74;
// reg signed [15:0] Row_75;
// reg signed [15:0] Row_76;
// reg signed [15:0] Row_77;
    
    
integer i,j;
integer k,l;
integer m, n;
integer o, p;

// reg [7:0] store_A[15:0];
// reg [7:0] store_B [15:0];

    reg signed unary_col ;
   reg signed unary_row ;
   reg signed neg_row;
   reg signed neg_col ;
   wire signed xor_out ;
   wire signed and_out;
    reg  signed[7:0] counta;
    reg signed [7:0] countb;   // 8-bit counters
    reg [7:0] index_a;            // Index for vector selection
    reg [7:0] index_b;
    reg [7:0] done_A;
    reg [7:0] done_B;
    reg [2:0] state;            // State variable
     reg done;
     reg signed [15:0] C00 [0:63];
     reg signed [15:0] counter;
    localparam IDLE     = 3'b00,  // IDLE state
               LOAD     = 3'b01,  // Load state for vector values
               COUNT_A  = 3'b10,  // Decrement/Increment counta state
               COUNT_B  = 3'b11,  // Decrement/Increment countb state
               CHANGE   = 3'b100;

    // State machine
    always @(posedge clk) begin
        if (rst) begin
            counta <= 8'd0;
            countb <= 8'd0;
            index_a <= 7'd0;
            index_b <= 7'd0;
            done_A <= 0;
            done_B <= 0;
            state <= IDLE;
            done <= 1'b0;
            counter <= 0;
            unary_col <= 0;
            unary_row <= 0;
            neg_row <= 0;
            neg_col <= 0;
            
            j <= 0;
        end else begin
            case (state)
                IDLE: begin
                    // Wait in idle, start processing when index is within bounds
                    if (index_a < 7'd64) begin
                        state <= LOAD;
                    end else begin
                        done <= 1'b1;  // Done when all vectors processed
                    end
                end

                LOAD: begin
                    // Load the nth value from vector_a and vector_b into counta and countb
                    counta <= vector_a[index_a*8+:8];
                    countb <= vector_b[index_b*8+:8];
                    
                    state <= COUNT_A;  // Start with counta
                end

                COUNT_A: begin
                if (counta == 0) begin
                        done_A <= done_A + 1;
                        C00[j] <= counter;
                        done_B <= done_B + 1;
                        state <= CHANGE;
                    end
                    // First, decrement or increment counta
                    else if (counta > 0) begin
                        counta <= counta - 1;
                        state <= COUNT_B;
                    end else if (counta < 0) begin
                        counta <= counta + 1;
                        state <= COUNT_B;
                    end

                    if (counta > 0) begin
                      unary_col <= 1;
                      neg_col <= 0; end
                  else if  (counta < 0) begin
                       unary_col <= 0;
                       neg_col <= 1; end
                 if (countb > 0)   begin 
                      unary_row <= 1;
                      neg_row <= 0; end
                 else if (countb < 0) begin
                    unary_row <= 0;
                    neg_row <= 1; end
                    // After one decrement/increment of counta, go to countb state
                    
                end

                 COUNT_B: begin
                // Now decrement or increment countb until it reaches 0
                if (countb > 0) begin
                    countb <= countb - 1;
                    if (xor_out == 0) begin
             
                counter <= counter + 1; end 
             
             else if (xor_out == 1) begin
             
                counter <= counter - 1; end
                end else if (countb < 0) begin
                    countb <= countb + 1;
                    if (xor_out == 0) begin
             
                counter <= counter + 1; end 
             
             else if (xor_out == 1) begin
             
                counter <= counter - 1; end
                end else begin
                    // When countb reaches 0, go back to counta if counta > 0
                    if (counta != 0) begin
                        state <= COUNT_A;  // Continue with counta
                        countb <= vector_b[index_b*8+:8];
                    end else if (counta == 0) begin
                        done_A <= done_A + 1;
                        C00[j] <= counter;
                        done_B <= done_B + 1;
                        state <= CHANGE;
                    end
                end
            end

            CHANGE: begin
                j = j+1;
                counter <= 0;
                
                // Both counta and countb are 0, load next values
                case (done_A)
                    0: index_a <= 7'd0;
                    1: index_a <= 7'd0;
                    2: index_a <= 7'd0;
                    3: index_a <= 7'd0;
                    4: index_a <= 7'd0;
                    5: index_a <= 7'd0;
                    6: index_a <= 7'd0;
                    7: index_a <= 7'd0;
                    8: index_a <= 7'd8;
                    9: index_a <= 7'd8;
                    10: index_a <= 7'd8;
                    11: index_a <= 7'd8;
                    12: index_a <= 7'd8;
                    13: index_a <= 7'd8;
                    14: index_a <= 7'd8;
                    15: index_a <= 7'd8;
                    16: index_a <= 7'd16;
                    17: index_a <= 7'd16;
                    18: index_a <= 7'd16;
                    19: index_a <= 7'd16;
                    20: index_a <= 7'd16;
                    21: index_a <= 7'd16;
                    22: index_a <= 7'd16;
                    23: index_a <= 7'd16;
                    24: index_a <= 7'd24;
                    25: index_a <= 7'd24;
                    26: index_a <= 7'd24;
                    27: index_a <= 7'd24;
                    28: index_a <= 7'd24;
                    29: index_a <= 7'd24;
                    30: index_a <= 7'd24;
                    31: index_a <= 7'd24;
                    32: index_a <= 7'd32;
                    33: index_a <= 7'd32;
                    34: index_a <= 7'd32;
                    35: index_a <= 7'd32;
                    36: index_a <= 7'd32;
                    37: index_a <= 7'd32;
                    38: index_a <= 7'd32;
                    39: index_a <= 7'd32;
                    40: index_a <= 7'd40;
                    41: index_a <= 7'd40;
                    42: index_a <= 7'd40;
                    43: index_a <= 7'd40;
                    44: index_a <= 7'd40;
                    45: index_a <= 7'd40;
                    46: index_a <= 7'd40;
                    47: index_a <= 7'd40;
                    48: index_a <= 7'd48;
                    49: index_a <= 7'd48;
                    50: index_a <= 7'd48;
                    51: index_a <= 7'd48;
                    52: index_a <= 7'd48;
                    53: index_a <= 7'd48;
                    54: index_a <= 7'd48;
                    55: index_a <= 7'd48;
                    56: index_a <= 7'd56;
                    57: index_a <= 7'd56;
                    58: index_a <= 7'd56;
                    59: index_a <= 7'd56;
                    60: index_a <= 7'd56;
                    61: index_a <= 7'd56;
                    62: index_a <= 7'd56;
                    63: index_a <= 7'd56;
                   
                   
                endcase

                case (done_B)
                    0: index_b <= 7'd0;
                    1: index_b <= 7'd1;
                    2: index_b <= 7'd2;
                    3: index_b <= 7'd3;
                    4: index_b <= 7'd4;
                    5: index_b <= 7'd5;
                    6: index_b <= 7'd6;
                    7: index_b <= 7'd7;
                    8: index_b <= 7'd0;
                    9: index_b <= 7'd1;
                    10: index_b <= 7'd2;
                    11: index_b <= 7'd3;
                    12: index_b <= 7'd4;
                    13: index_b <= 7'd5;
                    14: index_b <= 7'd6;
                    15: index_b <= 7'd7;
                    16: index_b <= 7'd0;
                    17: index_b <= 7'd1;
                    18: index_b <= 7'd2;
                    19: index_b <= 7'd3;
                    20: index_b <= 7'd4;
                    21: index_b <= 7'd5;
                    22: index_b <= 7'd6;
                    23: index_b <= 7'd7;
                    24: index_b <= 7'd0;
                    25: index_b <= 7'd1;
                    26: index_b <= 7'd2;
                    27: index_b <= 7'd3;
                    28: index_b <= 7'd4;
                    29: index_b <= 7'd5;
                    30: index_b <= 7'd6;
                    31: index_b <= 7'd7;
                    32: index_b <= 7'd0;
                    33: index_b <= 7'd1;
                    34: index_b <= 7'd2;
                    35: index_b <= 7'd3;
                    36: index_b <= 7'd4;
                    37: index_b <= 7'd5;
                    38: index_b <= 7'd6;
                    39: index_b <= 7'd7;
                    40: index_b <= 7'd0;
                    41: index_b <= 7'd1;
                    42: index_b <= 7'd2;
                    43: index_b <= 7'd3;
                    44: index_b <= 7'd4;
                    45: index_b <= 7'd5;
                    46: index_b <= 7'd6;
                    47: index_b <= 7'd7;
                    48: index_b <= 7'd0;
                    49: index_b <= 7'd1;
                    50: index_b <= 7'd2;
                    51: index_b <= 7'd3;
                    52: index_b <= 7'd4;
                    53: index_b <= 7'd5;
                    54: index_b <= 7'd6;
                    55: index_b <= 7'd7;
                    56: index_b <= 7'd0;
                    57: index_b <= 7'd1;
                    58: index_b <= 7'd2;
                    59: index_b <= 7'd3;
                    60: index_b <= 7'd4;
                    61: index_b <= 7'd5;
                    62: index_b <= 7'd6;
                    63: index_b <= 7'd7;
                endcase

                state <= LOAD;  // Load next vector values
            end

        endcase
    end
end

            assign xor_out = neg_col ^ neg_row;
            assign and_out = unary_col && unary_row;

/// second state machine
    reg signed unary_col_1 ;
    reg signed unary_row_1 ;
    reg signed neg_row_1;
    reg signed neg_col_1 ;
    wire signed xor_out_1 ;
    wire signed and_out_1 ;
    reg  signed [7:0] counta_1;
    reg signed [7:0] countb_1;   // 8-bit counters
    reg [7:0] index_a_1;            // Index for vector selection
    reg [7:0] index_b_1;
    reg [7:0] done_A_1;
    reg [7:0] done_B_1;
    reg [2:0] state_1;            // State variable
     reg done_1;
     reg signed [15:0] C00_1 [0:63];
     reg signed [15:0] counter_1;
    localparam IDLE_1     = 3'b00,  // IDLE state
               LOAD_1     = 3'b01,  // Load state for vector values
               COUNT_A_1  = 3'b10,  // Decrement/Increment counta state
               COUNT_B_1  = 3'b11,  // Decrement/Increment countb state
               CHANGE_1   = 3'b100;



always @(posedge clk) begin
        if (rst) begin
            counta_1 <= 8'd0;
            countb_1 <= 8'd0;
            index_a_1 <= 7'd1;
            index_b_1 <= 7'd8;
            done_A_1 <= 0;
            done_B_1 <= 0;
            counter_1 <= 0;
            unary_col_1 <= 0;
            unary_row_1 <= 0;
            neg_row_1 <= 0;
            neg_col_1 <= 0;
            
            i <= 0;
            state_1 <= IDLE_1;
            //done_1 <= 1'b0;
        end else begin
            case (state_1)
                IDLE_1: begin
                    // Wait in idle, start processing when index is within bounds
                    if (index_a_1 < 7'd64) begin
                        state_1 <= LOAD_1;
                    end else begin
                       // done_1 <= 1'b1;  // Done when all vectors processed
                    end
                end

                LOAD_1: begin
                    // Load the nth value from vector_a and vector_b into counta and countb
                    counta_1 <= vector_a[index_a_1*8+:8];
                    countb_1 <= vector_b[index_b_1*8+:8];
                    state_1 <= COUNT_A_1;  // Start with counta
                end

                COUNT_A_1: begin
                if (counta_1 == 0) begin
                        done_A_1 <= done_A_1 + 1;
                        C00_1[i] <= counter_1;
                        done_B_1 <= done_B_1 + 1;
                        state_1 <= CHANGE_1;
                    end
                    // First, decrement or increment counta
                    else if (counta_1 > 0) begin
                        counta_1 <= counta_1 - 1;
                        state_1 <= COUNT_B_1;
                    end else if (counta_1 < 0) begin
                        counta_1 <= counta_1 + 1;
                        state_1 <= COUNT_B_1;
                    end

                    if (counta_1 > 0) begin
                      unary_col_1 <= 1;
                      neg_col_1 <= 0; end
                  else if  (counta_1 < 0) begin
                       unary_col_1 <= 0;
                       neg_col_1 <= 1; end
                 if (countb_1 > 0)   begin 
                      unary_row_1 <= 1;
                      neg_row_1 <= 0; end
                 else if (countb_1 < 0) begin
                    unary_row_1 <= 0;
                    neg_row_1 <= 1; end
                    
                    // After one decrement/increment of counta, go to countb state
                    
                end

                 COUNT_B_1: begin
                // Now decrement or increment countb until it reaches 0
                if (countb_1 > 0) begin
                    countb_1 <= countb_1 - 1;
                    if (xor_out_1 == 0) begin
             
                counter_1 <= counter_1 + 1; end 
             
             else if (xor_out_1 == 1) begin
             
                counter_1 <= counter_1 - 1; end
                end else if (countb_1 < 0) begin
                    countb_1 <= countb_1 + 1;
                    if (xor_out_1 == 0) begin
             
                counter_1 <= counter_1 + 1; end 
             
             else if (xor_out_1 == 1) begin
             
                counter_1 <= counter_1 - 1; end
                end else begin
                    // When countb reaches 0, go back to counta if counta > 0
                    if (counta_1 != 0) begin
                        state_1 <= COUNT_A_1;  // Continue with counta
                        countb_1 <= vector_b[index_b_1*8+:8];
                    end else if (counta_1 == 0) begin
                        done_A_1 <= done_A_1 + 1;
                        C00_1[i] <= counter_1;
                        done_B_1 <= done_B_1 + 1;
                        state_1 <= CHANGE_1;
                    end
                end
            end

            CHANGE_1: begin
            
                i = i+1;
                counter_1 <= 0;
                // Both counta and countb are 0, load next values
                case (done_A_1)
                    0: index_a_1 <= 7'd0;
                    1: index_a_1 <= 7'd1;
                    2: index_a_1 <= 7'd1;
                    3: index_a_1 <= 7'd1;
                    4: index_a_1 <= 7'd1;
                    5: index_a_1 <= 7'd1;
                    6: index_a_1 <= 7'd1;
                    7: index_a_1 <= 7'd1;
                    8: index_a_1 <= 7'd9;
                    9: index_a_1 <= 7'd9;
                    10: index_a_1 <= 7'd9;
                    11: index_a_1 <= 7'd9;
                    12: index_a_1 <= 7'd9;
                    13: index_a_1 <= 7'd9;
                    14: index_a_1 <= 7'd9;
                    15: index_a_1 <= 7'd9;
                    16: index_a_1 <= 7'd17;
                    17: index_a_1 <= 7'd17;
                    18: index_a_1 <= 7'd17;
                    19: index_a_1 <= 7'd17;
                    20: index_a_1 <= 7'd17;
                    21: index_a_1 <= 7'd17;
                    22: index_a_1 <= 7'd17;
                    23: index_a_1 <= 7'd17;
                    24: index_a_1 <= 7'd25;
                    25: index_a_1 <= 7'd25;
                    26: index_a_1 <= 7'd25;
                    27: index_a_1 <= 7'd25;
                    28: index_a_1 <= 7'd25;
                    29: index_a_1 <= 7'd25;
                    30: index_a_1 <= 7'd25;
                    31: index_a_1 <= 7'd25;
                    32: index_a_1 <= 7'd33;
                    33: index_a_1 <= 7'd33;
                    34: index_a_1 <= 7'd33;
                    35: index_a_1 <= 7'd33;
                    36: index_a_1 <= 7'd33;
                    37: index_a_1 <= 7'd33;
                    38: index_a_1 <= 7'd33;
                    39: index_a_1 <= 7'd33;
                    40: index_a_1 <= 7'd41;
                    41: index_a_1 <= 7'd41;
                    42: index_a_1 <= 7'd41;
                    43: index_a_1 <= 7'd41;
                    44: index_a_1 <= 7'd41;
                    45: index_a_1 <= 7'd41;
                    46: index_a_1 <= 7'd41;
                    47: index_a_1 <= 7'd41;
                    48: index_a_1 <= 7'd49;
                    49: index_a_1 <= 7'd49;
                    50: index_a_1 <= 7'd49;
                    51: index_a_1 <= 7'd49;
                    52: index_a_1 <= 7'd49;
                    53: index_a_1 <= 7'd49;
                    54: index_a_1 <= 7'd49;
                    55: index_a_1 <= 7'd49;
                    56: index_a_1 <= 7'd57;
                    57: index_a_1 <= 7'd57;
                    58: index_a_1 <= 7'd57;
                    59: index_a_1 <= 7'd57;
                    60: index_a_1 <= 7'd57;
                    61: index_a_1 <= 7'd57;
                    62: index_a_1 <= 7'd57;
                    63: index_a_1 <= 7'd57;
                endcase

                case (done_B_1)
                    0: index_b_1 <= 7'd0;
                    1: index_b_1 <= 7'd9;
                    2: index_b_1 <= 7'd10;
                    3: index_b_1 <= 7'd11;
                    4: index_b_1 <= 7'd12;
                    5: index_b_1 <= 7'd13;
                    6: index_b_1 <= 7'd14;
                    7: index_b_1 <= 7'd15;
                    8: index_b_1 <= 7'd8;
                    9: index_b_1 <= 7'd9;
                    10: index_b_1 <= 7'd10;
                    11: index_b_1 <= 7'd11;
                    12: index_b_1 <= 7'd12;
                    13: index_b_1 <= 7'd13;
                    14: index_b_1 <= 7'd14;
                    15: index_b_1 <= 7'd15;
                    16: index_b_1 <= 7'd8;
                    17: index_b_1 <= 7'd9;
                    18: index_b_1 <= 7'd10;
                    19: index_b_1 <= 7'd11;
                    20: index_b_1 <= 7'd12;
                    21: index_b_1 <= 7'd13;
                    22: index_b_1 <= 7'd14;
                    23: index_b_1 <= 7'd15;
                    24: index_b_1 <= 7'd8;
                    25: index_b_1 <= 7'd9;
                    26: index_b_1 <= 7'd10;
                    27: index_b_1 <= 7'd11;
                    28: index_b_1 <= 7'd12;
                    29: index_b_1 <= 7'd13;
                    30: index_b_1 <= 7'd14;
                    31: index_b_1 <= 7'd15;
                    32: index_b_1 <= 7'd8;
                    33: index_b_1 <= 7'd9;
                    34: index_b_1 <= 7'd10;
                    35: index_b_1 <= 7'd11;
                    36: index_b_1 <= 7'd12;
                    37: index_b_1 <= 7'd13;
                    38: index_b_1 <= 7'd14;
                    39: index_b_1 <= 7'd15;
                    40: index_b_1 <= 7'd8;
                    41: index_b_1 <= 7'd9;
                    42: index_b_1 <= 7'd10;
                    43: index_b_1 <= 7'd11;
                    44: index_b_1 <= 7'd12;
                    45: index_b_1 <= 7'd13;
                    46: index_b_1 <= 7'd14;
                    47: index_b_1 <= 7'd15;
                    48: index_b_1 <= 7'd8;
                    49: index_b_1 <= 7'd9;
                    50: index_b_1 <= 7'd10;
                    51: index_b_1 <= 7'd11;
                    52: index_b_1 <= 7'd12;
                    53: index_b_1 <= 7'd13;
                    54: index_b_1 <= 7'd14;
                    55: index_b_1 <= 7'd15;
                    56: index_b_1 <= 7'd8;
                    57: index_b_1 <= 7'd9;
                    58: index_b_1 <= 7'd10;
                    59: index_b_1 <= 7'd11;
                    60: index_b_1 <= 7'd12;
                    61: index_b_1 <= 7'd13;
                    62: index_b_1 <= 7'd14;
                    63: index_b_1 <= 7'd15;
                endcase

                state_1 <= LOAD_1;  // Load next vector values
            end

        endcase
    end
end


            assign xor_out_1 = neg_col_1 ^ neg_row_1;
            assign and_out_1 = unary_col_1 && unary_row_1;

/// third state machine
    reg signed unary_col_2 ;
    reg signed unary_row_2 ;
    reg signed neg_row_2;
    reg signed neg_col_2 ;
    wire signed xor_out_2 ;
    wire signed and_out_2 ;
    reg signed [7:0] counta_2;
    reg signed [7:0] countb_2;   // 8-bit counters
    reg [7:0] index_a_2;            // Index for vector selection
    reg [7:0] index_b_2;
    reg [7:0] done_A_2;
    reg [7:0] done_B_2;
    reg [2:0] state_2;            // State variable
  //   reg done_1;
     reg signed [15:0] C00_2 [0:63];
     reg signed [15:0] counter_2;
    localparam IDLE_2     = 3'b00,  // IDLE state
               LOAD_2     = 3'b01,  // Load state for vector values
               COUNT_A_2  = 3'b10,  // Decrement/Increment counta state
               COUNT_B_2  = 3'b11,  // Decrement/Increment countb state
               CHANGE_2   = 3'b100;



always @(posedge clk) begin
        if (rst) begin
            counta_2 <= 8'd0;
            countb_2 <= 8'd0;
            index_a_2 <= 7'd2;
            index_b_2 <= 7'd16;
            done_A_2 <= 0;
            done_B_2 <= 0;
            counter_2 <= 0;
            unary_col_2 <= 0;
            unary_row_2 <= 0;
            neg_row_2 <= 0;
            neg_col_2 <= 0;
            
            k <= 0;
            state_2 <= IDLE_2;
            //done_1 <= 1'b0;
        end else begin
            case (state_2)
                IDLE_2: begin
                    // Wait in idle, start processing when index is within bounds
                    if (index_a_2 < 7'd64) begin
                        state_2 <= LOAD_2;
                    end else begin
                       // done_1 <= 1'b1;  // Done when all vectors processed
                    end
                end

                LOAD_2: begin
                    // Load the nth value from vector_a and vector_b into counta and countb
                    counta_2 <= vector_a[index_a_2*8+:8];
                    countb_2 <= vector_b[index_b_2*8+:8];
                    state_2 <= COUNT_A_2;  // Start with counta
                end

                COUNT_A_2: begin
                if (counta_2 == 0) begin
                        done_A_2 <= done_A_2 + 1;
                        C00_2[k] <= counter_2;
                        done_B_2 <= done_B_2 + 1;
                        state_2 <= CHANGE_2;
                    end
                    // First, decrement or increment counta
                    else if (counta_2 > 0) begin
                        counta_2 <= counta_2 - 1;
                        state_2 <= COUNT_B_2;
                    end else if (counta_2 < 0) begin
                        counta_2 <= counta_2 + 1;
                        state_2 <= COUNT_B_2;
                    end

                    if (counta_2 > 0) begin
                      unary_col_2 <= 1;
                      neg_col_2 <= 0; end
                  else if  (counta_2 < 0) begin
                       unary_col_2 <= 0;
                       neg_col_2 <= 1; end
                 if (countb_2 > 0)   begin 
                      unary_row_2 <= 1;
                      neg_row_2 <= 0; end
                 else if (countb_2 < 0) begin
                    unary_row_2 <= 0;
                    neg_row_2 <= 1; end

                    // After one decrement/increment of counta, go to countb state
                    
                end

                 COUNT_B_2: begin
                // Now decrement or increment countb until it reaches 0
                if (countb_2 > 0) begin
                    countb_2 <= countb_2 - 1;
                     if (xor_out_2 == 0) begin
             
                counter_2 <= counter_2 + 1; end 
             
             else if (xor_out_2 == 1) begin
             
                counter_2 <= counter_2 - 1; end
                
                end else if (countb_2 < 0) begin
                    countb_2 <= countb_2 + 1;
                     if (xor_out_2 == 0) begin
             
                counter_2 <= counter_2 + 1; end 
             
             else if (xor_out_2 == 1) begin
             
                counter_2 <= counter_2 - 1; end
                end else begin
                    // When countb reaches 0, go back to counta if counta > 0
                    if (counta_2 != 0) begin
                        state_2 <= COUNT_A_2;  // Continue with counta
                        countb_2 <= vector_b[index_b_2*8+:8];
                    end else if (counta_2 == 0) begin
                        done_A_2 <= done_A_2 + 1;
                        C00_2[k] <= counter_2;
                        done_B_2 <= done_B_2 + 1;
                        state_2 <= CHANGE_2;
                    end
                end
            end

            CHANGE_2: begin
            
                k = k+1;
                counter_2 <= 0;
                // Both counta and countb are 0, load next values
                case (done_A_2)
                    0: index_a_2 <= 7'd0;
                    1: index_a_2 <= 7'd2;
                    2: index_a_2 <= 7'd2;
                    3: index_a_2 <= 7'd2;
                    4: index_a_2 <= 7'd2;
                    5: index_a_2 <= 7'd2;
                    6: index_a_2 <= 7'd2;
                    7: index_a_2 <= 7'd2;
                    8: index_a_2 <= 7'd10;
                    9: index_a_2 <= 7'd10;
                    10: index_a_2 <= 7'd10;
                    11: index_a_2 <= 7'd10;
                    12: index_a_2 <= 7'd10;
                    13: index_a_2 <= 7'd10;
                    14: index_a_2 <= 7'd10;
                    15: index_a_2 <= 7'd10;
                    16: index_a_2 <= 7'd18;
                    17: index_a_2 <= 7'd18;
                    18: index_a_2 <= 7'd18;
                    19: index_a_2 <= 7'd18;
                    20: index_a_2 <= 7'd18;
                    21: index_a_2 <= 7'd18;
                    22: index_a_2 <= 7'd18;
                    23: index_a_2 <= 7'd18;
                    24: index_a_2 <= 7'd26;
                    25: index_a_2 <= 7'd26;
                    26: index_a_2 <= 7'd26;
                    27: index_a_2 <= 7'd26;
                    28: index_a_2 <= 7'd26;
                    29: index_a_2 <= 7'd26;
                    30: index_a_2 <= 7'd26;
                    31: index_a_2 <= 7'd26;
                    32: index_a_2 <= 7'd34;
                    33: index_a_2 <= 7'd34;
                    34: index_a_2 <= 7'd34;
                    35: index_a_2 <= 7'd34;
                    36: index_a_2 <= 7'd34;
                    37: index_a_2 <= 7'd34;
                    38: index_a_2 <= 7'd34;
                    39: index_a_2 <= 7'd34;
                    40: index_a_2 <= 7'd42;
                    41: index_a_2 <= 7'd42;
                    42: index_a_2 <= 7'd42;
                    43: index_a_2 <= 7'd42;
                    44: index_a_2 <= 7'd42;
                    45: index_a_2 <= 7'd42;
                    46: index_a_2 <= 7'd42;
                    47: index_a_2 <= 7'd42;
                    48: index_a_2 <= 7'd50;
                    49: index_a_2 <= 7'd50;
                    50: index_a_2 <= 7'd50;
                    51: index_a_2 <= 7'd50;
                    52: index_a_2 <= 7'd50;
                    53: index_a_2 <= 7'd50;
                    54: index_a_2 <= 7'd50;
                    55: index_a_2 <= 7'd50;
                    56: index_a_2 <= 7'd58;
                    57: index_a_2 <= 7'd58;
                    58: index_a_2 <= 7'd58;
                    59: index_a_2 <= 7'd58;
                    60: index_a_2 <= 7'd58;
                    61: index_a_2 <= 7'd58;
                    62: index_a_2 <= 7'd58;
                    63: index_a_2 <= 7'd58;
                endcase

                case (done_B_2)
                    0: index_b_2 <= 7'd0;
                    1: index_b_2 <= 7'd17;
                    2: index_b_2 <= 7'd18;
                    3: index_b_2 <= 7'd19;
                    4: index_b_2 <= 7'd20;
                    5: index_b_2 <= 7'd21;
                    6: index_b_2 <= 7'd22;
                    7: index_b_2 <= 7'd23;
                    8: index_b_2 <= 7'd16;
                    9: index_b_2 <= 7'd17;
                    10: index_b_2 <= 7'd18;
                    11: index_b_2 <= 7'd19;
                    12: index_b_2 <= 7'd20;
                    13: index_b_2 <= 7'd21;
                    14: index_b_2 <= 7'd22;
                    15: index_b_2 <= 7'd23;
                    16: index_b_2 <= 7'd16;
                    17: index_b_2 <= 7'd17;
                    18: index_b_2 <= 7'd18;
                    19: index_b_2 <= 7'd19;
                    20: index_b_2 <= 7'd20;
                    21: index_b_2 <= 7'd21;
                    22: index_b_2 <= 7'd22;
                    23: index_b_2 <= 7'd23;
                    24: index_b_2 <= 7'd16;
                    25: index_b_2 <= 7'd17;
                    26: index_b_2 <= 7'd18;
                    27: index_b_2 <= 7'd19;
                    28: index_b_2 <= 7'd20;
                    29: index_b_2 <= 7'd21;
                    30: index_b_2 <= 7'd22;
                    31: index_b_2 <= 7'd23;
                    32: index_b_2 <= 7'd16;
                    33: index_b_2 <= 7'd17;
                    34: index_b_2 <= 7'd18;
                    35: index_b_2 <= 7'd19;
                    36: index_b_2 <= 7'd20;
                    37: index_b_2 <= 7'd21;
                    38: index_b_2 <= 7'd22;
                    39: index_b_2 <= 7'd23;
                    40: index_b_2 <= 7'd16;
                    41: index_b_2 <= 7'd17;
                    42: index_b_2 <= 7'd18;
                    43: index_b_2 <= 7'd19;
                    44: index_b_2 <= 7'd20;
                    45: index_b_2 <= 7'd21;
                    46: index_b_2 <= 7'd22;
                    47: index_b_2 <= 7'd23;
                    48: index_b_2 <= 7'd16;
                    49: index_b_2 <= 7'd17;
                    50: index_b_2 <= 7'd18;
                    51: index_b_2 <= 7'd19;
                    52: index_b_2 <= 7'd20;
                    53: index_b_2 <= 7'd21;
                    54: index_b_2 <= 7'd22;
                    55: index_b_2 <= 7'd23;
                    56: index_b_2 <= 7'd16;
                    57: index_b_2 <= 7'd17;
                    58: index_b_2 <= 7'd18;
                    59: index_b_2 <= 7'd19;
                    60: index_b_2 <= 7'd20;
                    61: index_b_2 <= 7'd21;
                    62: index_b_2 <= 7'd22;
                    63: index_b_2 <= 7'd23;
                endcase

                state_2 <= LOAD_2;  // Load next vector values
            end

        endcase
    end
end

            assign xor_out_2 = neg_col_2 ^ neg_row_2;
            assign and_out_2 = unary_col_2 && unary_row_2;


/// FOURTH state machine
    reg signed unary_col_3 ;
    reg signed unary_row_3 ;
    reg signed neg_row_3;
    reg signed neg_col_3 ;
    wire signed xor_out_3 ;
    wire signed and_out_3 ;
    reg signed [7:0] counta_3;
    reg signed [7:0] countb_3;   // 8-bit counters
    reg [7:0] index_a_3;            // Index for vector selection
    reg [7:0] index_b_3;
    reg [7:0] done_A_3;
    reg [7:0] done_B_3;
    reg [2:0] state_3;            // State variable
  //   reg done_1;
     reg signed [15:0] C00_3 [0:63];
     reg signed [15:0] counter_3;
    localparam IDLE_3     = 3'b00,  // IDLE state
               LOAD_3     = 3'b01,  // Load state for vector values
               COUNT_A_3  = 3'b10,  // Decrement/Increment counta state
               COUNT_B_3  = 3'b11,  // Decrement/Increment countb state
               CHANGE_3   = 3'b100;



always @(posedge clk) begin
        if (rst) begin
            counta_3 <= 8'd0;
            countb_3 <= 8'd0;
            index_a_3 <= 7'd3;
            index_b_3 <= 5'd24;
            done_A_3 <= 0;
            done_B_3 <= 0;
            counter_3 <= 0;
            unary_col_3 <= 0;
            unary_row_3 <= 0;
            neg_row_3 <= 0;
            neg_col_3 <= 0;
            
            l <= 0;
            state_3 <= IDLE_3;
            //done_1 <= 1'b0;
        end else begin
            case (state_3)
                IDLE_3: begin
                    // Wait in idle, start processing when index is within bounds
                    if (index_a_3 < 7'd64) begin
                        state_3 <= LOAD_3;
                    end else begin
                       // done_1 <= 1'b1;  // Done when all vectors processed
                    end
                end

                LOAD_3: begin
                    // Load the nth value from vector_a and vector_b into counta and countb
                    counta_3 <= vector_a[index_a_3*8+:8];
                    countb_3 <= vector_b[index_b_3*8+:8];
                    
                
                    state_3 <= COUNT_A_3;  // Start with counta
                end

                COUNT_A_3: begin
                if (counta_3 == 0) begin
                        done_A_3 <= done_A_3 + 1;
                        C00_3[l] <= counter_3;
                        done_B_3 <= done_B_3 + 1;
                        state_3 <= CHANGE_3;
                    end
                    // First, decrement or increment counta
                   else if (counta_3 > 0) begin
                        counta_3 <= counta_3 - 1;
                        state_3 <= COUNT_B_3;
                    end else if (counta_3 < 0) begin
                        counta_3 <= counta_3 + 1;
                        state_3 <= COUNT_B_3;
                    end

                    if (counta_3 > 0) begin
                      unary_col_3 <= 1;
                      neg_col_3 <= 0; end
                  else if  (counta_3 < 0) begin
                       unary_col_3 <= 0;
                       neg_col_3 <= 1; end
                 if (countb_3 > 0)   begin 
                      unary_row_3 <= 1;
                      neg_row_3 <= 0; end
                 else if (countb_3 < 0) begin
                    unary_row_3 <= 0;
                    neg_row_3 <= 1; end

                    // After one decrement/increment of counta, go to countb state
                    
                end

                 COUNT_B_3: begin
                // Now decrement or increment countb until it reaches 0
                if (countb_3 > 0) begin
                    countb_3 <= countb_3 - 1;
                    if (xor_out_3 == 0) begin
             
                counter_3 <= counter_3 + 1; end 
             
             else if (xor_out_3 == 1) begin
             
                counter_3 <= counter_3 - 1; end
                end else if (countb_3 < 0) begin
                    countb_3 <= countb_3 + 1;
                    if (xor_out_3 == 0) begin
             
                counter_3 <= counter_3 + 1; end 
             
             else if (xor_out_3 == 1) begin
             
                counter_3 <= counter_3 - 1; end
                end else begin
                    // When countb reaches 0, go back to counta if counta > 0
                    if (counta_3 != 0) begin
                        state_3 <= COUNT_A_3;  // Continue with counta
                        countb_3 <= vector_b[index_b_3*8+:8];
                    end else if (counta_3 == 0) begin
                        done_A_3 <= done_A_3 + 1;
                        C00_3[l] <= counter_3;
                        done_B_3 <= done_B_3 + 1;
                        state_3 <= CHANGE_3;
                    end
                end
            end

            CHANGE_3: begin
            
                l = l+1;
                counter_3 <= 0;
                // Both counta and countb are 0, load next values
                case (done_A_3)
                    0: index_a_3 <= 7'd0;
                    1: index_a_3 <= 7'd3;
                    2: index_a_3 <= 7'd3;
                    3: index_a_3 <= 7'd3;
                    4: index_a_3 <= 7'd3;
                    5: index_a_3 <= 7'd3;
                    6: index_a_3 <= 7'd3;
                    7: index_a_3 <= 7'd3;
                    8: index_a_3 <= 7'd11;
                    9: index_a_3 <= 7'd11;
                    10: index_a_3 <= 7'd11;
                    11: index_a_3 <= 7'd11;
                    12: index_a_3 <= 7'd11;
                    13: index_a_3 <= 7'd11;
                    14: index_a_3 <= 7'd11;
                    15: index_a_3 <= 7'd11;
                    16: index_a_3 <= 7'd19;
                    17: index_a_3 <= 7'd19;
                    18: index_a_3 <= 7'd19;
                    19: index_a_3 <= 7'd19;
                    20: index_a_3 <= 7'd19;
                    21: index_a_3 <= 7'd19;
                    22: index_a_3 <= 7'd19;
                    23: index_a_3 <= 7'd19;
                    24: index_a_3 <= 7'd27;
                    25: index_a_3 <= 7'd27;
                    26: index_a_3 <= 7'd27;
                    27: index_a_3 <= 7'd27;
                    28: index_a_3 <= 7'd27;
                    29: index_a_3 <= 7'd27;
                    30: index_a_3 <= 7'd27;
                    31: index_a_3 <= 7'd27;
                    32: index_a_3 <= 7'd35;
                    33: index_a_3 <= 7'd35;
                    34: index_a_3 <= 7'd35;
                    35: index_a_3 <= 7'd35;
                    36: index_a_3 <= 7'd35;
                    37: index_a_3 <= 7'd35;
                    38: index_a_3 <= 7'd35;
                    39: index_a_3 <= 7'd35;
                    40: index_a_3 <= 7'd43;
                    41: index_a_3 <= 7'd43;
                    42: index_a_3 <= 7'd43;
                    43: index_a_3 <= 7'd43;
                    44: index_a_3 <= 7'd43;
                    45: index_a_3 <= 7'd43;
                    46: index_a_3 <= 7'd43;
                    47: index_a_3 <= 7'd43;
                    48: index_a_3 <= 7'd51;
                    49: index_a_3 <= 7'd51;
                    50: index_a_3 <= 7'd51;
                    51: index_a_3 <= 7'd51;
                    52: index_a_3 <= 7'd51;
                    53: index_a_3 <= 7'd51;
                    54: index_a_3 <= 7'd51;
                    55: index_a_3 <= 7'd51;
                    56: index_a_3 <= 7'd59;
                    57: index_a_3 <= 7'd59;
                    58: index_a_3 <= 7'd59;
                    59: index_a_3 <= 7'd59;
                    60: index_a_3 <= 7'd59;
                    61: index_a_3 <= 7'd59;
                    62: index_a_3 <= 7'd59;
                    63: index_a_3 <= 7'd59;
                endcase

                case (done_B_3)
                    0: index_b_3 <= 7'd0;
                    1: index_b_3 <= 7'd25;
                    2: index_b_3 <= 7'd26;
                    3: index_b_3 <= 7'd27;
                    4: index_b_3 <= 7'd28;
                    5: index_b_3 <= 7'd29;
                    6: index_b_3 <= 7'd30;
                    7: index_b_3 <= 7'd31;
                    8: index_b_3 <= 7'd24;
                    9: index_b_3 <= 7'd25;
                    10: index_b_3 <= 7'd26;
                    11: index_b_3 <= 7'd27;
                    12: index_b_3 <= 7'd28;
                    13: index_b_3 <= 7'd29;
                    14: index_b_3 <= 7'd30;
                    15: index_b_3 <= 7'd31;
                    16: index_b_3 <= 7'd24;
                    17: index_b_3 <= 7'd25;
                    18: index_b_3 <= 7'd26;
                    19: index_b_3 <= 7'd27;
                    20: index_b_3 <= 7'd28;
                    21: index_b_3 <= 7'd29;
                    22: index_b_3 <= 7'd30;
                    23: index_b_3 <= 7'd31;
                    24: index_b_3 <= 7'd24;
                    25: index_b_3 <= 7'd25;
                    26: index_b_3 <= 7'd26;
                    27: index_b_3 <= 7'd27;
                    28: index_b_3 <= 7'd28;
                    29: index_b_3 <= 7'd29;
                    30: index_b_3 <= 7'd30;
                    31: index_b_3 <= 7'd31;
                    32: index_b_3 <= 7'd24;
                    33: index_b_3 <= 7'd25;
                    34: index_b_3 <= 7'd26;
                    35: index_b_3 <= 7'd27;
                    36: index_b_3 <= 7'd28;
                    37: index_b_3 <= 7'd29;
                    38: index_b_3 <= 7'd30;
                    39: index_b_3 <= 7'd31;
                    40: index_b_3 <= 7'd24;
                    41: index_b_3 <= 7'd25;
                    42: index_b_3 <= 7'd26;
                    43: index_b_3 <= 7'd27;
                    44: index_b_3 <= 7'd28;
                    45: index_b_3 <= 7'd29;
                    46: index_b_3 <= 7'd30;
                    47: index_b_3 <= 7'd31;
                    48: index_b_3 <= 7'd24;
                    49: index_b_3 <= 7'd25;
                    50: index_b_3 <= 7'd26;
                    51: index_b_3 <= 7'd27;
                    52: index_b_3 <= 7'd28;
                    53: index_b_3 <= 7'd29;
                    54: index_b_3 <= 7'd30;
                    55: index_b_3 <= 7'd31;
                    56: index_b_3 <= 7'd24;
                    57: index_b_3 <= 7'd25;
                    58: index_b_3 <= 7'd26;
                    59: index_b_3 <= 7'd27;
                    60: index_b_3 <= 7'd28;
                    61: index_b_3 <= 7'd29;
                    62: index_b_3 <= 7'd30;
                    63: index_b_3 <= 7'd31;
                endcase

                state_3 <= LOAD_3;  // Load next vector values
            end

        endcase
    end
end


            assign xor_out_3 = neg_col_3 ^ neg_row_3;
            assign and_out_3 = unary_col_3 && unary_row_3;




// Fifth State Machine

    reg signed unary_col_4 ;
    reg signed unary_row_4 ;
    reg signed neg_row_4;
    reg signed neg_col_4 ;
    wire signed xor_out_4 ;
    wire signed and_out_4 ;
    reg signed [7:0] counta_4;
    reg signed [7:0] countb_4;   // 8-bit counters
    reg [7:0] index_a_4;            // Index for vector selection
    reg [7:0] index_b_4;
    reg [7:0] done_A_4;
    reg [7:0] done_B_4;
    reg [2:0] state_4;            // State variable
  //   reg done_1;
     reg signed [15:0] C00_4 [0:63];
     reg signed [15:0] counter_4;
    localparam IDLE_4     = 3'b00,  // IDLE state
               LOAD_4     = 3'b01,  // Load state for vector values
               COUNT_A_4  = 3'b10,  // Decrement/Increment counta state
               COUNT_B_4  = 3'b11,  // Decrement/Increment countb state
               CHANGE_4   = 3'b100;



always @(posedge clk) begin
        if (rst) begin
            counta_4 <= 8'd0;
            countb_4 <= 8'd0;
            index_a_4 <= 7'd4;
            index_b_4 <= 7'd32;
            done_A_4 <= 0;
            done_B_4 <= 0;
            counter_4 <= 0;
            unary_col_4 <= 0;
            unary_row_4 <= 0;
            neg_row_4 <= 0;
            neg_col_4 <= 0;
            
            m <= 0;
            state_4 <= IDLE_4;
            //done_1 <= 1'b0;
        end else begin
            case (state_4)
                IDLE_3: begin
                    // Wait in idle, start processing when index is within bounds
                    if (index_a_4 < 7'd64) begin
                        state_4 <= LOAD_4;
                    end else begin
                       // done_1 <= 1'b1;  // Done when all vectors processed
                    end
                end

                LOAD_3: begin
                    // Load the nth value from vector_a and vector_b into counta and countb
                    counta_4 <= vector_a[index_a_4*8+:8];
                    countb_4 <= vector_b[index_b_4*8+:8];
                    
                
                    state_4 <= COUNT_A_4;  // Start with counta
                end

                COUNT_A_4: begin
                 if (counta_4 == 0) begin
                        done_A_4 <= done_A_4 + 1;
                        C00_4[m] <= counter_4;
                        done_B_4 <= done_B_4 + 1;
                        state_4 <= CHANGE_4;
                    end
                    // First, decrement or increment counta
                    else if (counta_4 > 0) begin
                        counta_4 <= counta_4 - 1;
                        state_4 <= COUNT_B_4;
                    end else if (counta_4 < 0) begin
                        counta_4 <= counta_4 + 1;
                        state_4 <= COUNT_B_4;
                    end

                    if (counta_4 > 0) begin
                      unary_col_4 <= 1;
                      neg_col_4 <= 0; end
                  else if  (counta_4 < 0) begin
                       unary_col_4 <= 0;
                       neg_col_4 <= 1; end
                 if (countb_4 > 0)   begin 
                      unary_row_4 <= 1;
                      neg_row_4 <= 0; end
                 else if (countb_4 < 0) begin
                    unary_row_4 <= 0;
                    neg_row_4 <= 1; end

                    // After one decrement/increment of counta, go to countb state
                    
                end

                 COUNT_B_4: begin
                // Now decrement or increment countb until it reaches 0
                if (countb_4 > 0) begin
                    countb_4 <= countb_4 - 1;
                    if (xor_out_4 == 0) begin
             
                counter_4 <= counter_4 + 1; end 
             
             else if (xor_out_4 == 1) begin
             
                counter_4 <= counter_4 - 1; end
                end else if (countb_4 < 0) begin
                    countb_4 <= countb_4 + 1;
                    if (xor_out_4 == 0) begin
             
                counter_4 <= counter_4 + 1; end 
             
             else if (xor_out_4 == 1) begin
             
                counter_4 <= counter_4 - 1; end
                end else begin
                    // When countb reaches 0, go back to counta if counta > 0
                    if (counta_4 != 0) begin
                        state_4 <= COUNT_A_4;  // Continue with counta
                        countb_4 <= vector_b[index_b_4*8+:8];
                    end else if (counta_4 == 0) begin
                        done_A_4 <= done_A_4 + 1;
                        C00_4[m] <= counter_4;
                        done_B_4 <= done_B_4 + 1;
                        state_4 <= CHANGE_4;
                    end
                end
            end

            CHANGE_4: begin
            
                m = m+1;
                counter_4 <= 0;
                // Both counta and countb are 0, load next values
                case (done_A_4)
                    0: index_a_4 <= 7'd0;
                    1: index_a_4 <= 7'd4;
                    2: index_a_4 <= 7'd4;
                    3: index_a_4 <= 7'd4;
                    4: index_a_4 <= 7'd4;
                    5: index_a_4 <= 7'd4;
                    6: index_a_4 <= 7'd4;
                    7: index_a_4 <= 7'd4;
                    8: index_a_4 <= 7'd12;
                    9: index_a_4 <= 7'd12;
                    10: index_a_4 <= 7'd12;
                    11: index_a_4 <= 7'd12;
                    12: index_a_4 <= 7'd12;
                    13: index_a_4 <= 7'd12;
                    14: index_a_4 <= 7'd12;
                    15: index_a_4 <= 7'd12;
                    16: index_a_4 <= 7'd20;
                    17: index_a_4 <= 7'd20;
                    18: index_a_4 <= 7'd20;
                    19: index_a_4 <= 7'd20;
                    20: index_a_4 <= 7'd20;
                    21: index_a_4 <= 7'd20;
                    22: index_a_4 <= 7'd20;
                    23: index_a_4 <= 7'd20;
                    24: index_a_4 <= 7'd28;
                    25: index_a_4 <= 7'd28;
                    26: index_a_4 <= 7'd28;
                    27: index_a_4 <= 7'd28;
                    28: index_a_4 <= 7'd28;
                    29: index_a_4 <= 7'd28;
                    30: index_a_4 <= 7'd28;
                    31: index_a_4 <= 7'd28;
                    32: index_a_4 <= 7'd36;
                    33: index_a_4 <= 7'd36;
                    34: index_a_4 <= 7'd36;
                    35: index_a_4 <= 7'd36;
                    36: index_a_4 <= 7'd36;
                    37: index_a_4 <= 7'd36;
                    38: index_a_4 <= 7'd36;
                    39: index_a_4 <= 7'd36;
                    40: index_a_4 <= 7'd44;
                    41: index_a_4 <= 7'd44;
                    42: index_a_4 <= 7'd44;
                    43: index_a_4 <= 7'd44;
                    44: index_a_4 <= 7'd44;
                    45: index_a_4 <= 7'd44;
                    46: index_a_4 <= 7'd44;
                    47: index_a_4 <= 7'd44;
                    48: index_a_4 <= 7'd52;
                    49: index_a_4 <= 7'd52;
                    50: index_a_4 <= 7'd52;
                    51: index_a_4 <= 7'd52;
                    52: index_a_4 <= 7'd52;
                    53: index_a_4 <= 7'd52;
                    54: index_a_4 <= 7'd52;
                    55: index_a_4 <= 7'd52;
                    56: index_a_4 <= 7'd60;
                    57: index_a_4 <= 7'd60;
                    58: index_a_4 <= 7'd60;
                    59: index_a_4 <= 7'd60;
                    60: index_a_4 <= 7'd60;
                    61: index_a_4 <= 7'd60;
                    62: index_a_4 <= 7'd60;
                    63: index_a_4 <= 7'd60;
                endcase

                case (done_B_4)
                    0: index_b_4 <= 7'd0;
                    1: index_b_4 <= 7'd33;
                    2: index_b_4 <= 7'd34;
                    3: index_b_4 <= 7'd35;
                    4: index_b_4 <= 7'd36;
                    5: index_b_4 <= 7'd37;
                    6: index_b_4 <= 7'd38;
                    7: index_b_4 <= 7'd39;
                    8: index_b_4 <= 7'd32;
                    9: index_b_4 <= 7'd33;
                    10: index_b_4 <= 7'd34;
                    11: index_b_4 <= 7'd35;
                    12: index_b_4 <= 7'd36;
                    13: index_b_4 <= 7'd37;
                    14: index_b_4 <= 7'd38;
                    15: index_b_4 <= 7'd39;
                    16: index_b_4 <= 7'd32;
                    17: index_b_4 <= 7'd33;
                    18: index_b_4 <= 7'd34;
                    19: index_b_4 <= 7'd35;
                    20: index_b_4 <= 7'd36;
                    21: index_b_4 <= 7'd37;
                    22: index_b_4 <= 7'd38;
                    23: index_b_4 <= 7'd39;
                    24: index_b_4 <= 7'd32;
                    25: index_b_4 <= 7'd33;
                    26: index_b_4 <= 7'd34;
                    27: index_b_4 <= 7'd35;
                    28: index_b_4 <= 7'd36;
                    29: index_b_4 <= 7'd37;
                    30: index_b_4 <= 7'd38;
                    31: index_b_4 <= 7'd39;
                    32: index_b_4 <= 7'd32;
                    33: index_b_4 <= 7'd33;
                    34: index_b_4 <= 7'd34;
                    35: index_b_4 <= 7'd35;
                    36: index_b_4 <= 7'd36;
                    37: index_b_4 <= 7'd37;
                    38: index_b_4 <= 7'd38;
                    39: index_b_4 <= 7'd39;
                    40: index_b_4 <= 7'd32;
                    41: index_b_4 <= 7'd33;
                    42: index_b_4 <= 7'd34;
                    43: index_b_4 <= 7'd35;
                    44: index_b_4 <= 7'd36;
                    45: index_b_4 <= 7'd37;
                    46: index_b_4 <= 7'd38;
                    47: index_b_4 <= 7'd39;
                    48: index_b_4 <= 7'd32;
                    49: index_b_4 <= 7'd33;
                    50: index_b_4 <= 7'd34;
                    51: index_b_4 <= 7'd35;
                    52: index_b_4 <= 7'd36;
                    53: index_b_4 <= 7'd37;
                    54: index_b_4 <= 7'd38;
                    55: index_b_4 <= 7'd39;
                    56: index_b_4 <= 7'd32;
                    57: index_b_4 <= 7'd33;
                    58: index_b_4 <= 7'd34;
                    59: index_b_4 <= 7'd35;
                    60: index_b_4 <= 7'd36;
                    61: index_b_4 <= 7'd37;
                    62: index_b_4 <= 7'd38;
                    63: index_b_4 <= 7'd39;
                endcase

                state_4 <= LOAD_4;  // Load next vector values
            end

        endcase
    end
end


            assign xor_out_4 = neg_col_4 ^ neg_row_4;
            assign and_out_4 = unary_col_4 && unary_row_4;



// Sixth State Machine

    reg signed unary_col_5 ;
    reg signed unary_row_5 ;
    reg signed neg_row_5;
    reg signed neg_col_5 ;
    wire signed xor_out_5 ;
    wire signed and_out_5 ;
    reg signed [7:0] counta_5;
    reg signed [7:0] countb_5;   // 8-bit counters
    reg [7:0] index_a_5;            // Index for vector selection
    reg [7:0] index_b_5;
    reg [7:0] done_A_5;
    reg [7:0] done_B_5;
    reg [2:0] state_5;            // State variable
  //   reg done_1;
     reg signed [15:0] C00_5 [0:63];
     reg signed [15:0] counter_5;
    localparam IDLE_5     = 3'b00,  // IDLE state
               LOAD_5     = 3'b01,  // Load state for vector values
               COUNT_A_5  = 3'b10,  // Decrement/Increment counta state
               COUNT_B_5  = 3'b11,  // Decrement/Increment countb state
               CHANGE_5   = 3'b100;



always @(posedge clk) begin
        if (rst) begin
            counta_5 <= 8'd0;
            countb_5 <= 8'd0;
            index_a_5 <= 7'd5;
            index_b_5 <= 7'd40;
            done_A_5 <= 0;
            done_B_5 <= 0;
            counter_5 <= 0;
            unary_col_5 <= 0;
            unary_row_5 <= 0;
            neg_row_5 <= 0;
            neg_col_5 <= 0;
            
            n <= 0;
            state_5 <= IDLE_5;
            //done_1 <= 1'b0;
        end else begin
            case (state_5)
                IDLE_3: begin
                    // Wait in idle, start processing when index is within bounds
                    if (index_a_5 < 7'd64) begin
                        state_5 <= LOAD_5;
                    end else begin
                       // done_1 <= 1'b1;  // Done when all vectors processed
                    end
                end

                LOAD_3: begin
                    // Load the nth value from vector_a and vector_b into counta and countb
                    counta_5 <= vector_a[index_a_5*8+:8];
                    countb_5 <= vector_b[index_b_5*8+:8];
                    
                
                    state_5 <= COUNT_A_5;  // Start with counta
                end

                COUNT_A_5: begin
                if (counta_5 == 0) begin
                        done_A_5 <= done_A_5 + 1;
                        C00_5[n] <= counter_5;
                        done_B_5 <= done_B_5 + 1;
                        state_5 <= CHANGE_5;
                    end
                    // First, decrement or increment counta
                   else if (counta_5 > 0) begin
                        counta_5 <= counta_5 - 1;
                        state_5 <= COUNT_B_5;
                    end else if (counta_5 < 0) begin
                        counta_5 <= counta_5 + 1;
                        state_5 <= COUNT_B_5;
                    end

                    if (counta_5 > 0) begin
                      unary_col_5 <= 1;
                      neg_col_5 <= 0; end
                  else if  (counta_5 < 0) begin
                       unary_col_5 <= 0;
                       neg_col_5 <= 1; end
                 if (countb_5 > 0)   begin 
                      unary_row_5 <= 1;
                      neg_row_5 <= 0; end
                 else if (countb_5 < 0) begin
                    unary_row_5 <= 0;
                    neg_row_5 <= 1; end

                    // After one decrement/increment of counta, go to countb state
                    
                end

                 COUNT_B_5: begin
                // Now decrement or increment countb until it reaches 0
                if (countb_5 > 0) begin
                    countb_5 <= countb_5 - 1;
                    if (xor_out_5 == 0) begin
             
                counter_5 <= counter_5 + 1; end 
             
             else if (xor_out_5 == 1) begin
             
                counter_5 <= counter_5 - 1; end
                end else if (countb_5 < 0) begin
                    countb_5 <= countb_5 + 1;
                    if (xor_out_5 == 0) begin
             
                counter_5 <= counter_5 + 1; end 
             
             else if (xor_out_5 == 1) begin
             
                counter_5 <= counter_5 - 1; end
                end else begin
                    // When countb reaches 0, go back to counta if counta > 0
                    if (counta_5 != 0) begin
                        state_5 <= COUNT_A_5;  // Continue with counta
                        countb_5 <= vector_b[index_b_5*8+:8];
                    end else if (counta_5 == 0) begin
                        done_A_5 <= done_A_5 + 1;
                        C00_5[n] <= counter_5;
                        done_B_5 <= done_B_5 + 1;
                        state_5 <= CHANGE_5;
                    end
                end
            end

            CHANGE_5: begin
            
                n = n+1;
                counter_5 <= 0;
                // Both counta and countb are 0, load next values
                case (done_A_5)
                    0: index_a_5 <= 7'd0;
                    1: index_a_5 <= 7'd5;
                    2: index_a_5 <= 7'd5;
                    3: index_a_5 <= 7'd5;
                    4: index_a_5 <= 7'd5;
                    5: index_a_5 <= 7'd5;
                    6: index_a_5 <= 7'd5;
                    7: index_a_5 <= 7'd5;
                    8: index_a_5 <= 7'd13;
                    9: index_a_5 <= 7'd13;
                    10: index_a_5 <= 7'd13;
                    11: index_a_5 <= 7'd13;
                    12: index_a_5 <= 7'd13;
                    13: index_a_5 <= 7'd13;
                    14: index_a_5 <= 7'd13;
                    15: index_a_5 <= 7'd13;
                    16: index_a_5 <= 7'd21;
                    17: index_a_5 <= 7'd21;
                    18: index_a_5 <= 7'd21;
                    19: index_a_5 <= 7'd21;
                    20: index_a_5 <= 7'd21;
                    21: index_a_5 <= 7'd21;
                    22: index_a_5 <= 7'd21;
                    23: index_a_5 <= 7'd21;
                    24: index_a_5 <= 7'd29;
                    25: index_a_5 <= 7'd29;
                    26: index_a_5 <= 7'd29;
                    27: index_a_5 <= 7'd29;
                    28: index_a_5 <= 7'd29;
                    29: index_a_5 <= 7'd29;
                    30: index_a_5 <= 7'd29;
                    31: index_a_5 <= 7'd29;
                    32: index_a_5 <= 7'd37;
                    33: index_a_5 <= 7'd37;
                    34: index_a_5 <= 7'd37;
                    35: index_a_5 <= 7'd37;
                    36: index_a_5 <= 7'd37;
                    37: index_a_5 <= 7'd37;
                    38: index_a_5 <= 7'd37;
                    39: index_a_5 <= 7'd37;
                    40: index_a_5 <= 7'd45;
                    41: index_a_5 <= 7'd45;
                    42: index_a_5 <= 7'd45;
                    43: index_a_5 <= 7'd45;
                    44: index_a_5 <= 7'd45;
                    45: index_a_5 <= 7'd45;
                    46: index_a_5 <= 7'd45;
                    47: index_a_5 <= 7'd45;
                    48: index_a_5 <= 7'd53;
                    49: index_a_5 <= 7'd53;
                    50: index_a_5 <= 7'd53;
                    51: index_a_5 <= 7'd53;
                    52: index_a_5 <= 7'd53;
                    53: index_a_5 <= 7'd53;
                    54: index_a_5 <= 7'd53;
                    55: index_a_5 <= 7'd53;
                    56: index_a_5 <= 7'd61;
                    57: index_a_5 <= 7'd61;
                    58: index_a_5 <= 7'd61;
                    59: index_a_5 <= 7'd61;
                    60: index_a_5 <= 7'd61;
                    61: index_a_5 <= 7'd61;
                    62: index_a_5 <= 7'd61;
                    63: index_a_5 <= 7'd61;
                endcase

                case (done_B_5)
                    0: index_b_5 <= 7'd0;
                    1: index_b_5 <= 7'd41;
                    2: index_b_5 <= 7'd42;
                    3: index_b_5 <= 7'd43;
                    4: index_b_5 <= 7'd44;
                    5: index_b_5 <= 7'd45;
                    6: index_b_5 <= 7'd46;
                    7: index_b_5 <= 7'd47;
                    8: index_b_5 <= 7'd40;
                    9: index_b_5 <= 7'd41;
                    10: index_b_5 <= 7'd42;
                    11: index_b_5 <= 7'd43;
                    12: index_b_5 <= 7'd44;
                    13: index_b_5 <= 7'd45;
                    14: index_b_5 <= 7'd46;
                    15: index_b_5 <= 7'd47;
                    16: index_b_5 <= 7'd40;
                    17: index_b_5 <= 7'd41;
                    18: index_b_5 <= 7'd42;
                    19: index_b_5 <= 7'd43;
                    20: index_b_5 <= 7'd44;
                    21: index_b_5 <= 7'd45;
                    22: index_b_5 <= 7'd46;
                    23: index_b_5 <= 7'd47;
                    24: index_b_5 <= 7'd40;
                    25: index_b_5 <= 7'd41;
                    26: index_b_5 <= 7'd42;
                    27: index_b_5 <= 7'd43;
                    28: index_b_5 <= 7'd44;
                    29: index_b_5 <= 7'd45;
                    30: index_b_5 <= 7'd46;
                    31: index_b_5 <= 7'd47;
                    32: index_b_5 <= 7'd40;
                    33: index_b_5 <= 7'd41;
                    34: index_b_5 <= 7'd42;
                    35: index_b_5 <= 7'd43;
                    36: index_b_5 <= 7'd44;
                    37: index_b_5 <= 7'd45;
                    38: index_b_5 <= 7'd46;
                    39: index_b_5 <= 7'd47;
                    40: index_b_5 <= 7'd40;
                    41: index_b_5 <= 7'd41;
                    42: index_b_5 <= 7'd42;
                    43: index_b_5 <= 7'd43;
                    44: index_b_5 <= 7'd44;
                    45: index_b_5 <= 7'd45;
                    46: index_b_5 <= 7'd46;
                    47: index_b_5 <= 7'd47;
                    48: index_b_5 <= 7'd40;
                    49: index_b_5 <= 7'd41;
                    50: index_b_5 <= 7'd42;
                    51: index_b_5 <= 7'd43;
                    52: index_b_5 <= 7'd44;
                    53: index_b_5 <= 7'd45;
                    54: index_b_5 <= 7'd46;
                    55: index_b_5 <= 7'd47;
                    56: index_b_5 <= 7'd40;
                    57: index_b_5 <= 7'd41;
                    58: index_b_5 <= 7'd42;
                    59: index_b_5 <= 7'd43;
                    60: index_b_5 <= 7'd44;
                    61: index_b_5 <= 7'd45;
                    62: index_b_5 <= 7'd46;
                    63: index_b_5 <= 7'd47;
                endcase

                state_5 <= LOAD_5;  // Load next vector values
            end

        endcase
    end
end


            assign xor_out_5 = neg_col_5 ^ neg_row_5;
            assign and_out_5 = unary_col_5 && unary_row_5;






// Seventh State Machine


reg signed unary_col_6 ;
    reg signed unary_row_6 ;
    reg signed neg_row_6;
    reg signed neg_col_6 ;
    wire signed xor_out_6 ;
    wire signed and_out_6 ;
    reg signed [7:0] counta_6;
    reg signed [7:0] countb_6;   // 8-bit counters
    reg [7:0] index_a_6;            // Index for vector selection
    reg [7:0] index_b_6;
    reg [7:0] done_A_6;
    reg [7:0] done_B_6;
    reg [2:0] state_6;            // State variable
  //   reg done_1;
     reg signed [15:0] C00_6 [0:63];
     reg signed [15:0] counter_6;
    localparam IDLE_6     = 3'b00,  // IDLE state
               LOAD_6     = 3'b01,  // Load state for vector values
               COUNT_A_6  = 3'b10,  // Decrement/Increment counta state
               COUNT_B_6  = 3'b11,  // Decrement/Increment countb state
               CHANGE_6   = 3'b100;



always @(posedge clk) begin
        if (rst) begin
            counta_6 <= 8'd0;
            countb_6 <= 8'd0;
            index_a_6 <= 7'd6;
            index_b_6 <= 7'd48;
            done_A_6 <= 0;
            done_B_6 <= 0;
            counter_6 <= 0;
            unary_col_6 <= 0;
            unary_row_6 <= 0;
            neg_row_6 <= 0;
            neg_col_6 <= 0;
            
            o <= 0;
            state_6 <= IDLE_6;
            //done_1 <= 1'b0;
        end else begin
            case (state_6)
                IDLE_3: begin
                    // Wait in idle, start processing when index is within bounds
                    if (index_a_6 < 7'd64) begin
                        state_6 <= LOAD_6;
                    end else begin
                       // done_1 <= 1'b1;  // Done when all vectors processed
                    end
                end

                LOAD_3: begin
                    // Load the nth value from vector_a and vector_b into counta and countb
                    counta_6 <= vector_a[index_a_6*8+:8];
                    countb_6 <= vector_b[index_b_6*8+:8];
                    
                
                    state_6 <= COUNT_A_6;  // Start with counta
                end

                COUNT_A_6: begin
                if (counta_6 == 0) begin
                        done_A_6 <= done_A_6 + 1;
                        C00_6[o] <= counter_6;
                        done_B_6 <= done_B_6 + 1;
                        state_6 <= CHANGE_6;
                    end
                    // First, decrement or increment counta
                    else if (counta_6 > 0) begin
                        counta_6 <= counta_6 - 1;
                        state_6 <= COUNT_B_6;
                    end else if (counta_6 < 0) begin
                        counta_6 <= counta_6 + 1;
                        state_6 <= COUNT_B_6;
                    end

                    if (counta_6 > 0) begin
                      unary_col_6 <= 1;
                      neg_col_6 <= 0; end
                  else if  (counta_6 < 0) begin
                       unary_col_6 <= 0;
                       neg_col_6 <= 1; end
                 if (countb_6 > 0)   begin 
                      unary_row_6 <= 1;
                      neg_row_6 <= 0; end
                 else if (countb_6 < 0) begin
                    unary_row_6 <= 0;
                    neg_row_6 <= 1; end

                    // After one decrement/increment of counta, go to countb state
                    
                end

                 COUNT_B_6: begin
                // Now decrement or increment countb until it reaches 0
                if (countb_6 > 0) begin
                    countb_6 <= countb_6 - 1;
                    if (xor_out_6 == 0) begin
             
                counter_6 <= counter_6 + 1; end 
             
             else if (xor_out_6 == 1) begin
             
                counter_6 <= counter_6 - 1; end
                end else if (countb_6 < 0) begin
                    countb_6 <= countb_6 + 1;
                    if (xor_out_6 == 0) begin
             
                counter_6 <= counter_6 + 1; end 
             
             else if (xor_out_6 == 1) begin
             
                counter_6 <= counter_6 - 1; end
                end else begin
                    // When countb reaches 0, go back to counta if counta > 0
                    if (counta_6 != 0) begin
                        state_6 <= COUNT_A_6;  // Continue with counta
                        countb_6 <= vector_b[index_b_6*8+:8];
                    end else if (counta_6 == 0) begin
                        done_A_6 <= done_A_6 + 1;
                        C00_6[o] <= counter_6;
                        done_B_6 <= done_B_6 + 1;
                        state_6 <= CHANGE_6;
                    end
                end
            end

            CHANGE_6: begin
            
                o = o + 1;
                counter_6 <= 0;
                // Both counta and countb are 0, load next values
                case (done_A_6)
                    0: index_a_6 <= 7'd0;
                    1: index_a_6 <= 7'd6;
                    2: index_a_6 <= 7'd6;
                    3: index_a_6 <= 7'd6;
                    4: index_a_6 <= 7'd6;
                    5: index_a_6 <= 7'd6;
                    6: index_a_6 <= 7'd6;
                    7: index_a_6 <= 7'd6;
                    8: index_a_6 <= 7'd14;
                    9: index_a_6 <= 7'd14;
                    10: index_a_6 <= 7'd14;
                    11: index_a_6 <= 7'd14;
                    12: index_a_6 <= 7'd14;
                    13: index_a_6 <= 7'd14;
                    14: index_a_6 <= 7'd14;
                    15: index_a_6 <= 7'd14;
                    16: index_a_6 <= 7'd22;
                    17: index_a_6 <= 7'd22;
                    18: index_a_6 <= 7'd22;
                    19: index_a_6 <= 7'd22;
                    20: index_a_6 <= 7'd22;
                    21: index_a_6 <= 7'd22;
                    22: index_a_6 <= 7'd22;
                    23: index_a_6 <= 7'd22;
                    24: index_a_6 <= 7'd30;
                    25: index_a_6 <= 7'd30;
                    26: index_a_6 <= 7'd30;
                    27: index_a_6 <= 7'd30;
                    28: index_a_6 <= 7'd30;
                    29: index_a_6 <= 7'd30;
                    30: index_a_6 <= 7'd30;
                    31: index_a_6 <= 7'd30;
                    32: index_a_6 <= 7'd38;
                    33: index_a_6 <= 7'd38;
                    34: index_a_6 <= 7'd38;
                    35: index_a_6 <= 7'd38;
                    36: index_a_6 <= 7'd38;
                    37: index_a_6 <= 7'd38;
                    38: index_a_6 <= 7'd38;
                    39: index_a_6 <= 7'd38;
                    40: index_a_6 <= 7'd46;
                    41: index_a_6 <= 7'd46;
                    42: index_a_6 <= 7'd46;
                    43: index_a_6 <= 7'd46;
                    44: index_a_6 <= 7'd46;
                    45: index_a_6 <= 7'd46;
                    46: index_a_6 <= 7'd46;
                    47: index_a_6 <= 7'd46;
                    48: index_a_6 <= 7'd54;
                    49: index_a_6 <= 7'd54;
                    50: index_a_6 <= 7'd54;
                    51: index_a_6 <= 7'd54;
                    52: index_a_6 <= 7'd54;
                    53: index_a_6 <= 7'd54;
                    54: index_a_6 <= 7'd54;
                    55: index_a_6 <= 7'd54;
                    56: index_a_6 <= 7'd62;
                    57: index_a_6 <= 7'd62;
                    58: index_a_6 <= 7'd62;
                    59: index_a_6 <= 7'd62;
                    60: index_a_6 <= 7'd62;
                    61: index_a_6 <= 7'd62;
                    62: index_a_6 <= 7'd62;
                    63: index_a_6 <= 7'd62;
                endcase

                case (done_B_6)
                    0: index_b_6 <= 7'd0;
                    1: index_b_6 <= 7'd49;
                    2: index_b_6 <= 7'd50;
                    3: index_b_6 <= 7'd51;
                    4: index_b_6 <= 7'd52;
                    5: index_b_6 <= 7'd53;
                    6: index_b_6 <= 7'd54;
                    7: index_b_6 <= 7'd55;
                    8: index_b_6 <= 7'd48;
                    9: index_b_6 <= 7'd49;
                    10: index_b_6 <= 7'd50;
                    11: index_b_6 <= 7'd51;
                    12: index_b_6 <= 7'd52;
                    13: index_b_6 <= 7'd53;
                    14: index_b_6 <= 7'd54;
                    15: index_b_6 <= 7'd55;
                    16: index_b_6 <= 7'd48;
                    17: index_b_6 <= 7'd49;
                    18: index_b_6 <= 7'd50;
                    19: index_b_6 <= 7'd51;
                    20: index_b_6 <= 7'd52;
                    21: index_b_6 <= 7'd53;
                    22: index_b_6 <= 7'd54;
                    23: index_b_6 <= 7'd55;
                    24: index_b_6 <= 7'd48;
                    25: index_b_6 <= 7'd49;
                    26: index_b_6 <= 7'd50;
                    27: index_b_6 <= 7'd51;
                    28: index_b_6 <= 7'd52;
                    29: index_b_6 <= 7'd53;
                    30: index_b_6 <= 7'd54;
                    31: index_b_6 <= 7'd55;
                    32: index_b_6 <= 7'd48;
                    33: index_b_6 <= 7'd49;
                    34: index_b_6 <= 7'd50;
                    35: index_b_6 <= 7'd51;
                    36: index_b_6 <= 7'd52;
                    37: index_b_6 <= 7'd53;
                    38: index_b_6 <= 7'd54;
                    39: index_b_6 <= 7'd55;
                    40: index_b_6 <= 7'd48;
                    41: index_b_6 <= 7'd49;
                    42: index_b_6 <= 7'd50;
                    43: index_b_6 <= 7'd51;
                    44: index_b_6 <= 7'd52;
                    45: index_b_6 <= 7'd53;
                    46: index_b_6 <= 7'd54;
                    47: index_b_6 <= 7'd55;
                    48: index_b_6 <= 7'd48;
                    49: index_b_6 <= 7'd49;
                    50: index_b_6 <= 7'd50;
                    51: index_b_6 <= 7'd51;
                    52: index_b_6 <= 7'd52;
                    53: index_b_6 <= 7'd53;
                    54: index_b_6 <= 7'd54;
                    55: index_b_6 <= 7'd55;
                    56: index_b_6 <= 7'd48;
                    57: index_b_6 <= 7'd49;
                    58: index_b_6 <= 7'd50;
                    59: index_b_6 <= 7'd51;
                    60: index_b_6 <= 7'd52;
                    61: index_b_6 <= 7'd53;
                    62: index_b_6 <= 7'd54;
                    63: index_b_6 <= 7'd55;
                endcase

                state_6 <= LOAD_6;  // Load next vector values
            end

        endcase
    end
end


            assign xor_out_6 = neg_col_6 ^ neg_row_6;
            assign and_out_6 = unary_col_6 && unary_row_6;


// Eigth State Machine

reg signed unary_col_7 ;
    reg signed unary_row_7 ;
    reg signed neg_row_7;
    reg signed neg_col_7 ;
    wire signed xor_out_7 ;
    wire signed and_out_7 ;
    reg signed [7:0] counta_7;
    reg signed [7:0] countb_7;   // 8-bit counters
    reg [7:0] index_a_7;            // Index for vector selection
    reg [7:0] index_b_7;
    reg [7:0] done_A_7;
    reg [7:0] done_B_7;
    reg [2:0] state_7;            // State variable
  //   reg done_1;
     reg signed [15:0] C00_7 [0:63];
     reg signed [15:0] counter_7;
    localparam IDLE_7     = 3'b00,  // IDLE state
               LOAD_7     = 3'b01,  // Load state for vector values
               COUNT_A_7  = 3'b10,  // Decrement/Increment counta state
               COUNT_B_7  = 3'b11,  // Decrement/Increment countb state
               CHANGE_7   = 3'b100;



always @(posedge clk) begin
        if (rst) begin
            counta_7 <= 8'd0;
            countb_7 <= 8'd0;
            index_a_7 <= 7'd7;
            index_b_7 <= 7'd56;
            done_A_7 <= 0;
            done_B_7 <= 0;
            counter_7 <= 0;
            unary_col_7 <= 0;
            unary_row_7 <= 0;
            neg_row_7 <= 0;
            neg_col_7 <= 0;
            
            p <= 0;
            state_7 <= IDLE_7;
            //done_1 <= 1'b0;
        end else begin
            case (state_7)
                IDLE_3: begin
                    // Wait in idle, start processing when index is within bounds
                    if (index_a_7 < 7'd64) begin
                        state_7 <= LOAD_7;
                    end else begin
                       // done_1 <= 1'b1;  // Done when all vectors processed
                    end
                end

                LOAD_3: begin
                    // Load the nth value from vector_a and vector_b into counta and countb
                    counta_7 <= vector_a[index_a_7*8+:8];
                    countb_7 <= vector_b[index_b_7*8+:8];
                    
                
                    state_7 <= COUNT_A_7;  // Start with counta
                end

                COUNT_A_7: begin
                if (counta_7 == 0) begin
                        done_A_7 <= done_A_7 + 1;
                        C00_7[p] <= counter_7;
                        done_B_7 <= done_B_7 + 1;
                        state_7 <= CHANGE_7;
                    end
                    // First, decrement or increment counta
                    else if (counta_7 > 0) begin
                        counta_7 <= counta_7 - 1;
                        state_7 <= COUNT_B_7;
                    end else if (counta_7 < 0) begin
                        counta_7 <= counta_7 + 1;
                        state_7 <= COUNT_B_7;
                    end

                    if (counta_7 > 0) begin
                      unary_col_7 <= 1;
                      neg_col_7 <= 0; end
                  else if  (counta_7 < 0) begin
                       unary_col_7 <= 0;
                       neg_col_7 <= 1; end
                 if (countb_7 > 0)   begin 
                      unary_row_7 <= 1;
                      neg_row_7 <= 0; end
                 else if (countb_7 < 0) begin
                    unary_row_7 <= 0;
                    neg_row_7 <= 1; end

                    // After one decrement/increment of counta, go to countb state
                    
                end

                 COUNT_B_7: begin
                // Now decrement or increment countb until it reaches 0
                if (countb_7 > 0) begin
                    countb_7 <= countb_7 - 1;
                    if (xor_out_7 == 0) begin
             
                counter_7 <= counter_7 + 1; end 
             
             else if (xor_out_7 == 1) begin
             
                counter_7 <= counter_7 - 1; end
                end else if (countb_7 < 0) begin
                    countb_7 <= countb_7 + 1;
                    if (xor_out_7 == 0) begin
             
                counter_7 <= counter_7 + 1; end 
             
             else if (xor_out_7 == 1) begin
             
                counter_7 <= counter_7 - 1; end
                end else begin
                    // When countb reaches 0, go back to counta if counta > 0
                    if (counta_7 != 0) begin
                        state_7 <= COUNT_A_7;  // Continue with counta
                        countb_7 <= vector_b[index_b_7*8+:8];
                    end else if (counta_7 == 0) begin
                        done_A_7 <= done_A_7 + 1;
                        C00_7[p] <= counter_7;
                        done_B_7 <= done_B_7 + 1;
                        state_7 <= CHANGE_7;
                    end
                end
            end

            CHANGE_7: begin
            
                p = p+1;
                counter_7 <= 0;
                // Both counta and countb are 0, load next values
                case (done_A_7)
                    0: index_a_7 <= 7'd0;
                    1: index_a_7 <= 7'd7;
                    2: index_a_7 <= 7'd7;
                    3: index_a_7 <= 7'd7;
                    4: index_a_7 <= 7'd7;
                    5: index_a_7 <= 7'd7;
                    6: index_a_7 <= 7'd7;
                    7: index_a_7 <= 7'd7;
                    8: index_a_7 <= 7'd15;
                    9: index_a_7 <= 7'd15;
                    10: index_a_7 <= 7'd15;
                    11: index_a_7 <= 7'd15;
                    12: index_a_7 <= 7'd15;
                    13: index_a_7 <= 7'd15;
                    14: index_a_7 <= 7'd15;
                    15: index_a_7 <= 7'd15;
                    16: index_a_7 <= 7'd23;
                    17: index_a_7 <= 7'd23;
                    18: index_a_7 <= 7'd23;
                    19: index_a_7 <= 7'd23;
                    20: index_a_7 <= 7'd23;
                    21: index_a_7 <= 7'd23;
                    22: index_a_7 <= 7'd23;
                    23: index_a_7 <= 7'd23;
                    24: index_a_7 <= 7'd31;
                    25: index_a_7 <= 7'd31;
                    26: index_a_7 <= 7'd31;
                    27: index_a_7 <= 7'd31;
                    28: index_a_7 <= 7'd31;
                    29: index_a_7 <= 7'd31;
                    30: index_a_7 <= 7'd31;
                    31: index_a_7 <= 7'd31;
                    32: index_a_7 <= 7'd39;
                    33: index_a_7 <= 7'd39;
                    34: index_a_7 <= 7'd39;
                    35: index_a_7 <= 7'd39;
                    36: index_a_7 <= 7'd39;
                    37: index_a_7 <= 7'd39;
                    38: index_a_7 <= 7'd39;
                    39: index_a_7 <= 7'd39;
                    40: index_a_7 <= 7'd47;
                    41: index_a_7 <= 7'd47;
                    42: index_a_7 <= 7'd47;
                    43: index_a_7 <= 7'd47;
                    44: index_a_7 <= 7'd47;
                    45: index_a_7 <= 7'd47;
                    46: index_a_7 <= 7'd47;
                    47: index_a_7 <= 7'd47;
                    48: index_a_7 <= 7'd55;
                    49: index_a_7 <= 7'd55;
                    50: index_a_7 <= 7'd55;
                    51: index_a_7 <= 7'd55;
                    52: index_a_7 <= 7'd55;
                    53: index_a_7 <= 7'd55;
                    54: index_a_7 <= 7'd55;
                    55: index_a_7 <= 7'd55;
                    56: index_a_7 <= 7'd63;
                    57: index_a_7 <= 7'd63;
                    58: index_a_7 <= 7'd63;
                    59: index_a_7 <= 7'd63;
                    60: index_a_7 <= 7'd63;
                    61: index_a_7 <= 7'd63;
                    62: index_a_7 <= 7'd63;
                    63: index_a_7 <= 7'd63;
                endcase

                case (done_B_7)
                    0: index_b_7 <= 7'd0;
                    1: index_b_7 <= 7'd57;
                    2: index_b_7 <= 7'd58;
                    3: index_b_7 <= 7'd59;
                    4: index_b_7 <= 7'd60;
                    5: index_b_7 <= 7'd61;
                    6: index_b_7 <= 7'd62;
                    7: index_b_7 <= 7'd63;
                    8: index_b_7 <= 7'd56;
                    9: index_b_7 <= 7'd57;
                    10: index_b_7 <= 7'd58;
                    11: index_b_7 <= 7'd59;
                    12: index_b_7 <= 7'd60;
                    13: index_b_7 <= 7'd61;
                    14: index_b_7 <= 7'd62;
                    15: index_b_7 <= 7'd63;
                    16: index_b_7 <= 7'd56;
                    17: index_b_7 <= 7'd57;
                    18: index_b_7 <= 7'd58;
                    19: index_b_7 <= 7'd59;
                    20: index_b_7 <= 7'd60;
                    21: index_b_7 <= 7'd61;
                    22: index_b_7 <= 7'd62;
                    23: index_b_7 <= 7'd63;
                    24: index_b_7 <= 7'd56;
                    25: index_b_7 <= 7'd57;
                    26: index_b_7 <= 7'd58;
                    27: index_b_7 <= 7'd59;
                    28: index_b_7 <= 7'd60;
                    29: index_b_7 <= 7'd61;
                    30: index_b_7 <= 7'd62;
                    31: index_b_7 <= 7'd63;
                    32: index_b_7 <= 7'd56;
                    33: index_b_7 <= 7'd57;
                    34: index_b_7 <= 7'd58;
                    35: index_b_7 <= 7'd59;
                    36: index_b_7 <= 7'd60;
                    37: index_b_7 <= 7'd61;
                    38: index_b_7 <= 7'd62;
                    39: index_b_7 <= 7'd63;
                    40: index_b_7 <= 7'd56;
                    41: index_b_7 <= 7'd57;
                    42: index_b_7 <= 7'd58;
                    43: index_b_7 <= 7'd59;
                    44: index_b_7 <= 7'd60;
                    45: index_b_7 <= 7'd61;
                    46: index_b_7 <= 7'd62;
                    47: index_b_7 <= 7'd63;
                    48: index_b_7 <= 7'd56;
                    49: index_b_7 <= 7'd57;
                    50: index_b_7 <= 7'd58;
                    51: index_b_7 <= 7'd59;
                    52: index_b_7 <= 7'd60;
                    53: index_b_7 <= 7'd61;
                    54: index_b_7 <= 7'd62;
                    55: index_b_7 <= 7'd63;
                    56: index_b_7 <= 7'd56;
                    57: index_b_7 <= 7'd57;
                    58: index_b_7 <= 7'd58;
                    59: index_b_7 <= 7'd59;
                    60: index_b_7 <= 7'd60;
                    61: index_b_7 <= 7'd61;
                    62: index_b_7 <= 7'd62;
                    63: index_b_7 <= 7'd63;
                endcase

                state_7 <= LOAD_7;  // Load next vector values
            end

        endcase
    end
end


            assign xor_out_7 = neg_col_7 ^ neg_row_7;
            assign and_out_7 = unary_col_7 && unary_row_7;







//reg done_1_reg;
//always@(posedge clk)
//begin
//if(rst)
//done_1_reg <= 0; else
//    if(done_A_4 == 2'd3 && countb_4 )
//    done_1_reg = 1;
//end

//always@(posedge clk)
//begin
//if(rst)
// done_1 <= 0; else
//    if(done_1_reg && done_A_1 == 4'd15 && counta_1 == 0 && countb_1 == 0 )
//    done_1 = 1;
//end



always@(posedge clk)
begin
//    if(done_1)
//    begin
        Row_00 <= C00[0] + C00_1[0] + C00_2[0] + C00_3[0] + C00_4[0] + C00_5[0] + C00_6[0] + C00_7[0];
        Row_01 <= C00[1] + C00_1[1] + C00_2[1] + C00_3[1] + C00_4[1] + C00_5[1] + C00_6[1] + C00_7[1];
        Row_02 <= C00[2] + C00_1[2] + C00_2[2] + C00_3[2] + C00_4[2] + C00_5[2] + C00_6[2] + C00_7[2];
        Row_03 <= C00[3] + C00_1[3] + C00_2[3] + C00_3[3] + C00_4[3] + C00_5[3] + C00_6[3] + C00_7[3];
        Row_04 <= C00[4] + C00_1[4] + C00_2[4] + C00_3[4] + C00_4[4] + C00_5[4] + C00_6[4] + C00_7[4];
        Row_05 <= C00[5] + C00_1[5] + C00_2[5] + C00_3[5] + C00_4[5] + C00_5[5] + C00_6[5] + C00_7[5];
        Row_06 <= C00[6] + C00_1[6] + C00_2[6] + C00_3[6] + C00_4[6] + C00_5[6] + C00_6[6] + C00_7[6];
        Row_07 <= C00[7] + C00_1[7] + C00_2[7] + C00_3[7] + C00_4[7] + C00_5[7] + C00_6[7] + C00_7[7];
        Row_10 <=  C00_1[8] +   C00_6[8]  ;  
        Row_11 <=  C00_1[9] +    C00_6[9] ;
        Row_12 <=  C00_1[10] +     C00_6[10] ;
        Row_13 <=  C00_1[11] +     C00_6[11] ;
        Row_14 <=  C00_1[12] +      C00_6[12];
        Row_15 <=  C00_1[13] +    C00_6[13] ;
        Row_16 <=  C00_1[14] +   C00_6[14];
        Row_17 <=  C00_1[15] +     C00_6[15];
        Row_20 <= C00[16] +   C00_3[16] + C00_4[16] +   C00_7[16];
        Row_21 <= C00[17] +   C00_3[17] + C00_4[17] +   C00_7[17];
        Row_22 <= C00[18] + C00_3[18] + C00_4[18] +   C00_7[18];
        Row_23 <= C00[19] +   C00_3[19] + C00_4[19] +   C00_7[19];
        Row_24 <= C00[20] +   C00_3[20] + C00_4[20] +   C00_7[20];
        Row_25 <= C00[21] +   C00_3[21] + C00_4[21] +   C00_7[21];
        Row_26 <= C00[22] +   C00_3[22] + C00_4[22] +   C00_7[22];
        Row_27 <= C00[23] +   C00_3[23] + C00_4[23] +   C00_7[23];
        Row_30 <= C00[24] +      C00_7[24];
        Row_31 <= C00[25] +     C00_7[25];
        Row_32 <= C00[26] +     C00_7[26];
        Row_33 <= C00[27] +      C00_7[27];
        Row_34 <= C00[28] +      C00_7[28];
        Row_35 <= C00[29] +      C00_7[29];
        Row_36 <= C00[30] +      C00_7[30];
        Row_37 <=  C00[31] +      C00_7[31];
        Row_40 <= C00[32] + C00_1[32] + C00_2[32] + C00_3[32] + C00_4[32] + C00_5[32] + C00_6[32] + C00_7[32];
        Row_41 <= C00[33] + C00_1[33] + C00_2[33] + C00_3[33] + C00_4[33] + C00_5[33] + C00_6[33] + C00_7[33];
        Row_42 <= C00[34] + C00_1[34] + C00_2[34] + C00_3[34] + C00_4[34] + C00_5[34] + C00_6[34] + C00_7[34];
        Row_43 <= C00[35] + C00_1[35] + C00_2[35] + C00_3[35] + C00_4[35] + C00_5[35] + C00_6[35] + C00_7[35];
        Row_44 <= C00[36] + C00_1[36] + C00_2[36] + C00_3[36] + C00_4[36] + C00_5[36] + C00_6[36] + C00_7[36];
        Row_45 <= C00[37] + C00_1[37] + C00_2[37] + C00_3[37] + C00_4[37] + C00_5[37] + C00_6[37] + C00_7[37];
        Row_46 <= C00[38] + C00_1[38] + C00_2[38] + C00_3[38] + C00_4[38] + C00_5[38] + C00_6[38] + C00_7[38];
        Row_47 <= C00[39] + C00_1[39] + C00_2[39] + C00_3[39] + C00_4[39] + C00_5[39] + C00_6[39] + C00_7[39];
        Row_50 <=    C00_3[40] + C00_4[40] ;
        Row_51 <=     C00_3[41] + C00_4[41];
        Row_52 <=    C00_3[42] + C00_4[42];
        Row_53 <=    C00_3[43] + C00_4[43];
        Row_54 <=    C00_3[44] + C00_4[44];
        Row_55 <=    C00_3[45] + C00_4[45];
        Row_56 <=    C00_3[46] + C00_4[46];         
        Row_57 <=    C00_3[47] + C00_4[47];
        Row_60 <=  C00_1[48] + C00_2[48] +  C00_5[48] + C00_6[48] ;
        Row_61 <=  C00_1[49] + C00_2[49] +  C00_5[49] + C00_6[49] ;
        Row_62 <= C00_1[50] + C00_2[50] +   C00_5[50] + C00_6[50] ;
        Row_63 <= C00_1[51] + C00_2[51] +   C00_5[51] + C00_6[51];
        Row_64 <=  C00_1[52] + C00_2[52] +  C00_5[52] + C00_6[52];
        Row_65 <=  C00_1[53] + C00_2[53] +   C00_5[53] + C00_6[53];
        Row_66 <=  C00_1[54] + C00_2[54] +   C00_5[54] + C00_6[54];
        Row_67 <=  C00_1[55] + C00_2[55] +   C00_5[55] + C00_6[55];
        Row_70 <= C00_2[56]  +  C00_5[56] ;
        Row_71 <=  C00_2[57] +   C00_5[57];
        Row_72 <=  C00_2[58] +   C00_5[58];
        Row_73 <=   C00_2[59] +   C00_5[59];
        Row_74 <=   C00_2[60] +   C00_5[60];
        Row_75 <=   C00_2[61] +  C00_5[61];
        Row_76 <=   C00_2[62] +   C00_5[62];
        Row_77 <=   C00_2[63] +   C00_5[63];
//    end
end



endmodule


//always@(posedge clk)
//begin
////    if(done_1)
////    begin
//        Row_00 <= C00[0] + C00_1[0] + C00_2[0] + C00_3[0] + C00_4[0] + C00_5[0] + C00_6[0] + C00_7[0];
//        Row_01 <= C00[1] + C00_1[1] + C00_2[1] + C00_3[1] + C00_4[1] + C00_5[1] + C00_6[1] + C00_7[1];
//        Row_02 <= C00[2] + C00_1[2] + C00_2[2] + C00_3[2] + C00_4[2] + C00_5[2] + C00_6[2] + C00_7[2];
//        Row_03 <= C00[3] + C00_1[3] + C00_2[3] + C00_3[3] + C00_4[3] + C00_5[3] + C00_6[3] + C00_7[3];
//        Row_04 <= C00[4] + C00_1[4] + C00_2[4] + C00_3[4] + C00_4[4] + C00_5[4] + C00_6[4] + C00_7[4];
//        Row_05 <= C00[5] + C00_1[5] + C00_2[5] + C00_3[5] + C00_4[5] + C00_5[5] + C00_6[5] + C00_7[5];
//        Row_06 <= C00[6] + C00_1[6] + C00_2[6] + C00_3[6] + C00_4[6] + C00_5[6] + C00_6[6] + C00_7[6];
//        Row_07 <= C00[7] + C00_1[7] + C00_2[7] + C00_3[7] + C00_4[7] + C00_5[7] + C00_6[7] + C00_7[7];
//        Row_10 <= C00[8] + C00_1[8] + C00_2[8] + C00_3[8] + C00_4[8] + C00_5[8] + C00_6[8] + C00_7[8];  
//        Row_11 <= C00[9] + C00_1[9] + C00_2[9] + C00_3[9] + C00_4[9] + C00_5[9] + C00_6[9] + C00_7[9];
//        Row_12 <= C00[10] + C00_1[10] + C00_2[10] + C00_3[10] + C00_4[10] + C00_5[10] + C00_6[10] + C00_7[10];
//        Row_13 <= C00[11] + C00_1[11] + C00_2[11] + C00_3[11] + C00_4[11] + C00_5[11] + C00_6[11] + C00_7[11];
//        Row_14 <= C00[12] + C00_1[12] + C00_2[12] + C00_3[12] + C00_4[12] + C00_5[12] + C00_6[12] + C00_7[12];
//        Row_15 <= C00[13] + C00_1[13] + C00_2[13] + C00_3[13] + C00_4[13] + C00_5[13] + C00_6[13] + C00_7[13];
//        Row_16 <= C00[14] + C00_1[14] + C00_2[14] + C00_3[14] + C00_4[14] + C00_5[14] + C00_6[14] + C00_7[14];
//        Row_17 <= C00[15] + C00_1[15] + C00_2[15] + C00_3[15] + C00_4[15] + C00_5[15] + C00_6[15] + C00_7[15];
//        Row_20 <= C00[16] + C00_1[16] + C00_2[16] + C00_3[16] + C00_4[16] + C00_5[16] + C00_6[16] + C00_7[16];
//        Row_21 <= C00[17] + C00_1[17] + C00_2[17] + C00_3[17] + C00_4[17] + C00_5[17] + C00_6[17] + C00_7[17];
//        Row_22 <= C00[18] + C00_1[18] + C00_2[18] + C00_3[18] + C00_4[18] + C00_5[18] + C00_6[18] + C00_7[18];
//        Row_23 <= C00[19] + C00_1[19] + C00_2[19] + C00_3[19] + C00_4[19] + C00_5[19] + C00_6[19] + C00_7[19];
//        Row_24 <= C00[20] + C00_1[20] + C00_2[20] + C00_3[20] + C00_4[20] + C00_5[20] + C00_6[20] + C00_7[20];
//        Row_25 <= C00[21] + C00_1[21] + C00_2[21] + C00_3[21] + C00_4[21] + C00_5[21] + C00_6[21] + C00_7[21];
//        Row_26 <= C00[22] + C00_1[22] + C00_2[22] + C00_3[22] + C00_4[22] + C00_5[22] + C00_6[22] + C00_7[22];
//        Row_27 <= C00[23] + C00_1[23] + C00_2[23] + C00_3[23] + C00_4[23] + C00_5[23] + C00_6[23] + C00_7[23];
//        Row_30 <= C00[24] + C00_1[24] + C00_2[24] + C00_3[24] + C00_4[24] + C00_5[24] + C00_6[24] + C00_7[24];
//        Row_31 <= C00[25] + C00_1[25] + C00_2[25] + C00_3[25] + C00_4[25] + C00_5[25] + C00_6[25] + C00_7[25];
//        Row_32 <= C00[26] + C00_1[26] + C00_2[26] + C00_3[26] + C00_4[26] + C00_5[26] + C00_6[26] + C00_7[26];
//        Row_33 <= C00[27] + C00_1[27] + C00_2[27] + C00_3[27] + C00_4[27] + C00_5[27] + C00_6[27] + C00_7[27];
//        Row_34 <= C00[28] + C00_1[28] + C00_2[28] + C00_3[28] + C00_4[28] + C00_5[28] + C00_6[28] + C00_7[28];
//        Row_35 <= C00[29] + C00_1[29] + C00_2[29] + C00_3[29] + C00_4[29] + C00_5[29] + C00_6[29] + C00_7[29];
//        Row_36 <= C00[30] + C00_1[30] + C00_2[30] + C00_3[30] + C00_4[30] + C00_5[30] + C00_6[30] + C00_7[30];
//        Row_37 <=  C00[31] + C00_1[31] + C00_2[31] + C00_3[31] + C00_4[31] + C00_5[31] + C00_6[31] + C00_7[31];
//        Row_40 <= C00[32] + C00_1[32] + C00_2[32] + C00_3[32] + C00_4[32] + C00_5[32] + C00_6[32] + C00_7[32];
//        Row_41 <= C00[33] + C00_1[33] + C00_2[33] + C00_3[33] + C00_4[33] + C00_5[33] + C00_6[33] + C00_7[33];
//        Row_42 <= C00[34] + C00_1[34] + C00_2[34] + C00_3[34] + C00_4[34] + C00_5[34] + C00_6[34] + C00_7[34];
//        Row_43 <= C00[35] + C00_1[35] + C00_2[35] + C00_3[35] + C00_4[35] + C00_5[35] + C00_6[35] + C00_7[35];
//        Row_44 <= C00[36] + C00_1[36] + C00_2[36] + C00_3[36] + C00_4[36] + C00_5[36] + C00_6[36] + C00_7[36];
//        Row_45 <= C00[37] + C00_1[37] + C00_2[37] + C00_3[37] + C00_4[37] + C00_5[37] + C00_6[37] + C00_7[37];
//        Row_46 <= C00[38] + C00_1[38] + C00_2[38] + C00_3[38] + C00_4[38] + C00_5[38] + C00_6[38] + C00_7[38];
//        Row_47 <= C00[39] + C00_1[39] + C00_2[39] + C00_3[39] + C00_4[39] + C00_5[39] + C00_6[39] + C00_7[39];
//        Row_50 <= C00[40] + C00_1[40] + C00_2[40] + C00_3[40] + C00_4[40] + C00_5[40] + C00_6[40] + C00_7[40];
//        Row_51 <= C00[41] + C00_1[41] + C00_2[41] + C00_3[41] + C00_4[41] + C00_5[41] + C00_6[41] + C00_7[41];
//        Row_52 <= C00[42] + C00_1[42] + C00_2[42] + C00_3[42] + C00_4[42] + C00_5[42] + C00_6[42] + C00_7[42];
//        Row_53 <= C00[43] + C00_1[43] + C00_2[43] + C00_3[43] + C00_4[43] + C00_5[43] + C00_6[43] + C00_7[43];
//        Row_54 <= C00[44] + C00_1[44] + C00_2[44] + C00_3[44] + C00_4[44] + C00_5[44] + C00_6[44] + C00_7[44];
//        Row_55 <= C00[45] + C00_1[45] + C00_2[45] + C00_3[45] + C00_4[45] + C00_5[45] + C00_6[45] + C00_7[45];
//        Row_56 <= C00[46] + C00_1[46] + C00_2[46] + C00_3[46] + C00_4[46] + C00_5[46] + C00_6[46] + C00_7[46];         
//        Row_57 <= C00[47] + C00_1[47] + C00_2[47] + C00_3[47] + C00_4[47] + C00_5[47] + C00_6[47] + C00_7[47];
//        Row_60 <= C00[48] + C00_1[48] + C00_2[48] + C00_3[48] + C00_4[48] + C00_5[48] + C00_6[48] + C00_7[48];
//        Row_61 <= C00[49] + C00_1[49] + C00_2[49] + C00_3[49] + C00_4[49] + C00_5[49] + C00_6[49] + C00_7[49];
//        Row_62 <= C00[50] + C00_1[50] + C00_2[50] + C00_3[50] + C00_4[50] + C00_5[50] + C00_6[50] + C00_7[50];
//        Row_63 <= C00[51] + C00_1[51] + C00_2[51] + C00_3[51] + C00_4[51] + C00_5[51] + C00_6[51] + C00_7[51];
//        Row_64 <= C00[52] + C00_1[52] + C00_2[52] + C00_3[52] + C00_4[52] + C00_5[52] + C00_6[52] + C00_7[52];
//        Row_65 <= C00[53] + C00_1[53] + C00_2[53] + C00_3[53] + C00_4[53] + C00_5[53] + C00_6[53] + C00_7[53];
//        Row_66 <= C00[54] + C00_1[54] + C00_2[54] + C00_3[54] + C00_4[54] + C00_5[54] + C00_6[54] + C00_7[54];
//        Row_67 <= C00[55] + C00_1[55] + C00_2[55] + C00_3[55] + C00_4[55] + C00_5[55] + C00_6[55] + C00_7[55];
//        Row_70 <= C00[56] + C00_1[56] + C00_2[56] + C00_3[56] + C00_4[56] + C00_5[56] + C00_6[56] + C00_7[56];
//        Row_71 <= C00[57] + C00_1[57] + C00_2[57] + C00_3[57] + C00_4[57] + C00_5[57] + C00_6[57] + C00_7[57];
//        Row_72 <= C00[58] + C00_1[58] + C00_2[58] + C00_3[58] + C00_4[58] + C00_5[58] + C00_6[58] + C00_7[58];
//        Row_73 <= C00[59] + C00_1[59] + C00_2[59] + C00_3[59] + C00_4[59] + C00_5[59] + C00_6[59] + C00_7[59];
//        Row_74 <= C00[60] + C00_1[60] + C00_2[60] + C00_3[60] + C00_4[60] + C00_5[60] + C00_6[60] + C00_7[60];
//        Row_75 <= C00[61] + C00_1[61] + C00_2[61] + C00_3[61] + C00_4[61] + C00_5[61] + C00_6[61] + C00_7[61];
//        Row_76 <= C00[62] + C00_1[62] + C00_2[62] + C00_3[62] + C00_4[62] + C00_5[62] + C00_6[62] + C00_7[62];
//        Row_77 <= C00[63] + C00_1[63] + C00_2[63] + C00_3[63] + C00_4[63] + C00_5[63] + C00_6[63] + C00_7[63];
//    end
////end






























  
