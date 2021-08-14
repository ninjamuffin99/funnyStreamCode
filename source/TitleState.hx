package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;

class TitleState extends FlxState
{
	override public function create()
	{
		super.create();
		FlxG.sound.play(AssetPaths.bruh__ogg, 1, true);

		var text = new FlxText(0, 0, 0, "prss entor to start!!1", 12);
		text.screenCenter();
		add(text);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.pressed.ENTER)
		{
			trace("hi");
			FlxG.sound.play(AssetPaths.bruh__ogg);
			FlxG.switchState(new PlayState());
		}
	}
}
