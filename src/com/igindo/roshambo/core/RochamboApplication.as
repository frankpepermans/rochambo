package com.igindo.roshambo.core {
	
	import com.igindo.roshambo.async.Future;
	import com.igindo.roshambo.domain.GameSetup;
	import com.igindo.roshambo.domain.Ruleset;
	import com.igindo.roshambo.infrastucture.IRulesetService;
	
	import flash.events.ErrorEvent;
	import flash.utils.setTimeout;
	
	import mx.controls.Alert;
	
	import spark.components.Application;
	
	public class RochamboApplication extends Application {
		
		[Bindable]
		protected var errorMessage:String;
		
		public function RochamboApplication():void {
		}
		
		protected function setError(message:String):void {
			Alert.show(message, "An error has occurred...");
		}
		
		protected function loadRuleset(service:IRulesetService, uri:String):void {
			const rulesetFuture:Future = service.load(uri);
			
			rulesetFuture.onError = function(event:ErrorEvent):void {
				setError(event.text);
			}
			
			rulesetFuture.then = function(result:Vector.<Ruleset>):void {
				var hasError:Boolean = false;
				
				result.forEach(
					function(ruleset:Ruleset, index:int, src:Vector.<Ruleset>):void {
						try {
							ruleset.validate();
						} catch (error:Error) {
							hasError = true;
							
							setError('Please check the ruleset JSON file:\r\r' + error.message as String);
						}
						
						GameSetup.instance.rulesets.addItem(ruleset);
					}
				);
				
				if (!hasError) {
					setTimeout(
						function():void { currentState = "splash" }, 2000
					);
				}
			};
		}
	}
}