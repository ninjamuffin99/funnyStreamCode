package;

import flixel.FlxG;
import flixel.FlxSprite;

class Rings extends FlxSprite
{
	public function new(x:Float, y:Float)
	{
		super(x, y);

		loadGraphic('assets/images/ringsSheet.png', true, 64, 64);
		animation.add('ring', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], 12);
		animation.play('ring');
	}
}
