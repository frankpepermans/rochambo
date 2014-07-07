package test {
	
	import com.igindo.roshambo.domain.Ruleset;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import flexunit.framework.Assert;
	import flexunit.framework.AssertionFailedError;
	
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
			};
		}
	}
}