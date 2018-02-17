/**
 * ...
 * @author fox
 */
import com.fox.DoubleAgent.App;

class com.fox.DoubleAgent.Main {
	private static var s_app:App;

	public static function main(swfRoot:MovieClip):Void {
		s_app = new App(swfRoot);
		swfRoot.onLoad = OnLoad;
		swfRoot.onUnload = OnUnload;
	}

	public function Main() { }

	public static function OnLoad() {
		s_app.onLoad();
	}

	public static function OnUnload() {
		s_app.onUnload();
	}
}