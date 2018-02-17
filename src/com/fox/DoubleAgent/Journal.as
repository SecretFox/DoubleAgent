import com.GameInterface.DistributedValue;
import com.GameInterface.Game.Character;
import com.GameInterface.Quest;
import com.GameInterface.QuestsBase;
import com.GameInterface.UtilsBase;
import com.Utils.Archive;
import com.Utils.Colors;
import com.Utils.LDBFormat;
import com.fox.DoubleAgent.Infiltrate;
import mx.utils.Delegate;
/**
 * ...
 * @author fox
 */
class com.fox.DoubleAgent.Journal {
	private var m_RewardW:MovieClip;
	private var m_Journal:MovieClip;
	private var TaskID:Number;
	private var m_FactionArchieve:DistributedValue;
	private var m_SharedArchieve:DistributedValue;

	public function Journal(JournalClip:MovieClip) {
		m_FactionArchieve = DistributedValue.Create("DoubleAgent_Faction");
		m_SharedArchieve = DistributedValue.Create("DoubleAgent_Shared");
		m_Journal = JournalClip;
		m_RewardW = _root.missionrewardcontroller.m_RewardWindows;
		var Window:MovieClip = m_Journal.m_Window;
		var title:TextField = Window.m_Title;
		title.autoSize = true;
		var DoubleAgentContainer:MovieClip = Window.m_Content.createEmptyMovieClip("DoubleAgent", Window.getNextHighestDepth());
		DoubleAgentContainer._y = -31;
		DoubleAgentContainer._x = title._x + title._width;

		var DoubleAgent0 = DoubleAgentContainer.attachMovie("dot", "ShowReport1", DoubleAgentContainer.getNextHighestDepth(), {_width:16, _height:16});
		DoubleAgent0._alpha = 10;
		var DoubleAgent1 = DoubleAgentContainer.attachMovie("ItemStroke_Chakra7", "ShowReport1", DoubleAgentContainer.getNextHighestDepth(), { _width:16, _height:16});
		Colors.ApplyColor(DoubleAgent1, 0xE9B007);
		DoubleAgent1._alpha = 35;
		var DoubleAgent2 = DoubleAgentContainer.attachMovie("ItemPattern_hexa", "ShowReport2", DoubleAgentContainer.getNextHighestDepth(), { _width:16, _height:16});
		Colors.ApplyColor(DoubleAgent2, 0xE9B007);

		var m_textField:MovieClip = DoubleAgentContainer.createEmptyMovieClip("Txt", DoubleAgentContainer.getNextHighestDepth());
		var m_text:TextField = m_textField.createTextField("Txt", m_textField.getNextHighestDepth(), 20, -1,20,20);
		m_text.autoSize = 'left';
		var format:TextFormat = Window.m_Content.m_HeaderNameFormat;
		format.size = 12;
		m_text.setNewTextFormat(format);
		m_text.text  = "View Report";

		DoubleAgentContainer.onPress = Delegate.create(this, GetData);
	}

	private function ValidateQuestTierPair(QuestID,TaskID) {
		return QuestsBase.GetMainQuestIDByQuestID(TaskID) == QuestID?true:false;
	}

	private function BringToFront(clip:MovieClip) {
		var clipDepth:Number = clip.getDepth();
		var highestDepth:Number = clipDepth;
		var frontClip:MovieClip

		for (var i:Number = 0; i <m_RewardW.length; i++ ) {
			if (m_RewardW[i].getDepth() > highestDepth) {
				frontClip =m_RewardW[i];
				highestDepth = frontClip.getDepth();
			}
		}

		if (highestDepth > clipDepth) {
			frontClip.ShowStroke( false );
			clip.ShowStroke( true );
			clip.swapDepths( frontClip );
		}
	}
	
	private function SlotMissionWindowClosed(rewardId:Number) {
		for (var i:Number = 0 ; i <m_RewardW.length; i++) {
			if (m_RewardW[i].GetContent().GetID() == rewardId || rewardId == -1) {
				m_RewardW[i].removeMovieClip();
				m_RewardW.splice(i, 1);
			}
			m_RewardW[i].ShowStroke( false );
		}

		if (m_RewardW.length == 0 && rewardId != -1) {
			GUI.Mission.MissionSignals.SignalMissionReportWindowClosed.Emit();
		}
	}

	private function GetData() {
		SlotMissionWindowClosed(TaskID)
		TaskID = undefined;
		var QuestID = m_Journal.m_Window.m_Content.m_ExpandedMissionID;
		FindTaskID(QuestID);
		var data = FindData(QuestID);
		CreateReportWindow(data);
	}

	private function FindTaskID(QuestID:Number) {
		var factionData:Archive = m_FactionArchieve.GetValue();
		var sharedData:Archive = m_SharedArchieve.GetValue();
		var task_ID = factionData.FindEntry(string(QuestID));
		if (!task_ID || !ValidateQuestTierPair(QuestID, task_ID)) {
			task_ID = sharedData.FindEntry(string(QuestID));
		}
		if (task_ID && ValidateQuestTierPair(QuestID, task_ID)) {
			TaskID = Number(task_ID);
		}
	}

