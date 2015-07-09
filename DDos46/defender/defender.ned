package ddos46.defender;

simple Defender {
    
  		parameters:
			double learning_time @unit(s) = default(3s);
			double sample_time @unit(s) = default(0.05s);
			int susp_w_limit = default(10);
			bool defense_mode = default(true);
			
			@signal[inThroughputPerSample](type="double");
			@signal[outThroughputPerSample](type="double");
			@statistic[inThroughputPerSample](title="incoming throughput per sample"; source="inThroughputPerSample"; record=vector,stats; interpolationmode=none);
			@statistic[outThroughputPerSample](title="outcoming throughput per sample"; source="outThroughputPerSample"; record=vector,stats; interpolationmode=none);
			
		gates:
		    input in;
		    output out;
		    
		   
        
}

