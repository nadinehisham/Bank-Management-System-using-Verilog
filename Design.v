module Design (
input ic ,
input cv,
input cl,
input ep,
input [1:0] co,
input mc,
input mi,
input CNL,
input ai,
input vb,

input clk,
input Mm,
input[3:0] InPass,
output reg [4:0] action


);

 

reg vp;
reg [4:0] CurrentState; 
reg [4:0] nextState ;
reg [3:0] Password= 4'b1111;

 
parameter IDLE= 5'b00000;

 

always @(posedge clk or posedge CNL) 
begin
    if(CNL)
    begin
        CurrentState<=IDLE;
    end
    else
    begin
        CurrentState<=nextState;
    end
end

 


parameter S1  = 5'b00001;
parameter S2  = 5'b00010;
parameter S3  = 5'b00011;
parameter S4  = 5'b00100;
parameter S5  = 5'b00101;
parameter S6  = 5'b00110;
parameter S7  = 5'b00111;
parameter S8  = 5'b01000;
parameter S9  = 5'b01001;
parameter S10 = 5'b01010;

parameter S12 = 5'b01100;
parameter S13 = 5'b01101;


 

 

always @ (*)
begin
    case (CurrentState)
    IDLE : begin 
          if(ic==0) begin
          nextState=IDLE;
	
			 action = 5'b00000;
			 end
          else 
			 begin
          nextState=S1;

			 action = 5'b00001;
			 end
          
          end

 

    S1  : begin
         if(cv==0)
			begin
         nextState=IDLE;

			action = 5'b00000;
			end
         else 
			begin
         nextState=S2;
			action = 5'b00010;
			end
       
         end

 

    S2  : begin
         if(cl==0)
			begin
         nextState=S2;

			action = 5'b00010;
			end
         else 
			begin
         nextState=S3;

			action = 5'b00011;
			end
         
         end 
  
    S3  : begin
         if(ep==0)
			begin
         nextState=S3;

			action = 5'b00011;
			end
         else
			begin
         nextState=S4;

			action = 5'b00100;
			end
        
         end

 

    S4  : begin
         if(InPass==Password)
            vp = 1;
         else
            vp = 0;
         if(vp==0)
			begin
         nextState=S3;

			action = 5'b00011;
			end
         else 
			begin
         nextState=S5;

			action = 5'b00101;
			end
       
         end

 

    S5  : begin
         if(co==2'b00)
			begin
         nextState=S6;

			action = 5'b00110;
			end
         else if (co==2'b01)
			begin
         nextState=S7;

			action = 5'b00111;
			end
         else if(co==2'b10)
			begin
         nextState=S8;

			action = 5'b01000;
			end
         else if(co==2'b11)
			begin
         nextState=S9;

			action = 5'b01001;
			end
         else 
			begin
         nextState=IDLE;

			action = 5'b00000;
			end
         end 

 

    S6  : begin
         
         if(mi==1 && mc==1)
			begin
         nextState=S10;

			action = 5'b01010;
			end
			else if(Mm)
			begin
         nextState=S5;

			action = 5'b00101;
			end
         else if (mi==0 || mc==0)
			begin
         nextState=S6;

			action = 5'b00110;
			end
         else 
			begin
         nextState=S6;

			action = 5'b00110;
			end
         
         end 

 

    S7 : begin
         if(ai==0)
			begin
         nextState=S7;

			action = 5'b00111;
			end
         else 
			begin
         nextState=S12;

			action = 5'b01100;
			end
     
end
 

    S8 : begin
         if(Mm==0)
			begin
         nextState=S8;

			action = 5'b01000;
			end
         else 
			begin
         nextState=S5;

			action = 5'b00101;
			end
       
         end

 

    S9 : begin
        if(Mm==1)
		  begin
         nextState=S5;

			action = 5'b00101;
			end

         else
		begin
         nextState=S9;

			action = 5'b01001;
			end
       
         end

 

    S10 : begin
         if(Mm==1)
			begin
         nextState=S5;

			action = 5'b00101;
			end
         else 
			begin
         nextState=S10;

			action = 5'b01010;
			end
        
         end

 
 

    S12 : begin
         if(vb==1)
			begin
         nextState=S13;
			action = 5'b01101;
			end
         else 
			begin
         nextState=S5;

			action = 5'b00101;
			end
       
         end

 

    S13 : begin
	 if(Mm==1)
			begin
         nextState=S5;

			action = 5'b00101;
	end
	else
		begin
         nextState=S13;

		action = 5'b01101;
			end
	end

 

    
        default: 
         begin
         nextState=IDLE;

			action = 5'b00000;
         end
    endcase
end
// psl assert always( (ic == 0 && CurrentState== IDLE)   -> next (action==5'b00000) ) @(posedge clk);
// psl assert always( (S3&&ep&&!CNL)    -> next (action==5'b00100) ) @(posedge clk);


endmodule