	private function FindData(QuestID) {
		var data = new Object();
		data.m_QuestTaskID = TaskID;
		data.m_OptionalRewards = new Array();
		data.m_Rewards = new Array();
		data.paused = m_Journal.m_Window.m_Content.m_Menu.m_MissionDropdown._selectedIndex == 2?true:false;

		var quest:Quest = QuestsBase.GetQuest(QuestID, false, true);
		if (!Quest)quest = QuestsBase.GetQuest(QuestID, false, false);
		var temp1 = quest.m_Rewards;
		var temp2 = quest.m_OptionalRewards;

		data.m_Xp = quest.m_Xp;
		data.m_Cash = quest.m_Cash;
		for (var i in temp1) {
			var reward = temp1[i]
			for (var y in reward) {
				data.m_Rewards.push(reward[y]);
			}
		}
		for (var i in temp2) {
			var reward = temp2[i]
			for (var y in reward) {
				data.m_OptionalRewards.push(reward[y]);
			}
		}
		return data
	}

	private function InfiltrateReports() {
		for (var i in m_RewardW) {
			var Injected = new Infiltrate(m_RewardW[i]);
		}
	}

	private function UpdatePaused(TierID) {
		// for some reason missionreward window fails to fetch quest solved text for paused missions
		// strangely enough it works for completed and active ones just fine
		for (var i:Number = 0 ; i <m_RewardW.length; i++) {
			if (m_RewardW[i].GetContent().GetID() == TierID || TierID == -1) {
				var m_Character = Character.GetClientCharacter();
				var m_Faction  = m_Character.GetStat( _global.Enums.Stat.e_PlayerFaction );
				var text
				var oldSize = m_RewardW[i].m_Content.m_MissionDescription._height;
				switch (m_Faction) {
					case _global.Enums.Factions.e_FactionDragon:
						text = LDBFormat.LDBGetText("QuestTaskSolvedDragon", Number(TierID));
						break
					case _global.Enums.Factions.e_FactionIlluminati:
						text = LDBFormat.LDBGetText("QuestTaskSolvedIlluminati", Number(TierID));
						break
					case _global.Enums.Factions.e_FactionTemplar:
						text = LDBFormat.LDBGetText("QuestTaskSolvedTemplar", Number(TierID));
						break
				}
				m_RewardW[i].m_Content.m_MissionDescription.text = text;
				var qID = QuestsBase.GetMainQuestIDByQuestID(TaskID);
				var name =  QuestsBase.GetQuest(qID, false, true).m_MissionName;
				if (!name) name =  QuestsBase.GetQuest(qID, false, false).m_MissionName;
				m_RewardW[i].m_Content.m_SubjectText.text = name;
				m_RewardW[i].SetSize( 610, 250 );
			}
		}
	}

	private function CreateReportWindow(data) {
		if (data.m_QuestTaskID) {
			var missionReward:com.Components.WinComp = _root.missionrewardcontroller.attachMovie( "MissionRewardWindowComponent", "m_RewardWindow_DoubleAgent", _root.missionrewardcontroller.getNextHighestDepth());
			missionReward.SetContent( "MissionRewardWindow" );
			missionReward.SignalClose.Connect( SlotMissionWindowClosed, this );
			missionReward.SignalSelected.Connect( BringToFront, this );
			missionReward.ShowResizeButton( true );
			missionReward.ShowStroke( false );
			missionReward.SetMinWidth( 400 );
			missionReward.SetSize( 610, 250 );
			var visibleRect:Object = Stage["visibleRect"];
			var centerStageX:Number = (visibleRect.width / 2);
			var centerStageY:Number = (visibleRect.height / 2);
			missionReward._x = centerStageX - (missionReward._width / 2);
			missionReward._y = centerStageY - (missionReward._height / 2);
			var content:com.Components.WindowComponentContent = missionReward.GetContent();
			content.SetData(data);
			content["SignalClose"].Connect( SlotMissionWindowClosed, this);
			m_RewardW.push(missionReward);
			setTimeout(Delegate.create(this, InfiltrateReports), 100);
			m_RewardW[m_RewardW.length - 1].ShowStroke( true )
			var character:Character = Character.GetClientCharacter();
			if (character != undefined) { character.AddEffectPackage( "sound_fxpackage_GUI_send_report.xml" ); }
			if (data.paused) UpdatePaused(data.m_QuestTaskID);
		} else {
			var name = QuestsBase.GetQuest(m_Journal.m_Window.m_Content.m_ExpandedMissionID, false, true).m_MissionName;
			if (!name) name = QuestsBase.GetQuest(m_Journal.m_Window.m_Content.m_ExpandedMissionID, false, false).m_MissionName;
			if (name)UtilsBase.PrintChatText("Unable to find mission report for " +name);
		}
	}
}