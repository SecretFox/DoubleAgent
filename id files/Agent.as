/**
 * ...
 * @author fox
 */
import com.GameInterface.InventoryItem;
import com.GameInterface.LogBase;
import com.GameInterface.Quest;
import com.GameInterface.QuestsBase;
import com.GameInterface.UtilsBase;
import com.Utils.LDBFormat;
import com.fox.DoubleAgent.MissionIDs;
import mx.utils.Delegate;


// Replaces the Agent.as in project files, also requires MissionIDs.as to be imported
// for non english clients solvedText check in the Export function may need to be replaced
// "Done" will be printed out in the system channel once done
// Afterwards run ExtractFromClientlog.py and then jsonToXML.py
// json files are for processing the data and .xml files are needed by the mod
// if replacing the .xml files while in game it's necessary to run commands /option DoubleAgent_Faction false and /option DoubleAgent_Shared false to reload the changes
// this is because the .xml files are only loaded if  distributedvalue does not have valuet yet( to reduce loading times).

class com.fox.DoubleAgent.Agent {
	static var SharedID:Array;
	static var LumieID:Array;
	static var DragonID:Array;
	static var TemplarID:Array;
	static var appy:MissionIDs;

	public static function main(swfRoot:MovieClip):Void {
		swfRoot.onLoad = OnLoad;
		swfRoot.onUnload = OnUnload;
	}

	public function Agent() { }

	public static function OnLoad() {
		appy = new MissionIDs()
		//s_app.onLoad();
		
		//  Starts 30s after launching the game,you have to login before the timer expires or you crash
		//  Alternatively remove "GMF_PRELOAD" flag from modules.xml and remove the setTimeout part
		setTimeout(Delegate.create(Agent, Importer), 30000);
	}

	public static function OnUnload() {
	}
	
	public static function Importer() {
		
		//had to separate these into new class,as the exceeded 32KB limit
		LogBase.Warning("Agent", "Starting Export");
		ExportIDs();
	}
	
	public static function ExportIDs(){
		if(appy.SharedID.length>0) ExportShared();
		else if(appy.LumieID.length>0) ExportLumie();
		else if(appy.TemplarID.length>0) ExportTemplar();
		else if (appy.DragonID.length > 0) ExportDragon();
		
		else if(appy.LumieIDSpecial.length>0) ExportLumieSpecial();
		else if(appy.TemplarIDSpecial.length>0) ExportTemplarSpecial();
		else if(appy.DragonIDSpecial.length>0) ExportDragonSpecial();
		else{
			UtilsBase.PrintChatText("Done")
		}
	}
	
	static function Export(task,faction,special){
		var questID = QuestsBase.GetMainQuestIDByQuestID(task);
		var solvedText:String;
		if(!special){
			if (faction == "all") solvedText = Replace(LDBFormat.LDBGetText("QuestTaskSolved", task));
			else if (faction == "illuminati") solvedText = Replace(LDBFormat.LDBGetText("QuestTaskSolvedIlluminati", task));
			else if (faction == "dragon") solvedText = Replace(LDBFormat.LDBGetText("QuestTaskSolvedDragon", task));
			else if (faction == "templar") solvedText = Replace(LDBFormat.LDBGetText("QuestTaskSolvedTemplar", task));
		}else{
			if (faction == "illuminati") solvedText = Replace(LDBFormat.LDBGetText(50316, task));
			else if (faction == "dragon") solvedText = Replace(LDBFormat.LDBGetText(50315, task));
			else if (faction == "templar") solvedText = Replace(LDBFormat.LDBGetText(50314, task));
		}
		
		
		var QuestName = QuestsBase.GetQuest(questID, false, true).m_MissionName;
		var XP = QuestsBase.GetQuest(questID, false, false).m_Xp;
		var Cash = QuestsBase.GetQuest(questID, false, false).m_Cash;
		var rewards = GetRewards(questID);
		if (rewards.tsw) return;
		
		if(QuestName && solvedText && solvedText!="<write the task solved text here>"){
			var msg = "Faction="+faction + " QuestID=" + string(questID) + " rewards="+rewards.rewards+ " optional="+rewards.optional+ " Cash="+Cash+ " XP="+XP  +" QuestName="+QuestName +" TaskID=" + string(task) + " Report=" + solvedText+"||";
			LogBase.Warning("DoubleAgent", msg);
		}
	}
	
