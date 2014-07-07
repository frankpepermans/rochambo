package com.igindo.roshambo.actors {
	
	import com.igindo.roshambo.domain.RulesetAsset;
	import com.igindo.roshambo.events.GameEvent;
	
	import flash.events.EventDispatcher;
	
	/**
	 *  The Actor represents a player, typically CPU or human.
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 10
	 *  @playerversion AIR 1.5
	 *  @productversion Flex 4
	 */
	public class Actor extends EventDispatcher implements IActor {
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  rulesetAssets
		//----------------------------------
		
		/**
		 *  @private
		 *  Storage for the rulesetAssets property.
		 */
		private var _rulesetAssets:Vector.<RulesetAsset>;
		
		/**
		 *  @copy com.igindo.roshambo.actors.IActor#rulesetAssets
		 */
		public function get rulesetAssets():Vector.<RulesetAsset> { return _rulesetAssets; }
		
		/**
		 *  @private
		 */
		public function set rulesetAssets(value:Vector.<RulesetAsset>):void {
			_rulesetAssets = value;
		}
		
		//----------------------------------
		//  selectedAsset
		//----------------------------------
		
		/**
		 *  @private
		 *  Storage for the selectedAsset property.
		 */
		private var _selectedAsset:RulesetAsset;
		
		[Bindable]
		/**
		 *  @copy com.igindo.roshambo.actors.IActor#selectedAsset
		 */
		public function get selectedAsset():RulesetAsset { return _selectedAsset; }
		
		/**
		 *  @private
		 */
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
		
		//----------------------------------
		//  score
		//----------------------------------
		
		/**
		 *  @private
		 *  Storage for the score property.
		 */
		private var _score:int = 0;
		
		[Bindable]
		/**
		 *  @copy com.igindo.roshambo.actors.IActor#score
		 */
		public function get score():int { return _score; }
		
		/**
		 *  @private
		 */
		public function set score(value:int):void {
			_score = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor. 
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4
		 */    
		public function Actor():void {
		}
		
		/**
		 *  @copy com.igindo.roshambo.actors.IActor#beginPlay()
		 */
		public function beginPlay():void {}
		
		/**
		 *  @copy com.igindo.roshambo.actors.IActor#endPlay()
		 */
		public function endPlay():void {}
	}
}