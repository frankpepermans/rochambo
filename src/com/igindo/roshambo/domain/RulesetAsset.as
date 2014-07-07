package com.igindo.roshambo.domain {
	
	public class RulesetAsset {
		
		[Bindable] public var name:String;
		[Bindable] public var asset:String;
		
		public function RulesetAsset(raw:Object):void {
			name = raw.name;
			asset = raw.asset;
		}
		
		public function toString():String {
			return name;
		}
	}
}