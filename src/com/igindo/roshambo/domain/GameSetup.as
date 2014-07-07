package com.igindo.roshambo.domain {
	
	import mx.collections.ArrayCollection;
	import mx.core.mx_internal;
	
	public class GameSetup {
		
		use namespace mx_internal;
		
		static mx_internal var _instance:GameSetup;
		
		public static function get instance():GameSetup {
			if (_instance == null) _instance = new GameSetup();
			
			return _instance;
		}
		
		[Bindable]
		public var rulesets:ArrayCollection = new ArrayCollection();
		
		[Bindable]
		public var gameTypes:ArrayCollection = new ArrayCollection(
			[GameType.PVC, GameType.PVP, GameType.CVC]
		);
	}
}

internal class SingletonEnforcer {}