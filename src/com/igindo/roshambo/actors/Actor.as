package com.igindo.roshambo.actors {
	
	import com.igindo.roshambo.domain.RulesetAsset;
	import com.igindo.roshambo.events.GameEvent;
	
	import flash.events.EventDispatcher;
	
	public class Actor extends EventDispatcher implements IActor {
		
		private var _rulesetAssets:Vector.<RulesetAsset>;
		
		public function get rulesetAssets():Vector.<RulesetAsset> { return _rulesetAssets; }
		public function set rulesetAssets(value:Vector.<RulesetAsset>):void {
			_rulesetAssets = value;
		}
		
		private var _selectedAsset:RulesetAsset;
		
		[Bindable]
		public function get selectedAsset():RulesetAsset { return _selectedAsset; }
		public function set selectedAsset(value:RulesetAsset):void {
			if (value != _selectedAsset) {
				_selectedAsset = value;
				
				dispatchEvent(
					new GameEvent(
						GameEvent.GAME_ACTOR_CHOICE, null, null, value
					)
				);
			}
		}
		
		private var _score:int = 0;
		
		[Bindable]
		public function get score():int { return _score; }
		public function set score(value:int):void {
			_score = value;
		}
		
		public function Actor():void {
		}
		
		public function beginPlay():void {}
		
		public function endPlay():void {}
	}
}