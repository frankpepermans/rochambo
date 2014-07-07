package com.igindo.roshambo.actors {
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class CPUActor extends Actor implements IActor {
		
		private var _timer:Timer;
		
		public function CPUActor():void {
		}
		
		override public function beginPlay():void {
			_timer = new Timer(Math.random() * 950 + 50);
			
			_timer.addEventListener(
				TimerEvent.TIMER,
				timer_handler
			);
			
			_timer.start();
		}
		
		override public function endPlay():void {
			_timer.stop();
			
			_timer.removeEventListener(
				TimerEvent.TIMER,
				timer_handler
			);
			
			_timer = null;
		}
		
		private function timer_handler(event:TimerEvent):void {
			selectedAsset = rulesetAssets[int(Math.random() * rulesetAssets.length)];
		}
	}
}