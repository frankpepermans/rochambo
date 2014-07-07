package com.igindo.roshambo.views {
	
	import com.igindo.roshambo.actors.CPUActor;
	import com.igindo.roshambo.actors.IActor;
	import com.igindo.roshambo.actors.PlayerActor;
	import com.igindo.roshambo.domain.GameType;
	import com.igindo.roshambo.domain.MatchUpResult;
	import com.igindo.roshambo.domain.Ruleset;
	import com.igindo.roshambo.domain.RulesetAsset;
	import com.igindo.roshambo.events.GameEvent;
	
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	import mx.collections.ArrayCollection;
	import mx.controls.ProgressBar;
	import mx.core.FlexGlobals;
	import mx.states.State;
	
	import spark.components.Label;
	import spark.components.List;
	import spark.components.supportClasses.SkinnableComponent;
	import spark.events.IndexChangeEvent;
	
	[SkinState("countdown")]
	[SkinState("timer")]
	[SkinState("result")]
	
	public class GameScreen extends SkinnableComponent {
		
		[SkinPart(required="true")]
		public var leftRulesetAssets:List;
		
		[SkinPart(required="true")]
		public var rightRulesetAssets:List;
		
		[SkinPart(required="true")]
		public var timerBar:ProgressBar;
		
		[SkinPart(required="true")]
		public var countdown:Label;
		
		[Bindable] public var result:MatchUpResult;
		
		[Bindable] public var leftActor:IActor;
		[Bindable] public var rightActor:IActor;
		
		private var _gameType:GameType;
		
		public function get gameType():GameType { return _gameType; }
		public function set gameType(value:GameType):void {
			if (value != _gameType) {
				_gameType = value;
				
				initActors();
			}
		}
		
		private var _ruleset:Ruleset;
		[Bindable] public var selectableRulesetAssets:ArrayCollection; 
		
		[Bindable]
		public function get ruleset():Ruleset { return _ruleset; }
		public function set ruleset(value:Ruleset):void {
			if (value != _ruleset) {
				_ruleset = value;
				
				selectableRulesetAssets = new ArrayCollection();
				
				value.assets.forEach(
					function(A:RulesetAsset, I:int, V:Vector.<RulesetAsset>):void {
						selectableRulesetAssets.addItem(A);
					}
				);
			}
		}
		
		public function GameScreen():void {
			states = [
				new State({name:'countdown'}),
				new State({name:'timer'}),
				new State({name:'result'})
			];
		}
		
		public function getActorIconSource(actor:IActor):String {
			if (actor == leftActor) {
				if (actor is PlayerActor) return 'assets/player_type_01_left.png';
				if (actor is CPUActor) return 'assets/player_type_02_left.png';
			} else if (actor == rightActor) {
				if (actor is PlayerActor) return 'assets/player_type_01_right.png';
				if (actor is CPUActor) return 'assets/player_type_02_right.png';
			}
			
			return null;
		}
		
		public function reset():void {
			leftActor.rulesetAssets = rightActor.rulesetAssets = ruleset.assets;
			leftActor.score = rightActor.score = 0;
			
			leftRulesetAssets.mouseChildren = leftActor is PlayerActor;
			rightRulesetAssets.mouseChildren = false;
			
			leftActor.addEventListener(
				GameEvent.GAME_ACTOR_CHOICE,
				function(event:GameEvent):void {
					leftRulesetAssets.selectedItem = event.rulesetAsset;
				}
			);
			
			rightActor.addEventListener(
				GameEvent.GAME_ACTOR_CHOICE,
				function(event:GameEvent):void {
					rightRulesetAssets.selectedItem = event.rulesetAsset;
				}
			);
			
			beginCountdown();
		}
		
		public function beginCountdown():void {
			leftActor.selectedAsset = rightActor.selectedAsset = null;
			leftRulesetAssets.enabled = rightRulesetAssets.enabled = false;
			
			currentState = 'countdown';
			
			invalidateSkinState();
			
			if (countdown != null) countdown.text = "3";
			
			var progressTimer:Timer = new Timer(1000, 3);
			var countdownValue:int = 3;
			
			progressTimer.addEventListener(
				TimerEvent.TIMER,
				function(event:TimerEvent):void {
					countdown.text = (--countdownValue).toString();
				}
			);
			
			progressTimer.start();
			
			setTimeout(beginTimer, 3000);
		}
		
		public function beginTimer():void {
			leftRulesetAssets.enabled = rightRulesetAssets.enabled = true;
			
			currentState = 'timer';
			
			invalidateSkinState();
			
			leftActor.beginPlay();
			rightActor.beginPlay();
			
			var progressTimer:Timer = new Timer(30, 100);
			
			progressTimer.addEventListener(
				TimerEvent.TIMER,
				function(event:TimerEvent):void {
					timerBar.setProgress(100 - progressTimer.currentCount, 100);
				}
			);
			
			progressTimer.start();
			
			if (rightActor is PlayerActor) {
				addEventListener(
					KeyboardEvent.KEY_UP,
					rightActor_keyboardHandler
				);
			}
			
			setTimeout(endRound, 3000);
		}
		
		public function endRound():void {
			leftRulesetAssets.enabled = rightRulesetAssets.enabled = false;
			
			currentState = 'result';
			
			invalidateSkinState();
			
			result = _ruleset.matchUp(leftActor.selectedAsset, rightActor.selectedAsset);
			
			leftActor.endPlay();
			rightActor.endPlay();
			
			if (rightActor is PlayerActor) {
				removeEventListener(
					KeyboardEvent.KEY_UP,
					rightActor_keyboardHandler
				);
			}
			
			if (result.result == 1) leftActor.score++;
			if (result.result == -1) rightActor.score++;
			
			setTimeout(beginCountdown, 3000);
		}
		
		protected function rightActor_keyboardHandler(event:KeyboardEvent):void {
			var index:int = event.keyCode - 97;
			
			if (index >= 0 && index < selectableRulesetAssets.length) rightActor.selectedAsset = selectableRulesetAssets.getItemAt(index) as RulesetAsset;
		}
		
		override protected function getCurrentSkinState():String {
			return currentState;
		}
		
		override protected function partAdded(partName:String, instance:Object):void {
			super.partAdded(partName, instance);
			
			if (instance == leftRulesetAssets) {
				leftRulesetAssets.addEventListener(
					IndexChangeEvent.CHANGE,
					function(event:IndexChangeEvent):void {
						leftActor.selectedAsset = selectableRulesetAssets.getItemAt(event.newIndex) as RulesetAsset;
					}
				);
			}
		}
		
		private function initActors():void {
			switch (_gameType) {
				case GameType.PVC:
					leftActor = new PlayerActor();
					rightActor = new CPUActor();
					
					break;
				
				case GameType.PVP:
					leftActor = new PlayerActor();
					rightActor = new PlayerActor();
					
					break;
				
				case GameType.CVC:
					leftActor = new CPUActor();
					rightActor = new CPUActor();
					
					break;
			}
		}
	}
}

