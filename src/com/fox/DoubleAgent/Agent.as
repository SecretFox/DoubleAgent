import com.GameInterface.DistributedValue;
import com.GameInterface.DistributedValueBase;
import com.GameInterface.QuestsBase;
import com.Utils.Archive;
import com.Utils.LDBFormat;
import com.fox.DoubleAgent.Journal;
import mx.utils.Delegate;

class com.fox.DoubleAgent.Agent {

	private var JournalDVal:DistributedValue;
	private var m_FactionArchieve:DistributedValue;
	private var m_SharedArchieve:DistributedValue;
	private var m_Journal:Journal;
	static var NoNetworkText:String;

	public static function main(swfRoot:MovieClip):Void {
		var m_Agent:Agent = new Agent(swfRoot);
		swfRoot.onLoad = function() { m_Agent.onLoad(); };
		swfRoot.onUnload = function() { m_Agent.onUnload(); };
	}

	public function Agent() {
		NoNetworkText = LDBFormat.LDBGetText("QuestTaskSolvedIlluminati", 21469);
		m_FactionArchieve = DistributedValue.Create("DoubleAgent_Faction");
		m_SharedArchieve = DistributedValue.Create("DoubleAgent_Shared");
		JournalDVal = DistributedValue.Create("mission_journal_window");
	}

	public function onLoad() {
		JournalDVal.SignalChanged.Connect(SlotJournalOpened, this);
		SlotJournalOpened();
		//  Saving the values to DV so that they don't get unloaded on reloadui/character change
		//  mod is set to Preload so that the initial loading will happen on character selection
		if (!m_FactionArchieve.GetValue()) {
			LoadData("Faction");
		}
		if (!m_SharedArchieve.GetValue()) {
			LoadData("Shared");
		}
		Hook();
	}
	
	public function onUnload() {
		JournalDVal.SignalChanged.Disconnect(SlotJournalOpened, this);
	}
	
	// Loads the .xml files.
	// Data gets stored in distributed value so that it persists through Reloadui
	// Initial loading will happen in the main menu screen, since it is quite slow
	private function LoadData(filename:String) {
		var XMLFile:XML = new XML();
		XMLFile.ignoreWhite = true;
		XMLFile.onLoad = Delegate.create(this,function(success) {
			if (success) {
				var root:XMLNode = XMLFile.childNodes[0];
				var data:Archive = new Archive();
				for (var i:Number = 0; i < root.childNodes.length; i++ ) {
					data.AddEntry(root.childNodes[i].attributes.q, root.childNodes[i].attributes.t);
				}
				DistributedValueBase.SetDValue("DoubleAgent_" + filename, data);
			}
		});
		XMLFile.load("DoubleAgent/"+filename+".xml");
	}
	
	public function Hook() {
		if (_global.com.fox.DoubleAgent.Hooked) return
		var RewardWindow:Function = _global.GUI.Mission.MissionRewardWindow;
		if (!RewardWindow){
			setTimeout(Delegate.create(this, Hook), 1000);
			return
		}
		_global.com.fox.DoubleAgent.Hooked = true;
		
		// Fixes patron purchase page, original function still tries to open the web based one
		var f:Function = function () {
			DistributedValue.SetDValue("membershipPurchase_window", true);
			// arguments.callee.base.apply(this, arguments);
		}
		f.base = RewardWindow.prototype.ShopButtonReleaseHandler;
		RewardWindow.prototype.ShopButtonReleaseHandler = f;
		
		// Create Faction Buttons for turn-in window, from assets found in the clip
		// Adds the faction icons to the SetData function
		f = function(rewardObject:Object) {
			this.m_LogoIlluminati = this.createEmptyMovieClip("m_LogoIlluminati", this.getNextHighestDepth());
			//hitbox, due to transparent pixels
			this.m_LogoIlluminati.beginFill(0xFFFFFF, 0);
			this.m_LogoIlluminati.moveTo(0, 0);
			this.m_LogoIlluminati.lineTo(20, 0);
			this.m_LogoIlluminati.lineTo(20, 20);
			this.m_LogoIlluminati.lineTo(0, 20);
			this.m_LogoIlluminati.lineTo(0, 0);
			this.m_LogoIlluminati.endFill();
			this.m_LogoIlluminati.attachMovie("LogoIlluminati", "m_LogoIlluminati", this.m_LogoIlluminati.getNextHighestDepth(), {_width:20, _height:20});

			//these two look awful when downscaled so much, changing alpha of the border shape helps a lot
			this.m_LogoTemplar = this.attachMovie("LogoTemplar", "m_LogoTemplar", this.getNextHighestDepth(), { _width:23, _height:23});
			this.prettify(this.m_LogoTemplar,0);
			this.m_LogoDragon = this.attachMovie("LogoDragon", "m_LogoDragon", this.getNextHighestDepth(), { _width:23, _height:23});
			this.prettify(this.m_LogoDragon,50);

			this.m_LogoIlluminati.onPress = Delegate.create(this, function() {
				this.ChangeFaction("QuestTaskSolvedIlluminati");
			});
			this.m_LogoTemplar.onPress = Delegate.create(this, function() {
				this.ChangeFaction("QuestTaskSolvedTemplar");
			});
			this.m_LogoDragon.onPress = Delegate.create(this, function() {
				this.ChangeFaction("QuestTaskSolvedDragon");
			});
			//SetData calls for Layout after it is done
			arguments.callee.base.apply(this, arguments);
		}
		f.base = RewardWindow.prototype.SetData;
		RewardWindow.prototype.SetData = f;
		
		// Repositioning the faction icons
		f = function() {
			arguments.callee.base.apply(this, arguments);
			this.m_LogoIlluminati._x = this.m_CollectButton._x-80;
			this.m_LogoTemplar._x = this.m_CollectButton._x-55;
			this.m_LogoDragon._x = this.m_CollectButton._x-30;
			this.m_LogoIlluminati._y = this.m_CollectButton._y;
			this.m_LogoTemplar._y = this.m_CollectButton._y;
			this.m_LogoDragon._y = this.m_CollectButton._y;
		}
		f.base = RewardWindow.prototype.Layout;
		RewardWindow.prototype.Layout = f;
		
		// Finds the biggest shape in an object and adjusts its alpha
		RewardWindow.prototype.prettify = function(logo,alpha) {
			var highest:Number = 0;
			var clip:MovieClip;
			for (var part in logo) {
				if (logo[part]._width > highest) {
					clip = logo[part];
					highest = logo[part]._width;
				}
			}
			clip._alpha = alpha;
		}
		
		RewardWindow.prototype.ChangeFaction = function(LDBString:String) {
			// Faction mission + Dark Agartha handling
			var text = Agent.GetMissionRewardText(LDBString, this.m_MainQuestID, this.m_QuestID);
			if (text) {
				this.m_MissionDescription.text = text;
				this.Layout();
				this.SignalSizeChanged.Emit();
			}
			var factionLogo:String;
			var sender:String;
			switch (LDBString) {
				case "QuestTaskSolvedDragon":
					factionLogo = "LogoDragon";
					sender = LDBFormat.LDBGetText("FactionNames", 142501473);
					break;
				case "QuestTaskSolvedIlluminati":
					factionLogo = "LogoIlluminati";
					sender = LDBFormat.LDBGetText("FactionNames", 189501921);
					break;
				case "QuestTaskSolvedTemplar":
					factionLogo = "LogoTemplar";
					sender = LDBFormat.LDBGetText("FactionNames", 74636305);
			}
			var m_FactionLogo = this.attachMovie( factionLogo, "m_FactionLogo", this.m_FactionLogo.getDepth(), { _xscale:42, _yscale:42,_x:10,_y:10});
			this.m_FromText.text = sender;
		}
	}
	
