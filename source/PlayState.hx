package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;

class PlayState extends FlxState
{
	var box:FlxSprite;
	var map:FlxOgmo3Loader;
	var walls:FlxTilemap;

	var note:FlxSprite;

	var grpRings:FlxTypedGroup<Rings>;
	var ringCount:Int = 0;
	var ringNumber:Int = 0;
	var ringText:FlxText;

	// var myAwesomeArray:Array<

	override public function create()
	{
		trace('hello world!');

		var myFrames:Array<Int> = [0, 1, 2];

		var bg:FlxSprite = new FlxSprite();
		bg.loadGraphic('assets/images/background.jpg');
		bg.scrollFactor.set(0, 0);
		bg.setGraphicSize(FlxG.width, FlxG.height);
		bg.updateHitbox();
		add(bg);

		map = new FlxOgmo3Loader('assets/data/greenHillzone.ogmo', 'assets/data/greenhillAct1.json');
		walls = map.loadTilemap('assets/images/tiles.png', 'walls');
		walls.follow();
		walls.setTileProperties(1, FlxObject.ANY);
		walls.setTileProperties(2, FlxObject.NONE);
		add(walls);

		box = new FlxSprite(200, 200);
		box.loadGraphic('assets/images/sonic.png', true, 100, 100);
		box.animation.add('changing', myFrames, 6);
		box.width = 50;
		box.offset.x = 25;
		add(box);

		grpRings = new FlxTypedGroup<Rings>();
		add(grpRings);

		ringText = new FlxText(5, 20, 0, "Rings: " + ringCount, 12);
		ringText.scrollFactor.set();
		add(ringText);

		map.loadEntities(placeEntities, 'entities');

		FlxG.camera.follow(box, TOPDOWN, 1);

		FlxG.sound.playMusic('assets/music/longTime.mp3');
		FlxG.sound.music.volume = 0.2;

		box.angularDrag = 500;
		box.maxAngular = 1000;
		box.acceleration.y = 800;

		super.create();
	}

	function placeEntities(entity:EntityData):Void
	{
		if (entity.name == "player")
		{
			box.setPosition(entity.x, entity.y);
		}
		else if (entity.name == "rings")
		{
			grpRings.add(new Rings(entity.x + 4, entity.y + 4));
			ringNumber++;
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		FlxG.collide(box, walls);
		FlxG.overlap(box, grpRings, playerOverlapsRings);

		if (FlxG.keys.justPressed.SPACE)
		{
			box.animation.play('changing');
		}

		if (box.y > FlxG.height)
		{
			FlxG.resetState();
			trace("you died lmfao noob");
		}

		movement();
		ringText.text = "Rings: " + ringCount;

		if (ringNumber == 0)
		{
			trace("u won hehe");
			FlxG.switchState(new WinState());
		}

		// awesome comment

		/*
		 * awesome
		 * multiline
		 * comment
		 */
	}

	function playerOverlapsRings(gamer:FlxSprite, daRing:Rings)
	{
		daRing.kill();

		ringCount++; // adds 1 to ring count
		FlxG.sound.play(AssetPaths.bruh__ogg);
		trace("wtf u just touched a ring!!1111");
		ringNumber--;
	}

	function movement():Void
	{
		if (FlxG.keys.justPressed.UP)
			box.velocity.y -= 500;
		else if (FlxG.keys.justPressed.RIGHT)
		{
			moveBox(700);
			box.flipX = false;
		}
		else if (FlxG.keys.justPressed.LEFT)
		{
			moveBox(-700);
			box.flipX = true;
		}

		if (FlxG.keys.justPressed.SPACE)
		{
			box.angularAcceleration = 200;
		}
		else
		{
			box.angularAcceleration = 0;
		}

		if (FlxG.keys.justReleased.RIGHT || FlxG.keys.justReleased.LEFT)
		{
			moveBox(0);
		}
		else if (FlxG.keys.justReleased.UP)
		{
			box.velocity.y = 0;
		}
	}

	function moveBox(xPosition:Float = 0)
	{
		box.velocity.x = xPosition;
	}
}
