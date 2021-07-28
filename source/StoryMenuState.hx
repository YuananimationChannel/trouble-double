package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.net.curl.CURLCode;

#if windows
import Discord.DiscordClient;
#end

using StringTools;

class StoryMenuState extends MusicBeatState
{
	var scoreText:FlxText;

	var weekData:Array<Dynamic> = [
		['Shop List', 'Breeze', 'Mischief', 'Hangout', 'Manic']
	];
	var curDifficulty:Int = 2;

	public static var weekUnlocked:Array<Bool> = [true, true, true, true, true, true, true, true];

	var weekCharacters:Array<Dynamic> = [
		['doubletrouble', 'bf', 'gf']
	];

	var weekNames:Array<String> = [
		"",
		"Double trouble."
	];

	var txtWeekTitle:FlxText;

	var curWeek:Int = 0;

	var txtTracklist:FlxText;

	var grpWeekText:FlxTypedGroup<MenuItem>;
	var grpWeekCharacters:FlxTypedGroup<MenuCharacter>;

	var grpLocks:FlxTypedGroup<FlxSprite>;

	var difficultySelectors:FlxGroup;
	var sprDifficulty:FlxSprite;
	var leftArrow:FlxSprite;
	var rightArrow:FlxSprite;
	var BONUSDUCK:FlxSprite;

	var float:FlxTween;
	var floatback:FlxTween;

	var floatdif:FlxTween;
	var floatbackdif:FlxTween;
	var weekThing:MenuItem;
	var tr:FlxSprite;
	var bonus:FlxSprite;
	var bga:FlxSprite;

	override function create()


	{
		#if windows
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Story Mode Menu", null);
		#end

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		
		if (FlxG.sound.music != null)
		{
			if (!FlxG.sound.music.playing)
				FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}

		persistentUpdate = persistentDraw = true;

		scoreText = new FlxText(10, 100000, 0, "SCORE: 49324858", 36);
		scoreText.setFormat("VCR OSD Mono", 32);
		scoreText.color = 0xFF000000;

		var bg:FlxSprite = new FlxSprite(-1000).loadGraphic(Paths.image('menustory'));
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0.10;
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);

		bga = new FlxSprite(-130,0).loadGraphic(Paths.image('porpp'));
		bga.scrollFactor.x = 0;
		bga.scrollFactor.y = 0.10;
		bga.setGraphicSize(Std.int(bga.width * 1.1));
		bga.updateHitbox();
		bga.antialiasing = true;
		add(bga);


