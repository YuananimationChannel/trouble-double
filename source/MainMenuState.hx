package;

import Controls.KeyboardScheme;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import io.newgrounds.NG;
import lime.app.Application;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;

#if windows
import Discord.DiscordClient;
#end

using StringTools;

class MainMenuState extends MusicBeatState
{
	var curSelected:Int = 0;
	var ic:Int = 0;
	var tc:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;

	#if !switch
	var optionShit:Array<String> = ['story mode', 'freeplay', 'donate', 'options'];
	#else
	var optionShit:Array<String> = ['story mode', 'freeplay'];
	#end

	var STUFF:Array<String> = ['ae', 'aeae', 'aeaeae', 'aeaeaeae','aeaeaeaeae', 'aeaeaeaeaeae', 'aeaeaeaeaeaeae', 'aeaeaeaeaeaeaeae','aeaeaeaeaeaeaeaeae'];

	var newGaming:FlxText;
	var newGaming2:FlxText;
	public static var firstStart:Bool = true;

	public static var nightly:String = "";

	public static var kadeEngineVer:String = "1.5.2" + nightly;
	public static var gameVer:String = "0.2.7.1";

	var magenta:FlxSprite;
	var bga:FlxSprite;

	var float:FlxTween;
	var floatback:FlxTween;

	var a:FlxSprite;
	var bgb:FlxSprite;
	var camFollow:FlxObject;
	public static var finishedFunnyMove:Bool = false;
	public static var credits:Bool = false;
	var icons:FlxGroup;
	var icon:FlxSprite;

	var texts:FlxGroup;
	var text:FlxSprite;

	override function create()
	{
		#if windows
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		if (!FlxG.sound.music.playing)
		{
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}

		persistentUpdate = persistentDraw = true;

		var bg:FlxSprite = new FlxSprite(-1000).loadGraphic(Paths.image('menuBG'));
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0.10;
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);

		bga = new FlxSprite(2000).loadGraphic(Paths.image('grehh'));
		bga.scrollFactor.x = 0;
		bga.scrollFactor.y = 0.10;
		bga.setGraphicSize(Std.int(bga.width * 1.1));
		bga.updateHitbox();
		bga.antialiasing = true;
		add(bga);
		if (firstStart)
			FlxTween.tween(bga,{x: 0},0.8,{ease: FlxEase.expoInOut, onComplete: function(flxTween:FlxTween) 
				{ 
				}});
			else 
				FlxTween.tween(bga,{x: 0},0.8,{ease: FlxEase.expoInOut, onComplete: function(flxTween:FlxTween) 
					{ 
					}});

