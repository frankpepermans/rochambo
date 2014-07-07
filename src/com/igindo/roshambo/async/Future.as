package com.igindo.roshambo.async {
	
	import flash.events.ErrorEvent;
	
	import mx.core.mx_internal;
	
	public class Future {
		
		private var handler:Function;
		private var errorHandler:Function;
		
		public function set then(value:Function):void {
			handler = value;
		}
		
		public function set onError(value:Function):void {
			errorHandler = value;
		}
		
		public function Future():void {
		}
		
		mx_internal function complete(result:*):void {
			handler(result);
		}
		
		mx_internal function error(event:ErrorEvent):void {
			errorHandler(event);
		}
	}
}