		txtWeekTitle = new FlxText(FlxG.width * 0.7, 10, 0, "", 32);
		txtWeekTitle.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, RIGHT);
		txtWeekTitle.alpha = 0.7;

		var rankText:FlxText = new FlxText(0, 10);
		rankText.text = 'RANK: GREAT';
		rankText.setFormat(Paths.font("vcr.ttf"), 32);
		rankText.size = scoreText.size;
		rankText.screenCenter(X);

		var ui_tex = Paths.getSparrowAtlas('campaign_menu_UI_assets');
		var yellowBG:FlxSprite = new FlxSprite(0, 56).makeGraphic(FlxG.width, 400, 0xFFF9CF51);

		grpWeekText = new FlxTypedGroup<MenuItem>();
		add(grpWeekText);

		var blackBarThingie:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, 56, FlxColor.BLACK);

		grpWeekCharacters = new FlxTypedGroup<MenuCharacter>();

		grpLocks = new FlxTypedGroup<FlxSprite>();
		add(grpLocks);

		trace("Line 70");

		for (i in 0...weekData.length)
		{
			weekThing = new MenuItem(0, yellowBG.y + yellowBG.height + 10, i);
			weekThing.y += ((weekThing.height + 20) * i);
			weekThing.targetY = i;
			weekThing.scale.set(0.7, 0.7);
			weekThing.offset.set(-435, 430);
			grpWeekText.add(weekThing);

			weekThing.screenCenter(X);
			weekThing.antialiasing = true;
			// weekThing.updateHitbox();
			// Needs an offset thingie

			function floatfunction():Void 
				{
					float = FlxTween.tween(weekThing, {y: weekThing.y - 20}, 3, {
						ease: FlxEase.quadInOut,
						onComplete: function(tween:FlxTween)
						{
							floatback = FlxTween.tween(weekThing, {y: weekThing.y + 20}, 3, {
								ease: FlxEase.quadInOut,
								onComplete: function(tween:FlxTween)
								{
										floatfunction();
								}
							});
						}
					});
				}

				floatfunction();

			if (!weekUnlocked[i])
			{
				var lock:FlxSprite = new FlxSprite(weekThing.width + 10 + weekThing.x);
				lock.frames = ui_tex;
				lock.animation.addByPrefix('lock', 'lock');
				lock.animation.play('lock');
				lock.ID = i;
				lock.antialiasing = true;
				grpLocks.add(lock);
			}
		}
			tr = new FlxSprite(weekThing.x + 600,weekThing.y - 275).loadGraphic(Paths.image('tracks'));
			tr.updateHitbox();
			tr.antialiasing = true;
			add(tr);

			bonus = new FlxSprite(-1000,1000).loadGraphic(Paths.image('weekDUCK'));
			bonus.updateHitbox();
			bonus.alpha = 0;
			bonus.scale.set(0.7, 0.7);
			bonus.antialiasing = true;
			add(bonus);

		trace("Line 96");

		grpWeekCharacters.add(new MenuCharacter(10000, 100, 0.5, false));
		grpWeekCharacters.add(new MenuCharacter(400050, 25, 0.9, true));
		grpWeekCharacters.add(new MenuCharacter(85000, 100, 0.5, true));

		difficultySelectors = new FlxGroup();
		add(difficultySelectors);

		trace("Line 124");

		leftArrow = new FlxSprite(grpWeekText.members[0].x + grpWeekText.members[0].width - 50, grpWeekText.members[0].y + 10);
		leftArrow.frames = ui_tex;
		leftArrow.animation.addByPrefix('idle', "arrow left");
		leftArrow.animation.addByPrefix('press', "arrow push left");
		leftArrow.animation.play('idle');
		leftArrow.scale.set(0.7, 0.7);
		difficultySelectors.add(leftArrow);

		sprDifficulty = new FlxSprite(leftArrow.x + 130, leftArrow.y + 40);
		sprDifficulty.frames = ui_tex;
		sprDifficulty.animation.addByPrefix('easy', 'EASY');
		sprDifficulty.animation.addByPrefix('normal', 'NORMAL');
		sprDifficulty.animation.addByPrefix('hard', 'HARD');
		sprDifficulty.animation.play('easy');
		sprDifficulty.scale.set(0.7, 0.7);
		changeDifficulty();

		difficultySelectors.add(sprDifficulty);

		rightArrow = new FlxSprite(sprDifficulty.x + 170, leftArrow.y);
		rightArrow.frames = ui_tex;
		rightArrow.animation.addByPrefix('idle', 'arrow right');
		rightArrow.animation.addByPrefix('press', "arrow push right", 24, false);
		rightArrow.animation.play('idle');
		rightArrow.scale.set(0.7, 0.7);
		difficultySelectors.add(rightArrow);

		function floatfunction2():Void 
			{
				floatdif = FlxTween.tween(sprDifficulty, {y: sprDifficulty.y - 15}, 3, {
					ease: FlxEase.quadInOut,
					onComplete: function(tween:FlxTween)
					{
						floatbackdif = FlxTween.tween(sprDifficulty, {y: sprDifficulty.y + 15}, 3, {
							ease: FlxEase.quadInOut,
							onComplete: function(tween:FlxTween)
							{
									floatfunction2();
							}
						});
					}
				});
				floatdif = FlxTween.tween(leftArrow, {y: leftArrow.y - 15}, 3, {
					ease: FlxEase.quadInOut,
					onComplete: function(tween:FlxTween)
					{
						floatbackdif = FlxTween.tween(leftArrow, {y: leftArrow.y + 15}, 3, {
							ease: FlxEase.quadInOut,
							onComplete: function(tween:FlxTween)
							{
									floatfunction2();
							}
						});
					}
				});
				floatdif = FlxTween.tween(rightArrow, {y: rightArrow.y - 15}, 3, {
					ease: FlxEase.quadInOut,
					onComplete: function(tween:FlxTween)
					{
						floatbackdif = FlxTween.tween(rightArrow, {y: rightArrow.y + 15}, 3, {
							ease: FlxEase.quadInOut,
							onComplete: function(tween:FlxTween)
							{
									floatfunction2();
							}
						});
					}
				});
				floatdif = FlxTween.tween(tr, {y: tr.y + 15}, 3, {
					ease: FlxEase.quadInOut,
					onComplete: function(tween:FlxTween)
					{
						floatbackdif = FlxTween.tween(tr, {y: tr.y - 15}, 3, {
							ease: FlxEase.quadInOut,
							onComplete: function(tween:FlxTween)
							{
									floatfunction2();
							}
						});
					}
				});
			}
	
			floatfunction2();

		trace("Line 150");

		add(grpWeekCharacters);

		txtTracklist = new FlxText(FlxG.width * 0.05, 60, 0, "Tracks", 32);
		txtTracklist.alignment = CENTER;
		txtTracklist.font = rankText.font;
		txtTracklist.color = 0xFF000000;
		add(txtTracklist);
		// add(rankText);
		add(scoreText);

		updateText();

		trace("Line 165");

		super.create();

		
		add(BONUSDUCK);
	}

	override function update(elapsed:Float)
	{
		// scoreText.setFormat('VCR OSD Mono', 32);
		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, 0.5));

		scoreText.text = "WEEK SCORE:" + lerpScore;

		txtWeekTitle.text = weekNames[curWeek].toUpperCase();
		txtWeekTitle.x = FlxG.width - (txtWeekTitle.width + 10);

		// FlxG.watch.addQuick('font', scoreText.font);

		difficultySelectors.visible = weekUnlocked[curWeek];

		grpLocks.forEach(function(lock:FlxSprite)
		{
			lock.y = grpWeekText.members[lock.ID].y;
		});

		if (!movedBack)
		{
			if (!selectedWeek)
			{
				if (controls.UP_P)
				{
					changeWeek(-1);
				}

				if (controls.DOWN_P)
				{
					changeWeek(1);
				}

				if (FlxG.keys.justPressed.B)
				{
					FlxG.sound.play(Paths.sound('BONUSDUCKS'));
					FlxTween.tween(weekThing,{x: 1000 ,y: 1000}, 0.8, {ease: FlxEase.expoInOut});
					FlxTween.tween(bonus,{x: sprDifficulty.x - 240 ,y: sprDifficulty.y - 460, angle: 360.0, alpha: 1}, 1, {ease: FlxEase.expoInOut});
				}

				if (controls.RIGHT)
					rightArrow.animation.play('press')
				else
					rightArrow.animation.play('idle');

				if (controls.LEFT)
					leftArrow.animation.play('press');
				else
					leftArrow.animation.play('idle');

				if (controls.RIGHT_P)
					changeDifficulty(1);
				if (controls.LEFT_P)
					changeDifficulty(-1);
			}

			if (controls.ACCEPT)
			{
				selectWeek();
				aaa();

			}
		}

		if (controls.BACK && !movedBack && !selectedWeek)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			movedBack = true;
			FlxG.switchState(new MainMenuState());
		}

		super.update(elapsed);
	}

	var movedBack:Bool = false;
	var selectedWeek:Bool = false;
	var stopspamming:Bool = false;

	function aaa() {
		movedBack = true;
		if (float != null) {
			if (!float.finished)
				float.cancel();
		}
		if (floatback != null) {
			if (!floatback.finished)
				floatback.cancel();
		}
		if (floatbackdif != null) {
			if (!floatbackdif.finished)
				floatbackdif.cancel();
		}
		if (floatdif != null) {
			if (!floatdif.finished)
				floatdif.cancel();
		}
		FlxTween.tween(bga,{x: 1000}, 1.4, {ease: FlxEase.expoInOut});
		FlxTween.tween(bonus,{x: 2000}, 1.4, {ease: FlxEase.expoInOut});
		FlxTween.tween(weekThing,{x: 1000}, 1.4, {ease: FlxEase.expoInOut});
		FlxTween.tween(tr,{y: 1000}, 1.4, {ease: FlxEase.expoInOut});
		FlxTween.tween(leftArrow,{y: 1000}, 1.4, {ease: FlxEase.expoInOut});
		FlxTween.tween(sprDifficulty,{y: 1000}, 1.4, {ease: FlxEase.expoInOut});
		FlxTween.tween(rightArrow,{y: 1000}, 1.4, {ease: FlxEase.expoInOut});
	}

	function selectWeek()
	{
		if (weekUnlocked[curWeek])
		{
			if (stopspamming == false)
			{
				FlxG.sound.play(Paths.sound('confirmMenu'));

				grpWeekText.members[curWeek].startFlashing();
				grpWeekCharacters.members[1].animation.play('bfConfirm');
				stopspamming = true;
			}

			PlayState.storyPlaylist = weekData[curWeek];
			PlayState.isStoryMode = true;
			selectedWeek = true;

			var diffic = "";

			switch (curDifficulty)
			{
				case 0:
					diffic = '-easy';
				case 2:
					diffic = '-hard';
			}

			PlayState.storyDifficulty = curDifficulty;

			PlayState.SONG = Song.loadFromJson(StringTools.replace(PlayState.storyPlaylist[0]," ", "-").toLowerCase() + diffic, StringTools.replace(PlayState.storyPlaylist[0]," ", "-").toLowerCase());
			PlayState.storyWeek = curWeek;
			PlayState.campaignScore = 0;
			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				LoadingState.loadAndSwitchState(new PlayState(), true);
			});
		}
	}

	function changeDifficulty(change:Int = 0):Void
	{
		curDifficulty += change;

		if (curDifficulty < 0)
			curDifficulty = 2;
		if (curDifficulty > 2)
			curDifficulty = 0;

		sprDifficulty.offset.x = 0;

		switch (curDifficulty)
		{
			case 0:
				sprDifficulty.animation.play('easy');
				sprDifficulty.offset.x = 35;
			case 1:
				sprDifficulty.animation.play('normal');
				sprDifficulty.offset.x = 70;
			case 2:
				sprDifficulty.animation.play('hard');
				sprDifficulty.offset.x = 35;
		}

		sprDifficulty.alpha = 0;

		// USING THESE WEIRD VALUES SO THAT IT DOESNT FLOAT UP
		sprDifficulty.y = leftArrow.y + 2;
		intendedScore = Highscore.getWeekScore(curWeek, curDifficulty);

		#if !switch
		intendedScore = Highscore.getWeekScore(curWeek, curDifficulty);
		#end

		FlxTween.tween(sprDifficulty, {y: leftArrow.y + 15, alpha: 1}, 0.07);
	}

	var lerpScore:Int = 0;
	var intendedScore:Int = 0;

	function changeWeek(change:Int = 0):Void
	{
		curWeek += change;

		if (curWeek >= weekData.length)
			curWeek = 0;
		if (curWeek < 0)
			curWeek = weekData.length - 1;

		var bullShit:Int = 0;

		for (item in grpWeekText.members)
		{
			item.targetY = bullShit - curWeek;
			if (item.targetY == Std.int(0) && weekUnlocked[curWeek])
				item.alpha = 1;
			else
				item.alpha = 0.6;
			bullShit++;
		}

		FlxG.sound.play(Paths.sound('scrollMenu'));

		updateText();
	}

	function updateText()
	{
		grpWeekCharacters.members[0].setCharacter(weekCharacters[curWeek][0]);
		grpWeekCharacters.members[1].setCharacter(weekCharacters[curWeek][1]);
		grpWeekCharacters.members[2].setCharacter(weekCharacters[curWeek][2]);

		txtTracklist.text = "Tracks\n";
		var stringThing:Array<String> = weekData[curWeek];

		for (i in stringThing)
			txtTracklist.text += "\n" + i;

		txtTracklist.text = txtTracklist.text.toUpperCase();

		txtTracklist.screenCenter(X);
		txtTracklist.x -= FlxG.width * 1000;

		txtTracklist.text += "\n";

		#if !switch
		intendedScore = Highscore.getWeekScore(curWeek, curDifficulty);
		#end
	}
}
