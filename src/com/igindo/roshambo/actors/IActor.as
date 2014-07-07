package com.igindo.roshambo.actors {
	
	import com.igindo.roshambo.domain.RulesetAsset;
	
	import flash.events.IEventDispatcher;
	
	[Event(name="gameActorChoice", type="com.igindo.roshambo.events.GameEvent")]
	
	[Bindable]
	public interface IActor extends IEventDispatcher {
		
		/**
		 * Represents the available <code>RulesetAsset</code>s as the choices that the <code>Actor</code> can
		 * make while playing a round.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4
		 */
		function get rulesetAssets():Vector.<RulesetAsset>;
		/**
		 *  @private
		 */
		function set rulesetAssets(value:Vector.<RulesetAsset>):void;
		
		/**
		 * Holds the current <code>Actor</code>'s choice while playing a round.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4
		 */
		function get selectedAsset():RulesetAsset;
		/**
		 *  @private
		 */
		function set selectedAsset(value:RulesetAsset):void;
		
		/**
		 * Holds the current <code>Actor</code>'s score.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4
		 */
		function get score():int;
		/**
		 *  @private
		 */
		function set score(value:int):void;
		
		/**
		 *  This method is triggered automatically by the <code>GameScreen</code> when the round starts.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4
		 */
		function beginPlay():void;
		
		/**
		 *  This method is triggered automatically by the <code>GameScreen</code> when the round ends.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4
		 */
		function endPlay():void;
	}
}