	static function GetMissionRewardText(LDBString:String, m_MainQuestID:Number, m_QuestID:Number){
		var text;
		switch(m_MainQuestID){
			// Faction mission
			case 3095:
				switch(LDBString){
					case "QuestTaskSolvedTemplar":
						text = LDBFormat.LDBGetText(50303, 18405);
						break
					case "QuestTaskSolvedIlluminati":
						text = LDBFormat.LDBGetText(50303, 19007);
						break
					case "QuestTaskSolvedDragon":
						text = LDBFormat.LDBGetText(50303, 18452);
						break
				}
				break
			// Faction mission
			case 3274:
				switch(LDBString){
					case "QuestTaskSolvedTemplar":
						text = LDBFormat.LDBGetText(50303, 19005);
						break
					case "QuestTaskSolvedIlluminati":
						text = LDBFormat.LDBGetText(50303, 19007);
						break
					case "QuestTaskSolvedDragon":
						text = LDBFormat.LDBGetText(50303, 19006);
						break
				}
				break
			//Dark Agartha
			case 4128:
				if (QuestsBase.GetQuest(3703, false, false).m_HasCompleted){//Laying low in the limelight
					switch(LDBString){
						case "QuestTaskSolvedTemplar":
						case "QuestTaskSolvedIlluminati":
							text = LDBFormat.LDBGetText(LDBString, 21546);
							break
						case "QuestTaskSolvedDragon":
							text = LDBFormat.LDBGetText(50316, 21546);
							break
					}
					break
				}
				//if daimon is locked, then don't break and goto default
			default:
				text = LDBFormat.LDBGetText(LDBString, m_QuestID);
		}
		
		// SA Handling
		if (text == NoNetworkText){
			// checks if player has unlocked the mission reports yet
			var NetworkTest = QuestsBase.GetSolvedTextForQuest(QuestsBase.GetMainQuestIDByQuestID(21498), 21498);
			var unlocked:Boolean;
			if (NetworkTest != NoNetworkText && NetworkTest) {
				switch(LDBString) {
					case "QuestTaskSolvedTemplar":
						text = LDBFormat.LDBGetText(50314, m_QuestID);
						break
					case "QuestTaskSolvedIlluminati":
						text = LDBFormat.LDBGetText(50315, m_QuestID);
						break
					case "QuestTaskSolvedDragon":
						text = LDBFormat.LDBGetText(50316, m_QuestID);
						break
				}
			}
		}
		return text
	}
	


	private function SlotJournalOpened() {
		if (JournalDVal.GetValue()) {
			if (!_root.missionjournalwindow.m_Window.m_Content){
				setTimeout(Delegate.create(this, SlotJournalOpened), 100);
				return
			}
			m_Journal = new Journal(_root.missionjournalwindow);
		}
	}
}