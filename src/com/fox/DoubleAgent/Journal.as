import com.Components.WinComp;
import com.Components.WindowComponentContent;
import com.GameInterface.DistributedValue;
import com.GameInterface.Game.Character;
import com.GameInterface.Quest;
import com.GameInterface.QuestsBase;
import com.GameInterface.UtilsBase;
import com.Utils.Archive;
import com.Utils.Colors;
import com.Utils.LDBFormat;
import mx.utils.Delegate;

class com.fox.DoubleAgent.Journal {
	private var m_JournalClip:MovieClip;
	private var TaskID:Number;
	private var m_FactionArchieve:DistributedValue;
	private var m_SharedArchieve:DistributedValue;

	public function Journal(JournalClip:MovieClip) {
		m_FactionArchieve = DistributedValue.Create("DoubleAgent_Faction");
		m_SharedArchieve = DistributedValue.Create("DoubleAgent_Shared");
		m_JournalClip = JournalClip;
		var m_Window:MovieClip = m_JournalClip.m_Window;
		var m_Title:TextField = m_Window.m_Title;
		m_Title.autoSize = true;
		var m_DoubleAgentClip:MovieClip = m_Window.m_Content.createEmptyMovieClip("DoubleAgent", m_Window.getNextHighestDepth());
		m_DoubleAgentClip._y = -31;
		m_DoubleAgentClip._x = m_Title._x + m_Title._width;

		//building honeycomb icon from shapes found in the original swf
		var DoubleAgent0 = m_DoubleAgentClip.attachMovie("dot", "ShowReport1", m_DoubleAgentClip.getNextHighestDepth(), {_width:16, _height:16});
		DoubleAgent0._alpha = 10;
		var DoubleAgent1 = m_DoubleAgentClip.attachMovie("ItemStroke_Chakra7", "ShowReport1", m_DoubleAgentClip.getNextHighestDepth(), { _width:16, _height:16});
		Colors.ApplyColor(DoubleAgent1, 0xE9B007);
		DoubleAgent1._alpha = 35;
		var DoubleAgent2 = m_DoubleAgentClip.attachMovie("ItemPattern_hexa", "ShowReport2", m_DoubleAgentClip.getNextHighestDepth(), { _width:16, _height:16});
		Colors.ApplyColor(DoubleAgent2, 0xE9B007);

		var m_textField:MovieClip = m_DoubleAgentClip.createEmptyMovieClip("Txt", m_DoubleAgentClip.getNextHighestDepth());
		var m_text:TextField = m_textField.createTextField("Txt", m_textField.getNextHighestDepth(), 20, -1,20,20);
		m_text.autoSize = 'left';
		var format:TextFormat = m_Window.m_Content.m_HeaderNameFormat;
		format.size = 12;
		m_text.setNewTextFormat(format);
		m_text.text  = "View Report";
		m_DoubleAgentClip.onPress = Delegate.create(this, ShowReport);
	}

	//  Returns true if the TaskID belongs to the quest
	private function ValidateTaskID(QuestID,TaskID) {
		return QuestsBase.GetMainQuestIDByQuestID(TaskID) == QuestID ? true:false;
	}

	private function ShowReport() {
		_root.missionrewardcontroller.SlotMissionWindowClosed(TaskID);
		TaskID = undefined;
		var QuestID = m_JournalClip.m_Window.m_Content.m_ExpandedMissionID;
		FindTaskID(QuestID);
		var rewardObject = ConstructRewardObject(QuestID);
		CreateReportWindow(rewardObject);
	}

	private function FindTaskID(QuestID:Number) {
		var factionData:Archive = m_FactionArchieve.GetValue();
		var sharedData:Archive = m_SharedArchieve.GetValue();
		var task_ID = factionData.FindEntry(string(QuestID));
		if (!task_ID || !ValidateTaskID(QuestID, task_ID)) {
			task_ID = Number(sharedData.FindEntry(string(QuestID)));
		}
		if (task_ID && ValidateTaskID(QuestID, task_ID)) {
			TaskID = Number(task_ID);
		}
	}

