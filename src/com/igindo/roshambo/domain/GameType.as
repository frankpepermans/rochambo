package com.igindo.roshambo.domain {
	
	public class GameType {
		
		public static const PVC:GameType = new GameType(0, 'assets/player_vs_cpu.png');
		public static const PVP:GameType = new GameType(1, 'assets/player_vs_player.png');
		public static const CVC:GameType = new GameType(2, 'assets/cpu_vs_cpu.png');
		
		[Bindable]
		public var type:int;
		
		[Bindable]
		public var assetSource:String;
		
		public function GameType(type:int, assetSource:String):void {
			this.type = type;
			this.assetSource = assetSource;
		}
	}
}