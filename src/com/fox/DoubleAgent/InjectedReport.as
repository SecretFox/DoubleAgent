import com.GameInterface.Chat;
import com.GameInterface.UtilsBase;
import mx.utils.Delegate;
import com.Utils.LDBFormat;
/**
 * ...
 * @author fox
 */
class com.fox.DoubleAgent.InjectedReport {

	private var m_InjectionClip:MovieClip;
	private var m_Content:MovieClip
	private var m_QuestID:Number;
	private var m_LogoIlluminati:MovieClip;
	private var m_LogoTemplar:MovieClip;
	private var m_LogoDragon:MovieClip;
	

	public function InjectedReport(InjectionClip:MovieClip) {
		m_InjectionClip = InjectionClip;
		m_Content = InjectionClip.m_Content;
		m_QuestID = m_Content.m_QuestID;

		
		if (!m_Content.m_LogoIlluminati) {
			m_LogoIlluminati = m_Content.createEmptyMovieClip("m_LogoIlluminati", m_Content.getNextHighestDepth());
			m_LogoIlluminati._x = m_Content.m_BonusCashReward._x;
			m_LogoIlluminati._y = m_Content.m_BonusCashReward._y + 24;
			//illuminati logo has some transparent pixels that make clicking it harder
			m_LogoIlluminati.beginFill(0xFFFFFF, 0);
			m_LogoIlluminati.moveTo(0, 0);
			m_LogoIlluminati.lineTo(20, 0);
			m_LogoIlluminati.lineTo(20, 20);
			m_LogoIlluminati.lineTo(0, 20);
			m_LogoIlluminati.lineTo(0, 0);
			m_LogoIlluminati.endFill();
			m_LogoIlluminati.attachMovie("LogoIlluminati", "m_LogoIlluminati", m_LogoIlluminati.getNextHighestDepth(), {_width:20, _height:20});

			//These look awful when scaled so much
			//Changing the border alpha helps with it
			m_LogoTemplar = m_Content.attachMovie("LogoTemplar", "m_LogoTemplar", m_Content.getNextHighestDepth(), {_x:m_Content.m_BonusCashReward._x + 25, _y:m_Content.m_BonusCashReward._y + 24, _width:23, _height:23});
			prettify(m_LogoTemplar,0);
			m_LogoDragon = m_Content.attachMovie("LogoDragon", "m_LogoDragon", m_Content.getNextHighestDepth(), {_x:m_Content.m_BonusCashReward._x + 50, _y:m_Content.m_BonusCashReward._y + 24, _width:23, _height:23});
			prettify(m_LogoDragon,50);

			m_LogoIlluminati.onPress = Delegate.create(this, function() {
				this.ChangeDescription("QuestTaskSolvedIlluminati");
			});
			m_LogoTemplar.onPress = Delegate.create(this, function() {
				this.ChangeDescription("QuestTaskSolvedTemplar");
			});
			m_LogoDragon.onPress = Delegate.create(this, function() {
				this.ChangeDescription("QuestTaskSolvedDragon");
			});
			m_InjectionClip.SignalSizeChanged.Connect(RePosition, this);
			m_InjectionClip.SignalClose.Connect(Close, this);
		}
		if (m_Content.m_DescDragon){
			UtilsBase.PrintChatText("<font color=item_red>DoubleAgent: Please delete \"Custom/Flash/MissionRewardController.swf\" file, it is no longer needed and may cause issues</font>");
			Chat.SignalShowFIFOMessage.Emit("DoubleAgent: Please delete \"Custom/Flash/MissionRewardController.swf\" file, it is no longer needed and may cause issues", 0);
		}
	}

	private function prettify(logo,alpha) {
		//finds the biggest shape in movieclip and changes its alpha
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

	private function Close() {
		m_InjectionClip.SignalSizeChanged.Disconnect(RePosition, this);
		m_InjectionClip.SignalClose.Disconnect(Close, this);
	}

	
	private function RePosition() {
		m_LogoIlluminati._x = m_Content.m_BonusCashReward._x;
		m_LogoTemplar._x = m_Content.m_BonusCashReward._x+25;
		m_LogoDragon._x = m_Content.m_BonusCashReward._x+50;
		m_LogoIlluminati._y = m_Content.m_BonusCashReward._y + 24;
		m_LogoTemplar._y = m_Content.m_BonusCashReward._y + 24;
		m_LogoDragon._y	= m_Content.m_BonusCashReward._y + 24;
	}

	private function ChangeDescription(LDBString:String) {
		var Content = m_InjectionClip.m_Content;
		var text = LDBFormat.LDBGetText(LDBString, Number(m_QuestID));
		// if(!text)text = LDBFormat.LDBGetText("QuestTaskSolved", m_QuestID)
		// if the text is not found it's shared report,no need to change it in that case
		if (text) {
			m_Content.m_MissionDescription.text = text;
			//Forces window to resize
			m_InjectionClip.SetSize( 610, 250 );
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
			var m_FactionLogo = m_Content.attachMovie( factionLogo, "m_FactionLogo", m_Content.m_FactionLogo.getDepth());
			m_FactionLogo._xscale = 42;
			m_FactionLogo._yscale = 42;
			m_FactionLogo._x = 10;
			m_FactionLogo._y = 10;
			m_Content.m_FromText.text = sender;
		}
		//this needs reconnecting for some reason
		m_InjectionClip.SignalSizeChanged.Connect(RePosition, this);
	}
}