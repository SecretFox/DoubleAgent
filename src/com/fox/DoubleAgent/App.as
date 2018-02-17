import com.GameInterface.DistributedValue;
import com.GameInterface.DistributedValueBase;
import com.GameInterface.UtilsBase;
import com.Utils.Archive;
import com.fox.DoubleAgent.Infiltrate;
import com.fox.DoubleAgent.Journal;
import mx.utils.Delegate;
/**
 * ...
 * @author fox
 */
class com.fox.DoubleAgent.App{
	
	private var m_SwfRoot:MovieClip;
	private var m_Journal:DistributedValue;
	private var m_FactionArchieve:DistributedValue;
	private var m_SharedArchieve:DistributedValue;
	
	public function App(root) {
		m_SwfRoot = root;
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
			} else {
				UtilsBase.PrintChatText("failed to load DoubleAgent/"+filename+".xml file");
			}
		});
		XMLFile.load("DoubleAgent/"+filename+".xml");
	}
	
	public function onLoad(){
		m_FactionArchieve = DistributedValue.Create("DoubleAgent_Faction");
		m_SharedArchieve = DistributedValue.Create("DoubleAgent_Shared");
		
		GUI.Mission.MissionSignals.SignalMissionReportSent.Connect( SlotMissionReportSent, this );
		m_Journal = DistributedValue.Create("mission_journal_window");
		m_Journal.SignalChanged.Connect(SlotJournalOpened, this);
		SlotJournalOpened();
		//saving the values to DV so that they don't get unloaded on reloadui/character change
		//mod is set to Preload so that the initial loading will happen on character selection
		if (!m_FactionArchieve.GetValue()){
			LoadData("Faction");
		}
		if (!m_SharedArchieve.GetValue()){
			LoadData("Shared");
		}
	}
	
	private function SlotJournalOpened(){
		if (m_Journal.GetValue() && _root.missionjournalwindow.m_Window.m_Content){
			setTimeout(Delegate.create(this, InfiltrateJournal), 50);
		}
		else if (m_Journal.GetValue()){
			setTimeout(Delegate.create(this, SlotJournalOpened), 100);
		}
	}
	
	private function InfiltrateJournal(){
		var Journal = new Journal(_root.missionjournalwindow);
	}
	
	public function onUnload(){
		GUI.Mission.MissionSignals.SignalMissionReportSent.Disconnect( SlotMissionReportSent, this );
		m_Journal.SignalChanged.Disconnect(SlotJournalOpened, this);
	}
	
	private function SlotMissionReportSent(){
		setTimeout(Delegate.create(this, InfiltrateReports), 100);
	}
	
	private function InfiltrateReports(){
		var windows = _root.missionrewardcontroller.m_RewardWindows;
		for (var i in windows){
			var Injected = new Infiltrate(windows[i]);
		}
	}
}