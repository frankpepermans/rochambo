package com.igindo.roshambo.actors {
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class CPUActor extends Actor implements IActor {
		
		/**
		 *  @private
		 */
		private var _timer:Timer;
		
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
		public function CPUActor():void {
		}
		
		//--------------------------------------------------------------------------
		//
		//  Overridden methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @copy com.igindo.roshambo.actors.IActor#beginPlay()
		 */
		override public function beginPlay():void {
			_timer = new Timer(Math.random() * 950 + 50);
			
			_timer.addEventListener(
				TimerEvent.TIMER,
				timer_handler
			);
			
			_timer.start();
		}
		
		/**
		 *  @copy com.igindo.roshambo.actors.IActor#endPlay()
		 */
		override public function endPlay():void {
			_timer.stop();
			
			_timer.removeEventListener(
				TimerEvent.TIMER,
				timer_handler
			);
			
			_timer = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		private function timer_handler(event:TimerEvent):void {
			selectedAsset = rulesetAssets[int(Math.random() * rulesetAssets.length)];
		}
	}
}