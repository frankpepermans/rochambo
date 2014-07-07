package test {
	
	import com.igindo.roshambo.domain.Ruleset;
	import com.igindo.roshambo.domain.RulesetAsset;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.flexunit.async.Async;
	
	public class RochamboTest {
		
		public static var app:Rochambo;
		
		public function RochamboTest() {
		}
		
		[BeforeClass]
		public static function construct():void {
			app = new Rochambo();
		}
		
		[AfterClass]
		public static function destroy():void {
			app = null;
		}
		
		[Before]
		public function setUp():void {
			
		}
		
		[After]
		public function tearDown():void {
			
		}
		
		[Test(async)]
		public function appCreated():void {
			var dispatcher:EventDispatcher = new EventDispatcher();
			
			Async.failOnEvent(this, dispatcher, 'fail');
			
			app.init().then = function(result:Vector.<Ruleset>):void {
				result.forEach(
					function(ruleset:Ruleset, index:int, src:Vector.<Ruleset>):void {
						try {
							ruleset.validate();
						} catch (error:Error) {
							dispatcher.dispatchEvent(new Event('fail'));
						}
					}
				);
				
				// testing one match up, paper beats rock
				var defaultRuleset:Ruleset = result[0];
				
				var rockAsset:RulesetAsset = result[0].assets[0];
				var paperAsset:RulesetAsset = result[0].assets[1];
				var scissorsAsset:RulesetAsset = result[0].assets[2];
				
				// paper beats rock...
				if (defaultRuleset.matchUp(paperAsset, rockAsset).result != 1) dispatcher.dispatchEvent(new Event('fail'));
				// scissors beats paper...
				if (defaultRuleset.matchUp(scissorsAsset, paperAsset).result != 1) dispatcher.dispatchEvent(new Event('fail'));
				// rock beats scissors...
				if (defaultRuleset.matchUp(rockAsset, scissorsAsset).result != 1) dispatcher.dispatchEvent(new Event('fail'));
			};
		}
	}
}