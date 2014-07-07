package com.igindo.roshambo.async {
	
	import flash.events.ErrorEvent;
	
	import mx.core.mx_internal;
	
	use namespace mx_internal;
	
	public class Completer {
		
		private var internalFuture:Future;
		
		public function get future():Future {
			return internalFuture;
		}
		
		public function Completer():void {
			internalFuture = new Future();
		}
		
		public function complete(result:*):void {
			internalFuture.complete(result);
		}
		
		public function error(event:ErrorEvent):void {
			internalFuture.error(event);
		}
	}
}