package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;

class WinState extends FlxState
{
	override public function create()
	{
		super.create();
		FlxG.sound.play(AssetPaths.bruh__ogg);

		var text = new FlxText(0, 0, 0, "u won\nbut ur feets are still smelly\n\npress enter to play again (not recommended!!!111)", 20);
		text.screenCenter();
		add(text);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.pressed.ENTER)
		{
			FlxG.switchState(new PlayState());
		}
	}
}
