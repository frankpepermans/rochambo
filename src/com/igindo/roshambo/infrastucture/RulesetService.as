package com.igindo.roshambo.infrastucture {
	
	import com.igindo.roshambo.async.Completer;
	import com.igindo.roshambo.async.Future;
	import com.igindo.roshambo.domain.Ruleset;
	import com.igindo.roshambo.domain.RulesetAsset;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	public class RulesetService implements IRulesetService {
		
		public function RulesetService():void {
		}
		
		public function load(url:String):Future {
			var completer:Completer = new Completer();
			var request:URLRequest = new URLRequest(url);
			var loader:URLLoader = new URLLoader();
			
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			
			loader.addEventListener(
				IOErrorEvent.IO_ERROR,
				function(event:IOErrorEvent):void {
					completer.error(event);
				}
			);
			
			loader.addEventListener(
				SecurityErrorEvent.SECURITY_ERROR,
				function(event:SecurityErrorEvent):void {
					completer.error(event);
				}
			);
			
			loader.addEventListener(
				Event.COMPLETE, 
				function(event:Event):void {
					var rulesetMap:Array = JSON.parse(loader.data, reviver) as Array;
					var len:int = rulesetMap.length;
					var result:Vector.<Ruleset> = new Vector.<Ruleset>(len);
					
					for (var i:int=0; i<len; i++) result[i] = new Ruleset(rulesetMap[i]);
					
					completer.complete(result);
				}
			);
			
			loader.load(request);
			
			return completer.future;
		}
		
		private function reviver(k:String, v:*):* {
			var cast:Array;
			var len:int;
			var i:int;
			
			switch (k) {
				case 'assets': 
					cast = v as Array;
					len = cast.length;
					
					var assets:Vector.<RulesetAsset> = new Vector.<RulesetAsset>(len);
					
					for (i=0; i<len; i++) assets[i] = new RulesetAsset(v[i]);
					
					return assets;
					
				case 'matrix':
					cast = v as Array;
					len = cast.length;
					
					var m:Vector.<Vector.<int>> = new Vector.<Vector.<int>>(len);
					
					for (i=0; i<len; i++) m[i] = Vector.<int>(v[i]);
					
					return m;
					
				case 'relations':
					cast = v as Array;
					len = cast.length;
					
					var r:Vector.<Vector.<String>> = new Vector.<Vector.<String>>(len);
					
					for (i=0; i<len; i++) r[i] = Vector.<String>(v[i]);
					
					return r;
					
				default: return v;
			}
			
			return null;
		}
	}
}