package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSubState;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class GameOverSubstate extends MusicBeatSubstate
{

	var bf:Boyfriend;
	var camFollow:FlxObject;

	var stageSuffix:String = "";
	
	public function new(x:Float, y:Float)
	{
		
		var daStage = PlayState.curStage;
		var daBf:String = '';
		switch (daStage)
		{
			case 'school':
				stageSuffix = '-pixel';
				daBf = 'bf-pixel-dead';
			case 'schoolEvil':
				stageSuffix = '-pixel';
				daBf = 'bf-pixel-dead';
			case 'night':
				stageSuffix = '';
				daBf = 'bf';
			case 'shop list':
				stageSuffix = '';
				daBf = 'bf';
			case 'park':
				stageSuffix = '';
				daBf = 'bf';
			case 'stage':
				stageSuffix = '';
				daBf = 'bf';
			case 'park2':
				stageSuffix = '';
				daBf = 'bf';
			case 'park3':
				stageSuffix = '';
				daBf = 'bf';
			default:
				daBf = 'bf';
		}


		if (daStage =='night')
		    FlxG.switchState(new Deathcutscene(1215,300));

		super();

		Conductor.songPosition = 0;
		
		bf = new Boyfriend(x, y, daBf);

		camFollow = new FlxObject(bf.getGraphicMidpoint().x, bf.getGraphicMidpoint().y, 1, 1);
		add(camFollow);

		if(daStage == 'stage' || daStage == 'shop list' || daStage == 'park' || daStage == 'park2'|| daStage == 'park3')
			{
				FlxG.sound.play(Paths.sound('fnf_loss_sfx' + stageSuffix));
				Conductor.changeBPM(100);
				add(bf);	
				bf.playAnim('firstDeath');
			}
		
		
	}
	override function update(elapsed:Float)
		{
			super.update(elapsed);
	
			if (controls.ACCEPT)
			{
				endBullshit();
			}
	
			if (controls.BACK)
			{
				FlxG.sound.music.stop();
	
				if (PlayState.isStoryMode)
					FlxG.switchState(new StoryMenuState());
				else
					FlxG.switchState(new FreeplayState());
				PlayState.loadRep = false;
			}
	
			if (bf.animation.curAnim.name == 'firstDeath' && bf.animation.curAnim.curFrame == 12)
			{
				FlxG.camera.follow(camFollow, LOCKON, 0.01);
			}
	
			if (bf.animation.curAnim.name == 'firstDeath' && bf.animation.curAnim.finished)
			{
				FlxG.sound.playMusic(Paths.music('gameOver' + stageSuffix));
			}
	
			if (FlxG.sound.music.playing)
			{
				Conductor.songPosition = FlxG.sound.music.time;
			}
		}
	
		override function beatHit()
		{
			super.beatHit();
	
			FlxG.log.add('beat');
		}
	
		var isEnding:Bool = false;
	
		function endBullshit():Void
		{
			if (!isEnding)
			{
				isEnding = true;
				bf.playAnim('deathConfirm', true);
				FlxG.sound.music.stop();
				FlxG.sound.play(Paths.music('gameOverEnd' + stageSuffix));
				new FlxTimer().start(0.7, function(tmr:FlxTimer)
				{
					FlxG.camera.fade(FlxColor.BLACK, 2, false, function()
					{
						LoadingState.loadAndSwitchState(new PlayState());
					});
				});
			}
		}
	}
	