	// Usually this data is from Quests.GetAllRewards();
	// Im manually constructing the RewardsObject from quest data
	private function ConstructRewardObject(QuestID) {
		var rewardObject = new Object();
		rewardObject.m_QuestTaskID = TaskID;
		rewardObject.m_OptionalRewards = new Array();
		rewardObject.m_Rewards = new Array();
		rewardObject.paused = m_JournalClip.m_Window.m_Content.m_Menu.m_MissionDropdown._selectedIndex == 2?true:false;

		var quest:Quest = QuestsBase.GetQuest(QuestID, false, true);
		if (!quest) quest = QuestsBase.GetQuest(QuestID, false, false);

		rewardObject.m_Xp = quest.m_Xp;
		rewardObject.m_Cash = quest.m_Cash;

		var temp1 = quest.m_Rewards;
		for (var i in temp1) {
			var reward = temp1[i]
			for (var y in reward) {
				rewardObject.m_Rewards.push(reward[y]);
			}
		}
		// This doesn't appear to work. Maybe becasue i have already completed the quests so i can't get optional rewards anymore?
		var temp2 = quest.m_OptionalRewards;
		for (var i in temp2) {
			var reward = temp2[i]
			for (var y in reward) {
				rewardObject.m_OptionalRewards.push(reward[y]);
			}
		}
		return rewardObject
	}

	// For some reason missionreward window fails to fetch questSolved text for paused missions
	// This function manually updates the missionrewardwindow content
	private function UpdatePaused(TierID) {
		for (var i:Number = 0 ; i <_root.missionrewardcontroller.m_RewardWindows.length; i++) {
			if (_root.missionrewardcontroller.m_RewardWindows[i].GetContent().GetID() == TierID || TierID == -1) {
				var m_Character = Character.GetClientCharacter();
				var m_Faction = m_Character.GetStat( _global.Enums.Stat.e_PlayerFaction );
				var text
				var oldSize = _root.missionrewardcontroller.m_RewardWindows[i].m_Content.m_MissionDescription._height;
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
				if (!text) text = LDBFormat.LDBGetText("QuestTaskSolved", Number(TierID));
				_root.missionrewardcontroller.m_RewardWindows[i].m_Content.m_MissionDescription.text = text;
				var qID = QuestsBase.GetMainQuestIDByQuestID(TaskID);
				var name =  QuestsBase.GetQuest(qID, false, true).m_MissionName;
				if (!name) name =  QuestsBase.GetQuest(qID, false, false).m_MissionName;
				_root.missionrewardcontroller.m_RewardWindows[i].m_Content.m_SubjectText.text = name;
				_root.missionrewardcontroller.m_RewardWindows[i].SetSize( 610, 250 );
			}
		}
	}

	private function CreateReportWindow(data) {
		if (data.m_QuestTaskID) {
			var missionReward:WinComp = _root.missionrewardcontroller.attachMovie( "MissionRewardWindowComponent", "m_RewardWindow_DoubleAgent", _root.missionrewardcontroller.getNextHighestDepth());
			missionReward.SetContent( "MissionRewardWindow" );
			missionReward.SignalClose.Connect(_root.missionrewardcontroller.SlotMissionWindowClosed, this );
			missionReward.SignalSelected.Connect( _root.missionrewardcontroller.BringToFront, this );
			missionReward.ShowResizeButton( true );
			missionReward.ShowStroke( false );
			missionReward.SetMinWidth( 400 );
			missionReward.SetSize( 610, 250 );
			var visibleRect:Object = Stage["visibleRect"];
			var centerStageX:Number = (visibleRect.width / 2);
			var centerStageY:Number = (visibleRect.height / 2);
			missionReward._x = centerStageX - (missionReward._width / 2);
			missionReward._y = centerStageY - (missionReward._height / 2);
			var content:WindowComponentContent = missionReward.GetContent();
			content.SetData(data);
			content["SignalClose"].Connect( _root.missionrewardcontroller.SlotMissionWindowClosed, this);
			_root.missionrewardcontroller.m_RewardWindows.push(missionReward);
			_root.missionrewardcontroller.m_RewardWindows[_root.missionrewardcontroller.m_RewardWindows.length - 1].ShowStroke( true )
			var character:Character = Character.GetClientCharacter();
			if (character != undefined) { character.AddEffectPackage( "sound_fxpackage_GUI_send_report.xml" ); }
			if (data.paused) UpdatePaused(data.m_QuestTaskID);
		} else {
			var name = QuestsBase.GetQuest(m_JournalClip.m_Window.m_Content.m_ExpandedMissionID, false, true).m_MissionName;
			if (!name) name = QuestsBase.GetQuest(m_JournalClip.m_Window.m_Content.m_ExpandedMissionID, false, false).m_MissionName;
			if (name) UtilsBase.PrintChatText("Unable to find mission report for " +name);
		}
	}
}