`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////
//// Company: 
//// Engineer: 
//// 
//// Create Date: 23.09.2024 10:39:00
//// Design Name: 
//// Module Name: tuGEMM
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





//module tuGEMM(
//input clk,
//input rst,
//input [31:0] vector_a,
//input [31:0] vector_b,
//output wire signed [16:0] Row_00,
//output wire signed [16:0] Row_01,
//output wire signed [16:0] Row_10,
//output wire signed [16:0] Row_11
//    );
//integer i,j,t;


   
//   reg signed unary_col ;
//   reg signed unary_row ;
//   reg signed neg_row;
//   reg signed neg_col ;
//   wire signed xor_out ;
//   wire signed and_out ;
//    //wire signed complement ;
//    reg signed [7:0] counta;
//    reg signed [7:0] countb;   // 8-bit counters
//    reg [4:0] index_a;            // Index for vector selection
//    reg [4:0] index_b;
//    reg [1:0] done_A;
//    reg [1:0] done_B;
//    reg [2:0] state;            // State variable
//     reg done;
//     reg signed [16:0] C00 [0:3];
//     reg signed[16:0] counter;
//    localparam IDLE     = 3'b00,  // IDLE state
//               LOAD     = 3'b01,  // Load state for vector values
//               COUNT_A  = 3'b10,  // Decrement/Increment counta state
//               COUNT_B  = 3'b11,  // Decrement/Increment countb state
//               CHANGE   = 3'b100;

//    // State machine
//    always @(posedge clk) begin
//        if (rst) begin
//        for (t = 0; t < 4; t = t + 1) begin
//                C00[t] <= 'd0;
//            end
        
//            counta <= 8'd0;
//            countb <= 8'd0;
//            index_a <= 5'd0;
//            index_b <= 5'd0;
//            done_A <= 0;
//            done_B <= 0;
//            state <= IDLE;
//            done <= 1'b0;
//            counter <= 0;
//            unary_col <= 0;
//            unary_row <= 0;
//            neg_row <= 0;
//            neg_col <= 0;
////            C00[0] <= 0;
////            C00[1] <= 0;
////            C00[2] <= 0;
////            C00[3] <= 0;
//            j <= 0;
//        end else begin
//            case (state)
//                IDLE: begin
//                    // Wait in idle, start processing when index is within bounds
//                    if (index_a < 5'd3) begin
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
                
//                    if (counta == 0) begin
//                        done_A <= done_A + 1;
//                        C00[j] <=  C00[j] + counter;
                        
//                        done_B <= done_B + 1;
//                        state <= CHANGE;
//                    end
//                    // First, decrement or increment counta
//                    else if (counta[7] == 0) begin
//                        counta <= counta - 1;
//                        state <= COUNT_B;
//                    end else if (counta[7] != 0) begin
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
//                if (countb > 0 ) begin
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
//                        C00[j] <= C00[j] + counter;
                        
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
//                    0: index_a <= 4'd0;
//                    1: index_a <= 4'd0;
//                    2: index_a <= 4'd2;
//                    3: index_a <= 4'd2;
//                endcase

//                case (done_B)
//                    0: index_b <= 4'd0;
//                    1: index_b <= 4'd1;
//                    2: index_b <= 4'd0;
//                    3: index_b <= 4'd1;
//                endcase

//                state <= LOAD;  // Load next vector values
//            end

//        endcase
//    end
//end

//            assign xor_out = neg_col ^ neg_row;
//            assign and_out = unary_col && unary_row;            

///// second state machine


// reg signed unary_col_1 ;
// reg signed unary_row_1 ;
// reg signed neg_row_1;
// reg signed neg_col_1 ;
// wire signed xor_out_1 ;
// wire signed and_out_1 ;
// reg signed [7:0] counta_1;
// reg signed [7:0] countb_1;   // 8-bit counters
//    reg [4:0] index_a_1;            // Index for vector selection
//    reg [4:0] index_b_1;
//    reg [1:0] done_A_1;
//    reg [1:0] done_B_1;
//    reg [2:0] state_1;            // State variable
//     reg done_1 = 1;
//     //reg signed [16:0] C00_1 [0:3];
//     reg signed [16:0] counter_1;
//    localparam IDLE_1     = 3'b000,  // IDLE state
//               LOAD_1     = 3'b001,  // Load state for vector values
//               COUNT_A_1  = 3'b010,  // Decrement/Increment counta state
//               COUNT_B_1  = 3'b011,  // Decrement/Increment countb state
//               CHANGE_1   = 3'b100;
               


//always @(posedge clk) begin
//        if (rst) begin
//            counta_1 <= 8'd0;
//            countb_1 <= 8'd0;
//            index_a_1 <= 5'd1;
//            index_b_1 <= 5'd2;
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
//                    if (index_a_1 < 5'd3) begin
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
//                        C00[i] <= C00[i] + counter_1;
//                        done_B_1 <= done_B_1 + 1;
//                        state_1 <= CHANGE_1;
//                    end
//                    // First, decrement or increment counta
//                   else if (counta_1[7] == 0) begin
//                        counta_1 <= counta_1 - 1;
//                        state_1 <= COUNT_B_1;
//                    end else if (counta_1[7] != 0) begin
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
////                
                 

//             if (xor_out_1 == 0) begin
             
//                counter_1 <= counter_1 + 1; end 
             
//             else if (xor_out_1 == 1) begin
             
//                counter_1 <= counter_1 - 1; end
                         
                    
//             end  
//             else if (countb_1 < 0) begin
//                    countb_1 <= countb_1 + 1;

             
//             if (xor_out_1 == 0) begin
             
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
//                        C00[i] <= C00[i] + counter_1;
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
//                    0: index_a_1 <= 4'd0;
//                    1: index_a_1 <= 4'd1;
//                    2: index_a_1 <= 4'd3;
//                    3: index_a_1 <= 4'd3;
//                endcase

//                case (done_B_1)
//                    0: index_b_1 <= 4'd0;
//                    1: index_b_1 <= 4'd3;
//                    2: index_b_1 <= 4'd2;
//                    3: index_b_1 <= 4'd3;
//                endcase

//                state_1 <= LOAD_1;  // Load next vector values
//            end

//        endcase
//    end
//end


//            assign xor_out_1 = neg_col_1 ^ neg_row_1;
//            assign and_out_1 = unary_col_1 && unary_row_1;
          


//reg done_1_reg;
//always@(posedge clk)
//begin
//if(rst)
//done_1_reg <= 0; else
//    if(done_A_1 == 2'd3 && counta_1 )
//    done_1_reg = 1;
//end

//assign Row_00 = C00[0];
//assign Row_01 = C00[1];
//assign Row_10 = C00[2];
//assign Row_11 = C00[3];

//endmodule




module tuGEMM(
input clk,
input rst,
input [31:0] vector_a,
input [31:0] vector_b,
output reg signed [16:0] Row_00,
output reg signed [16:0] Row_01,
output reg signed [16:0] Row_10,
output reg signed [16:0] Row_11
    );
integer i,j;


   
   reg signed unary_col ;
   reg signed unary_row ;
   reg signed neg_row;
   reg signed neg_col ;
   wire signed xor_out ;
   wire signed and_out ;
    //wire signed complement ;
    reg signed [7:0] counta;
    reg signed [7:0] countb;   // 8-bit counters
    reg [4:0] index_a;            // Index for vector selection
    reg [4:0] index_b;
    reg [1:0] done_A;
    reg [1:0] done_B;
    reg [2:0] state;            // State variable
     reg done;
     reg signed [16:0] C00 [0:3];
     reg signed[16:0] counter;
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
            index_a <= 5'd0;
            index_b <= 5'd0;
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
                    if (index_a < 5'd3) begin
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
                   else if (counta[7] == 0) begin
                        counta <= counta - 1;
                          state <= COUNT_B;
                    end else if (counta[7] != 0) begin
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
                if (countb > 0 ) begin
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
                    0: index_a <= 4'd0;
                    1: index_a <= 4'd0;
                    2: index_a <= 4'd2;
                    3: index_a <= 4'd2;
                endcase

                case (done_B)
                    0: index_b <= 4'd0;
                    1: index_b <= 4'd1;
                    2: index_b <= 4'd0;
                    3: index_b <= 4'd1;
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
 reg signed [7:0] counta_1;
 reg signed [7:0] countb_1;   // 8-bit counters
    reg [4:0] index_a_1;            // Index for vector selection
    reg [4:0] index_b_1;
    reg [1:0] done_A_1;
    reg [1:0] done_B_1;
    reg [2:0] state_1;            // State variable
     reg done_1 = 1;
     reg signed [16:0] C00_1 [0:3];
     reg signed [16:0] counter_1;
    localparam IDLE_1     = 3'b000,  // IDLE state
               LOAD_1     = 3'b001,  // Load state for vector values
               COUNT_A_1  = 3'b010,  // Decrement/Increment counta state
               COUNT_B_1  = 3'b011,  // Decrement/Increment countb state
               CHANGE_1   = 3'b100;
               


always @(posedge clk) begin
        if (rst) begin
            counta_1 <= 8'd0;
            countb_1 <= 8'd0;
            index_a_1 <= 5'd1;
            index_b_1 <= 5'd2;
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
                    if (index_a_1 < 5'd3) begin
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
                    else if (counta_1[7] == 0) begin
                        counta_1 <= counta_1 - 1;
                        state_1 <= COUNT_B_1;
                    end else if (counta_1[7] != 0) begin
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
//                
                 

             if (xor_out_1 == 0) begin
             
                counter_1 <= counter_1 + 1; end 
             
             else if (xor_out_1 == 1) begin
             
                counter_1 <= counter_1 - 1; end
                         
                    
             end  
             else if (countb_1 < 0) begin
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
                    0: index_a_1 <= 4'd0;
                    1: index_a_1 <= 4'd1;
                    2: index_a_1 <= 4'd3;
                    3: index_a_1 <= 4'd3;
                endcase

                case (done_B_1)
                    0: index_b_1 <= 4'd0;
                    1: index_b_1 <= 4'd3;
                    2: index_b_1 <= 4'd2;
                    3: index_b_1 <= 4'd3;
                endcase

                state_1 <= LOAD_1;  // Load next vector values
            end

        endcase
    end
end


            assign xor_out_1 = neg_col_1 ^ neg_row_1;
            assign and_out_1 = unary_col_1 && unary_row_1;
          


reg done_1_reg;
always@(posedge clk)
begin
if(rst)
done_1_reg <= 0; else
    if(done_A_1 == 2'd3 && counta_1 )
    done_1_reg = 1;
end


always@(posedge clk)
begin
    if(done_1)
    begin
        Row_00 <= C00[0] + C00_1[0];
        Row_01 <= C00[1] + C00_1[1];
        Row_10 <= C00[2] + C00_1[2];
        Row_11 <= C00[3] + C00_1[3];
    end
end

endmodule


