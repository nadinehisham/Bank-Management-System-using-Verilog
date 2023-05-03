module TB();

 

    // Inputs
    reg ic;
    reg cv;
    reg cl;
    reg ep;
    reg [1:0] co;
    reg mc;
    reg mi;
    reg CNL;
    reg ai;
    reg vb;
    
    reg clk;
    reg Mm;
    reg [3:0] InPass;

 

    // Outputs
    wire [4:0] action;

 


    // Instantiate the Unit Under Test (UUT)
    Design DUT (
        .ic(ic), 
        .cv(cv), 
        .cl(cl), 
        .ep(ep), 
        .co(co), 
        .mc(mc), 
        .mi(mi), 
        .CNL(CNL), 
        .ai(ai), 
        .vb(vb), 
        
        .clk(clk), 
        .Mm(Mm), 
        .InPass(InPass), 
        .action(action)

 

    );
    integer I;
    
integer seed = 8;
integer seed1 = 14;
integer seed2 = 7;
integer seed3 = 10;


always @(posedge clk)
    begin
    for (I=0; I<1000000; I=I+1)
    begin
#100;
        co=$random(seed);
        ic=$random(seed);
        cv=$random(seed);
        InPass=4'b1111;
        
        ai=$random(seed);
        vb=$random(seed);
        
        Mm= 1;
        mc=$random(seed);
        CNL=0;
        #100;
        cl=$random(seed);
        ep=$random(seed);
        mi=$random(seed);

 
#100;
        co=$random(seed1);
        ic=$random(seed1);
        cv=$random(seed1);
        InPass=4'b1111;
        
        ai=$random(seed1);
        vb=$random(seed1);
        
        Mm=1;
        mc=$random(seed1);
        CNL= 0;
        
        cl=$random(seed1);
        ep=$random(seed1);
        mi=$random(seed1);
        
#100;
        co=$random(seed2);
        ic=$random(seed2);
        cv=$random(seed2);
        InPass=4'b1111;
        
        ai=$random(seed2);
        vb=$random(seed2);
        
        Mm= $random(seed2);
        mc=$random(seed2);
        CNL=1;
        
        cl=$random(seed2);
        ep=$random(seed2);
        mi=$random(seed2);
#50;
        co=$random(seed3);
        ic=$random(seed3);
        cv=$random(seed3);
        InPass=4'b1111;
        
        ai=$random(seed3);
        vb=$random(seed3);
        
        Mm= $random(seed3);
        mc=$random(seed3);
        CNL=1;
        
        cl=$random(seed3);
        ep=$random(seed3);
        mi=$random(seed3);
    end
end        

 

initial 
            begin 
                clk = 0;
        forever begin
            #5; 
            clk = ~clk;
    
    end
    end    

 

    

 


    initial begin
        // Initialize Inputs
        //Money Deposit (S10)
        ic = 1;
        CNL = 0;
        cv = 1;
        cl = 1;
        InPass= 4'b1111;
        ep = 1;
        co = 00;
        mi = 1;
        mc = 1;
		  Mm = 1;
        #100
        //Money Withdraw (S13)
        ic = 1;
        cv = 1;
        cl = 1;
		  CNL = 0;
        InPass= 4'b1111;
        ep = 1;
        co = 01;
        ai = 1;
        vb = 1;
		  Mm = 1;
            #100
				
			
        //Balance Services(S8)
        ic = 1;
        cv = 1;
        cl = 1;
		  CNL = 0;
        InPass= 4'b1111;
        ep = 1;
        co = 10;
		  Mm = 1;
            #100
  
        
        //Other Services (S9)
        ic = 1;
        cv = 1;
        cl = 1;
		  CNL = 0;
        InPass= 4'b1111;
        ep = 1;
        co = 11;
		  Mm = 1;
        
            #100
				
				
        //Wrong password
        ic = 1;
        cv = 1;
        cl = 1;
		  CNL = 0;
        InPass= 4'b1100;
        ep = 1;
        #100
 
    

 $finish;

        // Wait 100 ns for global reset to finish
	#100;
        
        // Add stimulus here

 


    end

 

     
endmodule
