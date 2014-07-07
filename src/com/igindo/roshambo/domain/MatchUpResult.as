package com.igindo.roshambo.domain {
	
	public class MatchUpResult {
		
		public static const TIE:MatchUpResult = new MatchUpResult(null, null, 0, 'tie');
		
		public var winner:RulesetAsset;
		public var loser:RulesetAsset;
		[Bindable] public var result:int;
		public var relation:String;
		
		public function MatchUpResult(winner:RulesetAsset, loser:RulesetAsset, result:int, relation:String):void {
			this.winner = winner;
			this.loser = loser;
			this.result = result;
			this.relation = relation;
		}
		
		public function toString():String {
			if (winner != null && loser != null) return winner + ' ' + relation + ' ' + loser + '!';
			
			return relation;
		}
	}
}