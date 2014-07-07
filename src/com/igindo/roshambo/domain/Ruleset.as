package com.igindo.roshambo.domain {
	
	public class Ruleset {
		
		[Bindable] public var theme:String;
		public var name:String;
		public var assets:Vector.<RulesetAsset>;
		public var matrix:Vector.<Vector.<int>>;
		public var relations:Vector.<Vector.<String>>;
		
		public function Ruleset(raw:Object):void {
			theme = raw.theme;
			name = raw.name;
			assets = raw.assets;
			matrix = raw.matrix;
			relations = raw.relations;
		}
		
		public function matchUp(left:RulesetAsset, right:RulesetAsset):MatchUpResult {
			if (left == right) return MatchUpResult.TIE;
			
			const li:int = assets.indexOf(left);
			const ri:int = assets.indexOf(right);
			
			if (li == -1 && ri >= 0) return new MatchUpResult(right, left, -1, 'left side failed to choose in time!');
			if (ri == -1 && li >= 0) return new MatchUpResult(left, right, 1, 'right side failed to choose in time!');
			
			const res:int = matrix[li][ri];
			
			if (res == 0) return MatchUpResult.TIE;
			else if (res == 1) return new MatchUpResult(left, right, res, relations[li][ri]);
			else if (res == -1) return new MatchUpResult(right, left, res, relations[ri][li]);
			
			return null;
		}
		
		public function validate():void {
			var assetLen:int = assets.length;
			var matchUps:Vector.<int>;
			var relation:Vector.<String>;
			
			if (assetLen != matrix.length) throw new Error('number of assets is not equal to the length of the matrix');
			if (assetLen != relations.length) throw new Error('number of assets is not equal to the number of relations');
			
			for (var i:int=0; i<assetLen; i++) {
				matchUps = matrix[i];
				relation = relations[i];
				
				if (assetLen != matchUps.length || assetLen != relation.length) throw new Error('insufficient matrix or relations sub length');
				
				var ties:int = 0;
				var wins:int = 0;
				var losses:int = 0;
				
				matchUps.forEach(
					function(value:int, index:int, src:Vector.<int>):void {
						if (value < -1 || value > 1) 	throw new Error(value.toString() + ' is not a valid relationship value, must be 1, 0 or -1'); 
						if (i == index && value != 0) 	throw new Error('symbol must tie itself'); 
						if (i != index && value == 0) 	throw new Error('symbol cannot tie a different symbol');
						
						switch (value) {
							case  0: ties++;
								if ((relation[index] != null)) throw new Error('tie relation must be null'); 
								
								break;
							case  1: wins++; 	
								if (!(relation[index] is String)) throw new Error('missing win message between ' + assets[i] + ' and ' + assets[index]); 
								
								break;
							case -1: losses++; 
								if ((relation[index] != null)) throw new Error('lose relation must be null'); 
								
								break;
						}
					}
				);
				
				if (wins != (assetLen - 1) / 2) 				throw new Error('incorrect win relations');
				if (losses != (assetLen - 1) / 2) 				throw new Error('incorrect lose relations');
				if (ties != (assetLen - wins - losses)) 		throw new Error('incorrect tie relations');
			}
		}
		
		public function toString():String {
			return name;
		}
	}
}