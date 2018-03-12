import com.GameInterface.DistributedValue;
import com.GameInterface.DistributedValueBase;
import com.Utils.Archive;
import com.Utils.LDBFormat;
import com.fox.DoubleAgent.Journal;
import mx.utils.Delegate;

class com.fox.DoubleAgent.Agent {

	private var JournalDVal:DistributedValue;
	private var m_FactionArchieve:DistributedValue;
	private var m_SharedArchieve:DistributedValue;
	private var m_Journal:Journal;

	public static function main(swfRoot:MovieClip):Void {
		var m_Agent:Agent = new Agent(swfRoot);
		swfRoot.onLoad = function() { m_Agent.onLoad(); };
		swfRoot.onUnload = function() { m_Agent.onUnload(); };
		swfRoot.OnModuleActivated = function() { m_Agent.Activated(); };
	}

	public function Agent() { }

	public function onLoad() {
		m_FactionArchieve = DistributedValue.Create("DoubleAgent_Faction");
		m_SharedArchieve = DistributedValue.Create("DoubleAgent_Shared");

		JournalDVal = DistributedValue.Create("mission_journal_window");
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
	}
	public function Activated() {
		var RewardWindow:Function = _global.GUI.Mission.MissionRewardWindow;
		if (RewardWindow) {
			// Adds the faction icons to the SetData function
			if (RewardWindow.prototype._SetData == undefined) {
				RewardWindow.prototype._SetData = RewardWindow.prototype["SetData"];
				RewardWindow.prototype.SetData = function (rewardObject:Object) {

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
					this._SetData(rewardObject);
				}
			}
			// Repositioning of the faction icons
			if (RewardWindow.prototype._Layout == undefined) {
				RewardWindow.prototype._Layout = RewardWindow.prototype["Layout"];
				RewardWindow.prototype.Layout = function () {
					this._Layout();
					this.m_LogoIlluminati._x = this.m_BonusCashReward._x;
					this.m_LogoTemplar._x = this.m_BonusCashReward._x+25;
					this.m_LogoDragon._x = this.m_BonusCashReward._x+50;
					this.m_LogoIlluminati._y = this.m_BonusCashReward._y + 24;
					this.m_LogoTemplar._y = this.m_BonusCashReward._y + 24;
					this.m_LogoDragon._y	= this.m_BonusCashReward._y + 24;
				}
			}
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
				var text = LDBFormat.LDBGetText(LDBString, Number(this.m_QuestID));
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
				if (factionLogo && sender) {
					var m_FactionLogo = this.attachMovie( factionLogo, "m_FactionLogo", this.m_FactionLogo.getDepth(), { _xscale:42, _yscale:42,_x:10,_y:10});
					this.m_FromText.text = sender;
				}
			}
			//fixed patron purchase page, original function still tries to open the web based one
			RewardWindow.prototype.ShopButtonReleaseHandler = function () {
				DistributedValue.SetDValue("membershipPurchase_window", true);
			}
		} else {
			setTimeout(Delegate.create(this, Activated), 50);
		}
	}

	public function onUnload() {
		JournalDVal.SignalChanged.Disconnect(SlotJournalOpened, this);
	}

	private function LoadData(filename:String) {
		var XMLFile:XML = new XML();
		XMLFile.ignoreWhite = true;
		XMLFile.onLoad = Delegate.create(this,function(success) {
			if (success) {
				var root:XMLNode = XMLFile.childNodes[0];
				var data:Archive = new Archive();
				for (var i:Number = 0; i < root.childNodes.length; i++ ) {
					data.AddEntry(root.childNodes[i].attributes.qID, root.childNodes[i].attributes.tID);
				}
				DistributedValueBase.SetDValue("DoubleAgent_" + filename, data);
			}
		});
		XMLFile.load("DoubleAgent/"+filename+".xml");
	}

	private function SlotJournalOpened() {
		if (JournalDVal.GetValue()) {
			if (!_root.missionjournalwindow.m_Window.m_Content) setTimeout(Delegate.create(this, SlotJournalOpened), 100);
			else m_Journal = new Journal(_root.missionjournalwindow);
		} else 	m_Journal = undefined;

	}
}