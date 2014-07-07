package com.igindo.roshambo.events {
	
	import com.igindo.roshambo.domain.GameType;
	import com.igindo.roshambo.domain.Ruleset;
	import com.igindo.roshambo.domain.RulesetAsset;
	
	import flash.events.Event;
	
	public class GameEvent extends Event {
		
		public static const GAME_STARTING:String = 'gameStarting';
		public static const GAME_ACTOR_CHOICE:String = 'gameActorChoice';
		
		public var gameType:GameType;
		public var ruleset:Ruleset;
		public var rulesetAsset:RulesetAsset;
		
		public function GameEvent(type:String, gameType:GameType, ruleset:Ruleset, rulesetAsset:RulesetAsset):void {
			this.gameType = gameType;
			this.ruleset = ruleset;
			this.rulesetAsset = rulesetAsset;
			
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event {
			return new GameEvent(type, gameType, ruleset, rulesetAsset);
		}
	}
}