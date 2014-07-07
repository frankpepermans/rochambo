package com.igindo.roshambo.actors {
	
	import com.igindo.roshambo.domain.RulesetAsset;
	
	import flash.events.IEventDispatcher;
	
	[Event(name="gameActorChoice", type="com.igindo.roshambo.events.GameEvent")]
	
	[Bindable]
	public interface IActor extends IEventDispatcher {
		
		function get rulesetAssets():Vector.<RulesetAsset>;
		function set rulesetAssets(value:Vector.<RulesetAsset>):void;
		
		function get selectedAsset():RulesetAsset;
		function set selectedAsset(value:RulesetAsset):void;
		
		function get score():int;
		function set score(value:int):void;
		
		function beginPlay():void;
		function endPlay():void;
	}
}