		bgb = new FlxSprite(-3000).loadGraphic(Paths.image('orngg'));
		bgb.scrollFactor.x = 0;
		bgb.scrollFactor.y = 0.10;
		bgb.setGraphicSize(Std.int(bgb.width * 1.1));
		bgb.updateHitbox();
		bgb.antialiasing = true;
		add(bgb);
		if (firstStart)
			FlxTween.tween(bgb,{x: 0},1,{ease: FlxEase.expoInOut, onComplete: function(flxTween:FlxTween) 
				{ 
				}});
			else 
				FlxTween.tween(bgb,{x: 0},1,{ease: FlxEase.expoInOut, onComplete: function(flxTween:FlxTween) 
					{ 
					}});


		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);

		magenta = new FlxSprite(-80).loadGraphic(Paths.image('menuDesat'));
		magenta.scrollFactor.x = 0;
		magenta.scrollFactor.y = 0.10;
		magenta.setGraphicSize(Std.int(magenta.width * 1.1));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.antialiasing = true;
		magenta.color = 0xFFfd719b;
		add(magenta);
		// magenta.scrollFactor.set();

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		var tex = Paths.getSparrowAtlas('FNF_main_menu_assets');

		for (i in 0...optionShit.length)
		{
			var menuItem:FlxSprite = new FlxSprite(-1000, -1000);
			menuItem.frames = tex;
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			menuItems.add(menuItem);
			menuItem.scale.set(0.8, 0.8);
			menuItem.scrollFactor.set();
			menuItem.antialiasing = true;
			if (firstStart)
				FlxTween.tween(menuItem,{y: 90 + (i * 150), x: 40 + (i * 250) },1.2 + (i * 0.25) ,{ease: FlxEase.expoInOut, onComplete: function(flxTween:FlxTween) 
					{ 
						finishedFunnyMove = true; 
						changeItem();
					}});
					else 
						FlxTween.tween(menuItem,{y: 90 + (i * 150), x: 40 + (i * 250) },1.2 + (i * 0.25) ,{ease: FlxEase.expoInOut, onComplete: function(flxTween:FlxTween) 
							{ 
								finishedFunnyMove = true; 
								changeItem();
							}});
		}

		icons = new FlxGroup();
		add(icons);

		var tex = Paths.getSparrowAtlas('icons');

		icon = new FlxSprite(1500, 190);
		icon.frames = tex;
		icon.animation.addByPrefix('emma', '1icons');
		icon.animation.addByPrefix('cuack', '2icons');
		icon.animation.addByPrefix('gama', '3icons');
		icon.animation.addByPrefix('shadow', '4icons');
		icon.animation.addByPrefix('snow', '5icons');
		icon.animation.addByPrefix('dor', '6icons');
		icon.animation.addByPrefix('edgar', '7icons');
		icon.animation.addByPrefix('coral', '8icons');
		icon.animation.addByPrefix('pix', '9icons');
		icon.scale.set(0.8, 0.8);
		icon.animation.play('emma');
		changeicon();

		icons.add(icon);

		texts = new FlxGroup();
		add(texts);

		var tex = Paths.getSparrowAtlas('creditshit');

		text = new FlxSprite(90, 1500);
		text.frames = tex;
		text.animation.addByPrefix('temma', 'text emma');
		text.animation.addByPrefix('tcuack', 'text cuack');
		text.animation.addByPrefix('tgama', 'text gama');
		text.animation.addByPrefix('tshadow', 'text shadow');
		text.animation.addByPrefix('tsnow', 'text snow');
		text.animation.addByPrefix('tdor', 'text dor');
		text.animation.addByPrefix('tedgar', 'text ed');
		text.animation.addByPrefix('tcoral', 'text coral');
		text.animation.addByPrefix('tpix', 'text pix');
		text.scale.set(0.8, 0.8);
		text.animation.play('temma');
		changetext();

		texts.add(text);

		a = new FlxSprite(5, -1500).loadGraphic(Paths.image('arrow'));
		a.updateHitbox();
		add(a);

		firstStart = false;


		var versionShit:FlxText = new FlxText(5, FlxG.height - 18, 0, gameVer +  (Main.watermarks ? " FNF - " + kadeEngineVer + " Kade Engine" : ""), 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);

		// NG.core.calls.event.logEvent('swag').send();


		if (FlxG.save.data.dfjk)
			controls.setKeyboardScheme(KeyboardScheme.Solo, true);
		else
			controls.setKeyboardScheme(KeyboardScheme.Duo(true), true);

		changeItem();

		super.create();
	}

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		if (!selectedSomethin)
		{

			if (controls.RIGHT_P && credits)
				{
					changetext(1);
					changeicon(1);
					FlxG.sound.play(Paths.sound('scrollMenu'));
				}
			if (controls.LEFT_P && credits)
				{
					changetext(-1);
					changeicon(-1);
					FlxG.sound.play(Paths.sound('scrollMenu'));
				}
				

			if (controls.UP_P && !credits)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}

			if (controls.DOWN_P && !credits)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}

			if (controls.BACK)
			{
				if (!credits)
					{
					FlxG.switchState(new TitleState());
					}
			}

			if (controls.BACK && credits)
			{
					credits = false;
					menuItems.forEach(function(spr:FlxSprite)
					{
									FlxTween.tween(spr, {x: spr.x + 1500 ,alpha: 1}, 1.5, {
										ease: FlxEase.quadOut,
										onComplete: function(twn:FlxTween)
										{
										}
									});
					});
					FlxTween.tween(icon, {x: 1500 ,alpha: 1}, 1.5, {ease: FlxEase.quadOut,
						onComplete: function(twn:FlxTween)
						{
						}
					});
					FlxTween.tween(a, {y: -1500 ,alpha: 1}, 2, {ease: FlxEase.quadOut,
						onComplete: function(twn:FlxTween)
						{
						}
					});

					FlxTween.tween(text, {y: 1500 ,alpha: 1}, 2, {ease: FlxEase.quadOut,
						onComplete: function(twn:FlxTween)
						{
							aaa();
						}
					});

			}

			if (controls.ACCEPT && !credits)
			{
			    if (optionShit[curSelected] == 'donate')
						{

							credits = true;
							menuItems.forEach(function(spr:FlxSprite)
								{
											FlxTween.tween(spr, {x: spr.x - 1500 ,alpha: 1}, 1.5, {
												ease: FlxEase.quadOut,
												onComplete: function(twn:FlxTween)
												{
												}
											});
								});
								FlxTween.tween(icon, {x: 25 ,alpha: 1}, 1.5, {ease: FlxEase.quadOut,
									onComplete: function(twn:FlxTween)
									{
										FlxTween.tween(icon, {y: icon.y + 10 ,alpha: 1}, 1, {type: FlxTweenType.PINGPONG});
									}
								});
								FlxTween.tween(a, {y: 190 ,alpha: 1}, 2, {ease: FlxEase.quadOut,
									onComplete: function(twn:FlxTween)
									{
									}
								});

								FlxTween.tween(text, {y: 10 ,alpha: 1}, 2, {ease: FlxEase.quadOut,
									onComplete: function(twn:FlxTween)
									{
										aaatweens();
									}
								});
								icon.angle = -5;

								new FlxTimer().start(0.01, function(tmr:FlxTimer)
									{
										if(icon.angle == -5) 
											FlxTween.angle(icon, icon.angle, 5,1, {ease: FlxEase.quartInOut});
										if (icon.angle == 5) 
											FlxTween.angle(icon, icon.angle, -5, 1, {ease: FlxEase.quartInOut});
									}, 0);
						}
				else
					{
					FlxTween.tween(bga,{x: 2000},0.8,{ease: FlxEase.expoInOut, onComplete: function(flxTween:FlxTween) 
						{ 
						}});

					FlxTween.tween(bgb,{x: -1000},0.8,{ease: FlxEase.expoInOut, onComplete: function(flxTween:FlxTween) 
						{ 
						}});

						selectedSomethin = true;
						FlxG.sound.play(Paths.sound('confirmMenu'));

						menuItems.forEach(function(spr:FlxSprite)
						{
							if (curSelected != spr.ID)
							{
								FlxTween.tween(spr, {x: -1500 ,alpha: 1}, 3, {
									ease: FlxEase.quadOut,
									onComplete: function(twn:FlxTween)
									{
										spr.kill();
									}
								});
							}
							else
							{
								if (FlxG.save.data.flashing)
								{
									FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
									{
										goToState();
									});
									FlxTween.tween(spr, {x: -1500 ,alpha: 1}, 3, {
										ease: FlxEase.quadOut,
										onComplete: function(twn:FlxTween)
										{
										}
									});
								}
								else
								{
									new FlxTimer().start(1, function(tmr:FlxTimer)
									{
										goToState();
									});
									FlxTween.tween(spr, {x: -1500 ,alpha: 1}, 3, {
										ease: FlxEase.quadOut,
										onComplete: function(twn:FlxTween)
										{
										}
									});
								}
							}
						});
					}
			}
		}

		super.update(elapsed);

		menuItems.forEach(function(spr:FlxSprite)
		{
		});
	}
	function aaa() {
		if (float != null) {
			if (!float.finished)
				float.cancel();
		}
		if (floatback != null) {
			if (!floatback.finished)
				floatback.cancel();
		}
	}

			function aaatweens():Void 
				{

							float = FlxTween.tween(text, {y: text.y - 20}, 3, {
								ease: FlxEase.quadInOut,
								onComplete: function(tween:FlxTween)
								{
									floatback = FlxTween.tween(text, {y: text.y + 20}, 3, {
										ease: FlxEase.quadInOut,
										onComplete: function(tween:FlxTween)
										{
												aaatweens();
										}
									});
								}
							});
				}
		


	function changeicon(change:Int = 0):Void
		{
			ic += change;
	
			if (ic >= STUFF.length)
				ic = 0;
			if (ic < 0)
				ic = STUFF.length - 1;

			switch (ic)
			{
					case 0:
						icon.animation.play('emma');
					case 1:
						icon.animation.play('cuack');
					case 2:
						icon.animation.play('gama');
					case 3:
						icon.animation.play('shadow');
					case 4:
						icon.animation.play('snow');
					case 5:
						icon.animation.play('dor');
					case 6:
						icon.animation.play('edgar');
					case 7:
						icon.animation.play('coral');
					case 8:
						icon.animation.play('pix');
	
			 }
		}

		function changetext(change:Int = 0):Void
			{
				tc += change;
		
				if (tc >= STUFF.length)
					tc = 0;
				if (tc < 0)
					tc = STUFF.length - 1;
	
				switch (tc)
				{
						case 0:
							text.animation.play('temma');
						case 1:
							text.animation.play('tcuack');
						case 2:
							text.animation.play('tshadow');
						case 3:
							text.animation.play('tdor');
						case 4:
							text.animation.play('tsnow');
						case 5:
							text.animation.play('tedgar');
						case 6:
							text.animation.play('tgama');
						case 7:
							text.animation.play('tcoral');
						case 8:
							text.animation.play('tpix');
		
				 }
			}
	
	function goToState()
	{
		var daChoice:String = optionShit[curSelected];

		switch (daChoice)
		{
			case 'story mode':
				FlxG.switchState(new StoryMenuState());
				trace("Story Menu Selected");
			case 'freeplay':
				FlxG.switchState(new FreeplayState());

				trace("Freeplay Menu Selected");

			case 'options':
				FlxG.switchState(new OptionsMenu());
		}
	}


	function changeItem(huh:Int = 0)
	{
		if (finishedFunnyMove)
		{
			curSelected += huh;

			if (curSelected >= menuItems.length)
				curSelected = 0;
			if (curSelected < 0)
				curSelected = menuItems.length - 1;
		}
		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');

			if (spr.ID == curSelected && finishedFunnyMove)
			{
				spr.animation.play('selected');
			}

			spr.updateHitbox();
		});
	}
}