	// removing new lines simplifies reading the log, we will replace && with \n on python later.
	public static function Replace(Str:String){
		return Str.split("\n").join("&&");
	}
	
	private static function GetRewards(id){
		var m_Quest:Quest =  QuestsBase.GetQuest(id, false, false);
		var rew = m_Quest.m_Rewards;
		var orew = m_Quest.m_OptionalRewards;
		var rewStr = new Array();
		var orewStr = new Array();
		var tsw:Boolean = false;
		for ( var i in rew){
			var item:InventoryItem = rew[i]["m_InventoryItem"];
			rewStr.push(item.m_StackSize+"x" + item.m_Name)
			if ((item.m_Name.indexOf("Pax Romana") != -1 && item.m_Name) || (item.m_Name.indexOf("Unrefined Marks of the Pantheon") != -1 && item.m_Name)|| (item.m_Name.indexOf("White Marks of Venice") != -1 && item.m_Name)) tsw = true;
		}
		for ( var i in orew){
			var item:InventoryItem = rew[i]["m_InventoryItem"];
			orewStr.push(item.m_StackSize+"x"+item.m_Name)
		}
		return {rewards:rewStr.join(","),optional:orewStr.join(","), tsw:tsw}
	}
	
	public static function ExportShared() {
		if (appy.SharedID.length>0){
			var task = appy.SharedID.pop();
			Export(task, "all");
			setTimeout(Delegate.create(Agent, ExportShared), 50);
		}
		else{
			UtilsBase.PrintChatText("Shared Exported")
			ExportIDs();
		}
	}
	
	public static function ExportLumie() {
		if (appy.LumieID.length>0){
			var task = appy.LumieID.pop();
			Export(task, "illuminati",false);
			setTimeout(Delegate.create(Agent, ExportLumie), 50);
		}
		else{
			UtilsBase.PrintChatText("lumie Exported")
			ExportIDs();
		}
	}
	public static function ExportLumieSpecial() {
		if (appy.LumieIDSpecial.length>0){
			var task = appy.LumieIDSpecial.pop();
			Export(task, "illuminati",true);
			setTimeout(Delegate.create(Agent, ExportLumieSpecial), 50);
		}
		else{
			UtilsBase.PrintChatText("lumieSpecial Exported")
			ExportIDs();
		}
	}
	
	public static function ExportTemplar() {
		if (appy.TemplarID.length>0){
			var task = appy.TemplarID.pop();
			Export(task, "templar",false);
			setTimeout(Delegate.create(Agent, ExportTemplar), 50);
		}
		else{
			UtilsBase.PrintChatText("templar Exported")
			ExportIDs();
		}
	}
	public static function ExportTemplarSpecial() {
		if (appy.TemplarIDSpecial.length>0){
			var task = appy.TemplarIDSpecial.pop();
			Export(task, "templar",true);
			setTimeout(Delegate.create(Agent, ExportTemplarSpecial), 50);
		}
		else{
			UtilsBase.PrintChatText("templarSpecial Exported")
			ExportIDs();
		}
	}
	
	
	public static function ExportDragon() {
		if (appy.DragonID.length>0){
			var task = appy.DragonID.pop();
			Export(task, "dragon",false);
			setTimeout(Delegate.create(Agent, ExportDragon), 50);
		}
		else{
			UtilsBase.PrintChatText("dragon Exported")
			ExportIDs();
		}
	}
	public static function ExportDragonSpecial() {
		if (appy.DragonIDSpecial.length>0){
			var task = appy.DragonIDSpecial.pop();
			Export(task, "dragon",true);
			setTimeout(Delegate.create(Agent, ExportDragonSpecial), 50);
		}
		else{
			UtilsBase.PrintChatText("dragonSpecial Exported")
			UtilsBase.PrintChatText("done");
		}
	}
}
