package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;
	var skipshit:FlxText;

	public var finishThing:Void->Void;

	var portraitLeft:FlxSprite;
	var portraitRight:FlxSprite;

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'thorns':
				FlxG.sound.playMusic(Paths.music('LunchboxScary'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
		}

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		box = new FlxSprite(-20, 45);
		
		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			
			case 'shop-list':
				hasDialog = true;
				box.loadGraphic(Paths.image('weeb/pixelUI/box'));
				box.animation.add('normalOpen', [0], 1, false);
				box.animation.add('normal', [0], 1, false);
				box.y = 0;
				box.x = 0;

			case 'breeze':
				hasDialog = true;
				box.loadGraphic(Paths.image('weeb/pixelUI/box'));
				box.animation.add('normalOpen', [0], 1, false);
				box.animation.add('normal', [0], 1, false);
				box.y = 0;
				box.x = 0;

			case 'mischief':
				hasDialog = true;
				box.loadGraphic(Paths.image('weeb/pixelUI/box'));
				box.animation.add('normalOpen', [0], 1, false);
				box.animation.add('normal', [0], 1, false);
				box.y = 0;
				box.x = 0;

			case 'hangout':
				hasDialog = true;
				box.loadGraphic(Paths.image('weeb/pixelUI/box'));
				box.animation.add('normalOpen', [0], 1, false);
				box.animation.add('normal', [0], 1, false);
				box.y = 0;
				box.x = 0;

			case 'manic':
				hasDialog = true;
				box.loadGraphic(Paths.image('weeb/pixelUI/box'));
				box.animation.add('normalOpen', [0], 1, false);
				box.animation.add('normal', [0], 1, false);
				box.y = 0;
				box.x = 0;
			
			case 'roses':
				hasDialog = true;
				FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'));

				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-senpaiMad');
				box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
				box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH', [4], "", 24);

			case 'thorns':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);
		}

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;
		
		portraitLeft = new FlxSprite(100, 120);
		portraitLeft.frames = Paths.getSparrowAtlas('portraits/emma');
		portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter instance 1', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * 1));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;

		portraitRight = new FlxSprite(700, 193);
		portraitRight.frames = Paths.getSparrowAtlas('portraits/bf');
		portraitRight.animation.addByPrefix('enter', 'Senpai Portrait Enter instance 1', 24, false);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * 1));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;

		box.animation.play('normalOpen');
		box.setGraphicSize(Std.int(box.width * 1));
		box.updateHitbox();
		add(box);

		box.screenCenter(X);

		handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('weeb/pixelUI/hand_textbox'));


		if (!talkingRight)
		{
			// box.flipX = true;
		}

		dropText = new FlxText(232, 522, Std.int(FlxG.width * 0.7), "", 27);
		dropText.font = 'Pixel Arial 11 Bold';
		dropText.color = 0xFFD89494;
		add(dropText);

		skipshit = new FlxText(10, 10, "press SPACE to skip.\n", 60);
		skipshit.setFormat(Paths.font("vcr.ttf"),25,FlxColor.WHITE, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		skipshit.borderSize = 2;
		skipshit.borderQuality = 1;
		add(skipshit);

		swagDialogue = new FlxTypeText(230, 520, Std.int(FlxG.width * 0.7), "", 27);
		swagDialogue.font = 'Pixel Arial 11 Bold';
		swagDialogue.color = 0xFF3F2021;
        swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.color = FlxColor.BLACK;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}

		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if(FlxG.keys.justPressed.SPACE)
			{
				remove(dialogue);
			  new FlxTimer().start(0.2, function(tmr:FlxTimer)
				{
				  finishThing();
				  kill();
				  FlxG.sound.music.stop();
				});
			  }

		if (!FlxG.keys.justPressed.SPACE && FlxG.keys.justPressed.ANY  && dialogueStarted == true)
		{
			remove(dialogue);
				
			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns')
						FlxG.sound.music.fadeOut(2.2, 0);

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						bgFade.alpha -= 1 / 5 * 0.7;
						portraitLeft.visible = false;
						portraitRight.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}
		
		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		switch (curCharacter)
		{
			case 'dad':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
			case 'bf':
				portraitLeft.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enter');
				}

			case 'bfuh':
				portraitLeft.visible = false;
				portraitRight.frames = Paths.getSparrowAtlas('portraits/bfuh', 'shared');
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enter');
				}
			case 'boyf':
				portraitLeft.visible = false;
				portraitRight.frames = Paths.getSparrowAtlas('portraits/bf', 'shared');
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enter');
				}
		    case 'gf':
				portraitLeft.visible = false;
				portraitRight.frames = Paths.getSparrowAtlas('portraits/gf', 'shared');
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enter');
				}

			case 'emmahappy':
				FlxG.sound.play(Paths.sound('emmaboop'));
				portraitRight.visible = false;
				portraitLeft.frames = Paths.getSparrowAtlas('portraits/emmahappy', 'shared');
				if (!portraitRight.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}

			case 'emma':
				FlxG.sound.play(Paths.sound('emmaboop'));
				portraitRight.visible = false;
			    portraitLeft.frames = Paths.getSparrowAtlas('portraits/emma', 'shared');
				if (!portraitRight.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}

			case 'emmaoh':
				FlxG.sound.play(Paths.sound('emmaboop'));
				portraitRight.visible = false;
				portraitLeft.frames = Paths.getSparrowAtlas('portraits/emmaoh', 'shared');
				if (!portraitRight.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}

			case 'emmascared':
				FlxG.sound.play(Paths.sound('emmaboop'));
				portraitRight.visible = false;
				portraitLeft.frames = Paths.getSparrowAtlas('portraits/emmascared', 'shared');
				if (!portraitRight.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
			case 'airlol':
				portraitRight.visible = false;
				portraitLeft.frames = Paths.getSparrowAtlas('portraits/airlol', 'shared');
				if (!portraitRight.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}

			case 'cuack':
				portraitRight.visible = false;
					portraitLeft.frames = Paths.getSparrowAtlas('portraits/cuack', 'shared');
				if (!portraitRight.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
				
		case 'cuackcrazy':
			portraitRight.visible = false;
				portraitLeft.frames = Paths.getSparrowAtlas('portraits/cuackcrazy', 'shared');
			if (!portraitRight.visible)
			{
				portraitLeft.visible = true;
				portraitLeft.animation.play('enter');
			}

							
		case 'goouack':
			portraitRight.visible = false;
				portraitLeft.frames = Paths.getSparrowAtlas('portraits/goouack', 'shared');
			if (!portraitRight.visible)
			{
				portraitLeft.visible = true;
				portraitLeft.animation.play('enter');
			}

		case 'cuaconfused':
				portraitRight.visible = false;
				portraitLeft.frames = Paths.getSparrowAtlas('portraits/cuaconfused', 'shared');
			if (!portraitRight.visible)
			{
				portraitLeft.visible = true;
				portraitLeft.animation.play('enter');
			}

			case 'cuashock':
				portraitRight.visible = false;
				portraitLeft.frames = Paths.getSparrowAtlas('portraits/cuashock', 'shared');
			if (!portraitRight.visible)
			{
				portraitLeft.visible = true;
				portraitLeft.animation.play('enter');
			}

			case 'cuahappy':
				portraitRight.visible = false;
				portraitLeft.frames = Paths.getSparrowAtlas('portraits/cuahappy', 'shared');
			if (!portraitRight.visible)
			{
				portraitLeft.visible = true;
				portraitLeft.animation.play('enter');
			}

			case 'cuamorecrazy':
				portraitRight.visible = false;
				portraitLeft.frames = Paths.getSparrowAtlas('portraits/cuamorecrazy', 'shared');
			if (!portraitRight.visible)
			{
				portraitLeft.visible = true;
				portraitLeft.animation.play('enter');
			}
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}
