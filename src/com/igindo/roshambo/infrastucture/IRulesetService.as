package com.igindo.roshambo.infrastucture {
	
	import com.igindo.roshambo.async.Future;
	
	public interface IRulesetService {
		
		function load(url:String):Future;
		
	}
}