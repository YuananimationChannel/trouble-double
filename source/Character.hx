package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;

using StringTools;

class Character extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>>;
	public var debugMode:Bool = false;

	public var isPlayer:Bool = false;
	public var curCharacter:String = 'bf';

	public var holdTimer:Float = 0;

	public function new(x:Float, y:Float, ?character:String = "bf", ?isPlayer:Bool = false)
	{
		super(x, y);

		animOffsets = new Map<String, Array<Dynamic>>();
		curCharacter = character;
		this.isPlayer = isPlayer;

		var tex:FlxAtlasFrames;
		antialiasing = true;

		switch (curCharacter)
		{
			case 'gf':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('characters/GF_assets');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');

			case 'gf-emma':
				// MAH FAT NUTS LOL
				tex = Paths.getSparrowAtlas('characters/gfPixel');
				frames = tex;
				animation.addByIndices('singUP', 'GF IDLE', [2], "", 24, false);
				animation.addByIndices('danceLeft', 'GF IDLE', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF IDLE', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

				addOffset('danceLeft', 0);
				addOffset('danceRight', 0);

				playAnim('danceRight');

				setGraphicSize(Std.int(width * PlayState.daPixelZoom));
				updateHitbox();
				antialiasing = false;
					
			case 'gf-christmas':
				tex = Paths.getSparrowAtlas('characters/gfChristmas');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');

			case 'gf-car':
				tex = Paths.getSparrowAtlas('characters/gfCar');
				frames = tex;
				animation.addByIndices('singUP', 'GF Dancing Beat Hair blowing CAR', [0], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat Hair blowing CAR', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat Hair blowing CAR', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24,
					false);

				addOffset('danceLeft', 0);
				addOffset('danceRight', 0);

				playAnim('danceRight');
			case 'gfded':
					tex = Paths.getSparrowAtlas('characters/gfded');
					frames = tex;
					animation.addByIndices('singUP', 'GF Dancing Beat Hair blowing', [0], "", 24, false);
					animation.addByIndices('danceLeft', 'GF Dancing Beat Hair blowing', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
					animation.addByIndices('danceRight', 'GF Dancing Beat Hair blowing', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24,
						false);
	
					addOffset('danceLeft', 0);
					addOffset('danceRight', 0);
	
					playAnim('danceRight');

			case 'gf-pixel':
				tex = Paths.getSparrowAtlas('characters/gfPixel');
				frames = tex;
				animation.addByIndices('singUP', 'GF IDLE', [2], "", 24, false);
				animation.addByIndices('danceLeft', 'GF IDLE', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF IDLE', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

				addOffset('danceLeft', 0);
				addOffset('danceRight', 0);

				playAnim('danceRight');

				setGraphicSize(Std.int(width * PlayState.daPixelZoom));
				updateHitbox();
				antialiasing = false;

			case 'dad':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/DADDY_DEAREST', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'Dad idle dance', 24);
				animation.addByPrefix('singUP', 'Dad Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24);
				animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24);

				addOffset('idle');
				addOffset("singUP", -6, 50);
				addOffset("singRIGHT", 0, 27);
				addOffset("singLEFT", -10, 10);
				addOffset("singDOWN", 0, -30);

			case 'emma':
				tex = Paths.getSparrowAtlas('characters/Emma_Assets','shared');
				frames = tex;
				animation.addByPrefix('idle', 'Emma idle', 24, false);
				animation.addByPrefix('singUP', 'Emma UP', 24, false);
				animation.addByPrefix('singLEFT', 'Emma LEFT', 24, false);
				animation.addByPrefix('singRIGHT', 'Emma RIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'Emma DOWN', 24, false);

				addOffset('idle');
				addOffset("singUP", -34, 13);
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");

				playAnim('idle');
			case 'cuack':
				tex = Paths.getSparrowAtlas('characters/Cuack_Assets','shared');
				frames = tex;
				animation.addByPrefix('idle', 'Cuack IDLE', 24, false);
				animation.addByPrefix('singUP', 'Cuack UP', 24, false);
				animation.addByPrefix('singLEFT', 'Cuack LEFT', 24, false);
				animation.addByPrefix('singRIGHT', 'Cuack RIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'Cuack DOWN', 24, false);

				addOffset('idle');
				addOffset("singUP",0,40);
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN", 30, -50);

				playAnim('idle');

				case 'cuackevil':
					tex = Paths.getSparrowAtlas('characters/CuackGoo','shared');
					frames = tex;
					animation.addByPrefix('idle', 'GooCuack idle', 24, false);
					animation.addByPrefix('singUP', 'GooCuack UP', 24, false);
					animation.addByPrefix('singLEFT', 'GooCuack LEFT', 24, false);
					animation.addByPrefix('singRIGHT', 'GooCuack RIGHT', 24, false);
					animation.addByPrefix('singDOWN', 'GooCuack down', 24, false);
					animation.addByPrefix('singDOWN-special', 'GooCuack Attack DOWN', 24, false);
					animation.addByPrefix('singUP-special', 'GooCuack Attack UP', 24, false);

					animation.addByPrefix('idle-alt', 'Gooack idle', 24, false);
                    animation.addByPrefix('atkDOWN-alt', 'Gooack Attack DOWN', 24, false);
                    animation.addByPrefix('atkUP-alt', 'Gooack Attack UP', 24, false);
					animation.addByPrefix('singUP-alt', 'Gooack UP', 24, false);
					animation.addByPrefix('singDOWN-alt', 'Gooack down', 24, false);
					animation.addByPrefix('singLEFT-alt', 'Gooack LEFT', 24, false);
					animation.addByPrefix('singRIGHT-alt', 'Gooack RIGHT', 24, false);
		
					addOffset('idle');
					addOffset("singUP", 50, 25);
					addOffset("singRIGHT");
					addOffset("singLEFT", 30, 30);
					addOffset("singDOWN", 38, -140);
					addOffset('idle-alt');
					addOffset("singUP-alt", 50, 25);
					addOffset("singRIGHT-alt");
					addOffset("atkUP-alt");
					addOffset("atkDOWN-alt");
					addOffset("singLEFT-alt", 30, 30);
					addOffset("singDOWN-alt", 38, -140);
					addOffset('singUP-special');
					addOffset('singDOWN-special');
		
					playAnim('idle');

					case 'cuackmoreevil':
						tex = Paths.getSparrowAtlas('characters/CuackGoo','shared');
						frames = tex;
						
						animation.addByPrefix('idle', 'Gooack idle', 24, false);
						animation.addByPrefix('singDOWN-special', 'Gooack Attack DOWN', 24, false);
						animation.addByPrefix('atk', 'Gooack Attack DOWN', 24, false);
						animation.addByPrefix('singUP-special', 'Gooack Attack UP', 24, false);
						animation.addByPrefix('atk2', 'Gooack Attack UP', 24, false);
						animation.addByPrefix('singUP', 'Gooack UP', 24, false);
						animation.addByPrefix('singDOWN', 'Gooack down', 24, false);
						animation.addByPrefix('singLEFT', 'Gooack LEFT', 24, false);
						animation.addByPrefix('singRIGHT', 'Gooack RIGHT', 24, false);
			
						addOffset('idle');
						addOffset("singUP", 50, 25);
						addOffset("singRIGHT");
						addOffset('singUP-special');
						addOffset('singDOWN-special');
						addOffset('atk');
						addOffset('atk2');
						addOffset("singLEFT", 30, 30);
						addOffset("singDOWN", 38, -140);
			
						playAnim('idle');
					case 'somethinglol':
						tex = Paths.getSparrowAtlas('characters/CuackGoo','shared');
						frames = tex;
							
						animation.addByPrefix('idle', 'somethinglol idle', 24, false);
						animation.addByPrefix('singDOWN-special', 'somethinglol Attack DOWN', 24, false);
						animation.addByPrefix('singUP-special', 'somethinglol Attack UP', 24, false);
						animation.addByPrefix('singUP', 'somethinglol UP', 24, false);
						animation.addByPrefix('singDOWN', 'somethinglol down', 24, false);
						animation.addByPrefix('singLEFT', 'somethinglol LEFT', 24, false);
						animation.addByPrefix('singRIGHT', 'somethinglol RIGHT', 24, false);
				
						addOffset('idle');
						addOffset("singUP", 50, 25);
						addOffset("singRIGHT");
						addOffset('singUP-special');
						addOffset('singDOWN-special');
						addOffset("singLEFT", 30, 30);
						addOffset("singDOWN", 38, -140);
				
						playAnim('idle');
					

			case 'spooky':
				tex = Paths.getSparrowAtlas('characters/spooky_kids_assets');
				frames = tex;
				animation.addByPrefix('singUP', 'spooky UP NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'spooky DOWN note', 24, false);
				animation.addByPrefix('singLEFT', 'note sing left', 24, false);
				animation.addByPrefix('singRIGHT', 'spooky sing right', 24, false);
				animation.addByIndices('danceLeft', 'spooky dance idle', [0, 2, 6], "", 12, false);
				animation.addByIndices('danceRight', 'spooky dance idle', [8, 10, 12, 14], "", 12, false);

				addOffset('danceLeft');
				addOffset('danceRight');

				addOffset("singUP", -20, 26);
				addOffset("singRIGHT", -130, -14);
				addOffset("singLEFT", 130, -10);
				addOffset("singDOWN", -50, -130);

				playAnim('danceRight');
			case 'mom':
				tex = Paths.getSparrowAtlas('characters/Mom_Assets');
				frames = tex;

				animation.addByPrefix('idle', "Mom Idle", 24, false);
				animation.addByPrefix('singUP', "Mom Up Pose", 24, false);
				animation.addByPrefix('singDOWN', "MOM DOWN POSE", 24, false);
				animation.addByPrefix('singLEFT', 'Mom Left Pose', 24, false);
				// ANIMATION IS CALLED MOM LEFT POSE BUT ITS FOR THE RIGHT
				// CUZ DAVE IS DUMB!
				animation.addByPrefix('singRIGHT', 'Mom Pose Left', 24, false);

				addOffset('idle');
				addOffset("singUP", 14, 71);
				addOffset("singRIGHT", 10, -60);
				addOffset("singLEFT", 250, -23);
				addOffset("singDOWN", 20, -160);

				playAnim('idle');

			case 'mom-car':
				tex = Paths.getSparrowAtlas('characters/momCar');
				frames = tex;

				animation.addByPrefix('idle', "Mom Idle", 24, false);
				animation.addByPrefix('singUP', "Mom Up Pose", 24, false);
				animation.addByPrefix('singDOWN', "MOM DOWN POSE", 24, false);
				animation.addByPrefix('singLEFT', 'Mom Left Pose', 24, false);
				// ANIMATION IS CALLED MOM LEFT POSE BUT ITS FOR THE RIGHT
				// CUZ DAVE IS DUMB!
				animation.addByPrefix('singRIGHT', 'Mom Pose Left', 24, false);

				addOffset('idle');
				addOffset("singUP", 14, 71);
				addOffset("singRIGHT", 10, -60);
				addOffset("singLEFT", 250, -23);
				addOffset("singDOWN", 20, -160);

				playAnim('idle');
			case 'monster':
				tex = Paths.getSparrowAtlas('characters/Monster_Assets');
				frames = tex;
				animation.addByPrefix('idle', 'monster idle', 24, false);
				animation.addByPrefix('singUP', 'monster up note', 24, false);
				animation.addByPrefix('singDOWN', 'monster down', 24, false);
				animation.addByPrefix('singLEFT', 'Monster left note', 24, false);
				animation.addByPrefix('singRIGHT', 'Monster Right note', 24, false);

				addOffset('idle');
				addOffset("singUP", -20, 50);
				addOffset("singRIGHT", -51);
				addOffset("singLEFT", -30);
				addOffset("singDOWN", -30, -40);
				playAnim('idle');
			case 'monster-christmas':
				tex = Paths.getSparrowAtlas('characters/monsterChristmas');
				frames = tex;
				animation.addByPrefix('idle', 'monster idle', 24, false);
				animation.addByPrefix('singUP', 'monster up note', 24, false);
				animation.addByPrefix('singDOWN', 'monster down', 24, false);
				animation.addByPrefix('singLEFT', 'Monster left note', 24, false);
				animation.addByPrefix('singRIGHT', 'Monster Right note', 24, false);

				addOffset('idle');
				addOffset("singUP", -20, 50);
				addOffset("singRIGHT", -51);
				addOffset("singLEFT", -30);
				addOffset("singDOWN", -40, -94);
				playAnim('idle');
			case 'pico':
				tex = Paths.getSparrowAtlas('characters/Pico_FNF_assetss');
				frames = tex;
				animation.addByPrefix('idle', "Pico Idle Dance", 24);
				animation.addByPrefix('singUP', 'pico Up note0', 24, false);
				animation.addByPrefix('singDOWN', 'Pico Down Note0', 24, false);
				if (isPlayer)
				{
					animation.addByPrefix('singLEFT', 'Pico NOTE LEFT0', 24, false);
					animation.addByPrefix('singRIGHT', 'Pico Note Right0', 24, false);
					animation.addByPrefix('singRIGHTmiss', 'Pico Note Right Miss', 24, false);
					animation.addByPrefix('singLEFTmiss', 'Pico NOTE LEFT miss', 24, false);
				}
				else
				{
					// Need to be flipped! REDO THIS LATER!
					animation.addByPrefix('singLEFT', 'Pico Note Right0', 24, false);
					animation.addByPrefix('singRIGHT', 'Pico NOTE LEFT0', 24, false);
					animation.addByPrefix('singRIGHTmiss', 'Pico NOTE LEFT miss', 24, false);
					animation.addByPrefix('singLEFTmiss', 'Pico Note Right Miss', 24, false);
				}

				animation.addByPrefix('singUPmiss', 'pico Up note miss', 24);
				animation.addByPrefix('singDOWNmiss', 'Pico Down Note MISS', 24);

				addOffset('idle');
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -68, -7);
				addOffset("singLEFT", 65, 9);
				addOffset("singDOWN", 200, -70);
				addOffset("singUPmiss", -19, 67);
				addOffset("singRIGHTmiss", -60, 41);
				addOffset("singLEFTmiss", 62, 64);
				addOffset("singDOWNmiss", 210, -28);

				playAnim('idle');

				flipX = true;

			case 'bf':
				var tex = Paths.getSparrowAtlas('characters/BOYFRIEND', 'shared');
				frames = tex;

				trace(tex.frames.length);

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);
				animation.addByPrefix('singDOWN-special', 'bf pre attack', 24, false);
				animation.addByPrefix('singUP-special', 'BF JUMP', 24, false);

				animation.addByPrefix('singUP-alt', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT-alt', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT-alt', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN-alt', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss-alt', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss-alt', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss-alt', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss-alt', 'BF NOTE DOWN MISS', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);

				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);

				addOffset("singUPmiss-alt", -29, 27);
				addOffset("singRIGHTmiss-alt", -30, 21);
				addOffset("singLEFTmiss-alt", 12, 24);
				addOffset("singDOWNmiss-alt", -11, -19);

				addOffset("singUP-special", -35, -15);
				addOffset("singDOWN-special", -15, -45);

				addOffset("hey", 7, 4);
				addOffset("dodge", 7, 4);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);

				addOffset("singUP-alt", -29, 27);
				addOffset("singRIGHT-alt", -38, -7);
				addOffset("singLEFT-alt", 12, -6);
				addOffset("singDOWN-alt", -10, -50);

				playAnim('idle');

				flipX = true;

				case 'bfwithgf':
					var tex = Paths.getSparrowAtlas('characters/bfwithgf', 'shared');
					frames = tex;
					animation.addByPrefix('idle', 'bf and gf idle', 24, false);
					animation.addByPrefix('singUP', 'bf and gf up0', 24, false);
					animation.addByPrefix('singLEFT', 'bf and gf left0', 24, false);
					animation.addByPrefix('singRIGHT', 'bf and gf right0', 24, false);
					animation.addByPrefix('singDOWN', 'bf and gf down0', 24, false);
					animation.addByPrefix('singUPmiss', 'bf and gf up miss', 24, false);
					animation.addByPrefix('singLEFTmiss', 'bf and gf left miss', 24, false);
					animation.addByPrefix('singRIGHTmiss', 'bf and gf right miss', 24, false);
					animation.addByPrefix('singDOWNmiss', 'bf and gf down miss', 24, false);
	
					addOffset('idle', 0, 0);
					addOffset('singUP', -29, 10);
					addOffset('singRIGHT', -41, 23);
					addOffset('singLEFT', 12, 7);
					addOffset('singDOWN', -10, -10);
					addOffset('singUPmiss', -29, 10);
					addOffset('singRIGHTmiss', -41, 23);
					addOffset('singLEFTmiss', 12, 7);
					addOffset('singDOWNmiss', -10, -10);
	
					playAnim('idle');
	
					flipX = true;

					case 'bfgfded':
						frames = Paths.getSparrowAtlas('characters/deathbfgflol');
						animation.addByPrefix('singUP', "BF Dies with GF", 24, false);
						animation.addByPrefix('firstDeath', "BF Dies with GF", 24, false);
						animation.addByPrefix('deathLoop', "BF Dead with GF Loop", 24, true);
						animation.addByPrefix('deathConfirm', "RETRY confirm holding gf", 24, false);
						animation.play('firstDeath');
		
						addOffset('firstDeath', 37, 11);
						addOffset('deathLoop', 37, 5);
						addOffset('deathConfirm', 37, 69);
						playAnim('firstDeath');
		
						updateHitbox();
						antialiasing = false;
						flipX = true;


			case 'bf-dt-ded':
				frames = Paths.getSparrowAtlas('characters/deathlol');
				animation.addByPrefix('singUP', "CuackVore", 24, false);
				animation.addByPrefix('firstDeath', "CuackVore", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);
				animation.play('firstDeath');

				addOffset('firstDeath', 1275, 350);
				addOffset('deathLoop', 1275, 350);
				addOffset('deathConfirm', 1275, 350);
				playAnim('firstDeath');

				updateHitbox();
				antialiasing = false;
				flipX = true;
			
			case 'bf-pixel-dead':
				frames = Paths.getSparrowAtlas('characters/bfPixelsDEAD');
				animation.addByPrefix('singUP', "BF Dies pixel", 24, false);
				animation.addByPrefix('firstDeath', "BF Dies pixel", 24, false);
				animation.addByPrefix('deathLoop', "Retry Loop", 24, true);
				animation.addByPrefix('deathConfirm', "RETRY CONFIRM", 24, false);
				animation.play('firstDeath');

				addOffset('firstDeath');
				addOffset('deathLoop', -37);
				addOffset('deathConfirm', -37);
				playAnim('firstDeath');
				// pixel bullshit
				setGraphicSize(Std.int(width * 6));
				updateHitbox();
				antialiasing = false;
				flipX = true;
			
			case 'senpai':
				frames = Paths.getSparrowAtlas('characters/senpai');
				animation.addByPrefix('idle', 'Senpai Idle', 24, false);
				animation.addByPrefix('singUP', 'SENPAI UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'SENPAI LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'SENPAI RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'SENPAI DOWN NOTE', 24, false);

				addOffset('idle');
				addOffset("singUP", 5, 37);
				addOffset("singRIGHT");
				addOffset("singLEFT", 40);
				addOffset("singDOWN", 14);

				playAnim('idle');

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				antialiasing = false;
			case 'senpai-angry':
				frames = Paths.getSparrowAtlas('characters/senpai');
				animation.addByPrefix('idle', 'Angry Senpai Idle', 24, false);
				animation.addByPrefix('singUP', 'Angry Senpai UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'Angry Senpai LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'Angry Senpai RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'Angry Senpai DOWN NOTE', 24, false);

				addOffset('idle');
				addOffset("singUP", 5, 37);
				addOffset("singRIGHT");
				addOffset("singLEFT", 40);
				addOffset("singDOWN", 14);
				playAnim('idle');

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				antialiasing = false;

			case 'spirit':
				frames = Paths.getPackerAtlas('characters/spirit');
				animation.addByPrefix('idle', "idle spirit_", 24, false);
				animation.addByPrefix('singUP', "up_", 24, false);
				animation.addByPrefix('singRIGHT', "right_", 24, false);
				animation.addByPrefix('singLEFT', "left_", 24, false);
				animation.addByPrefix('singDOWN', "spirit down_", 24, false);

				addOffset('idle', -220, -280);
				addOffset('singUP', -220, -240);
				addOffset("singRIGHT", -220, -280);
				addOffset("singLEFT", -200, -280);
				addOffset("singDOWN", 170, 110);

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				playAnim('idle');

				antialiasing = false;

			case 'emmaandcuack':
					frames = Paths.getSparrowAtlas('characters/CuackAndEmma_Assets');
					animation.addByPrefix('idle', 'Cuack IDLE', 24, false);
					animation.addByPrefix('singUP', 'Cuack Up', 24, false);
					animation.addByPrefix('singDOWN', 'Cuack Down', 24, false);
					animation.addByPrefix('singLEFT', 'Cuack Left', 24, false);
					animation.addByPrefix('singRIGHT', 'Cuack Right', 24, false);
	
					animation.addByPrefix('singUP-alt', 'Emma Up', 24, false);
					animation.addByPrefix('singDOWN-alt', 'Emma Down', 24, false);
					animation.addByPrefix('singLEFT-alt', 'Emma Left', 24, false);
					animation.addByPrefix('singRIGHT-alt', 'Emma Right', 24, false);
	
					addOffset('idle');
					addOffset("singUP");
					addOffset("singRIGHT");
					addOffset("singLEFT");
					addOffset("singDOWN");
					addOffset("singUP-alt");
					addOffset("singRIGHT-alt");
					addOffset("singLEFT-alt");
					addOffset("singDOWN-alt");
	
					playAnim('idle');

			case 'parents-christmas':
				frames = Paths.getSparrowAtlas('characters/mom_dad_christmas_assets');
				animation.addByPrefix('idle', 'Parent Christmas Idle', 24, false);
				animation.addByPrefix('singUP', 'Parent Up Note Dad', 24, false);
				animation.addByPrefix('singDOWN', 'Parent Down Note Dad', 24, false);
				animation.addByPrefix('singLEFT', 'Parent Left Note Dad', 24, false);
				animation.addByPrefix('singRIGHT', 'Parent Right Note Dad', 24, false);

				animation.addByPrefix('singUP-alt', 'Parent Up Note Mom', 24, false);

				animation.addByPrefix('singDOWN-alt', 'Parent Down Note Mom', 24, false);
				animation.addByPrefix('singLEFT-alt', 'Parent Left Note Mom', 24, false);
				animation.addByPrefix('singRIGHT-alt', 'Parent Right Note Mom', 24, false);

				addOffset('idle');
				addOffset("singUP", -47, 24);
				addOffset("singRIGHT", -1, -23);
				addOffset("singLEFT", -30, 16);
				addOffset("singDOWN", -31, -29);
				addOffset("singUP-alt", -47, 24);
				addOffset("singRIGHT-alt", -1, -24);
				addOffset("singLEFT-alt", -30, 15);
				addOffset("singDOWN-alt", -30, -27);

				playAnim('idle');
		}

		dance();

		if (isPlayer)
		{
			flipX = !flipX;

			// Doesn't flip for BF, since his are already in the right place???
			if (!curCharacter.startsWith('bf'))
			{
				// var animArray
				var oldRight = animation.getByName('singRIGHT').frames;
				animation.getByName('singRIGHT').frames = animation.getByName('singLEFT').frames;
				animation.getByName('singLEFT').frames = oldRight;

				// IF THEY HAVE MISS ANIMATIONS??
				if (animation.getByName('singRIGHTmiss') != null)
				{
					var oldMiss = animation.getByName('singRIGHTmiss').frames;
					animation.getByName('singRIGHTmiss').frames = animation.getByName('singLEFTmiss').frames;
					animation.getByName('singLEFTmiss').frames = oldMiss;
				}
			}
			// Doesn't flip for BF, since his are already in the right place???
			if (!curCharacter.startsWith('bf'))
			{
				// var animArray
				var oldRight = animation.getByName('singRIGHT').frames;
				animation.getByName('singRIGHT').frames = animation.getByName('singLEFT').frames;
				animation.getByName('singLEFT').frames = oldRight;
				
				// IF THEY HAVE MISS ANIMATIONS??
				if (animation.getByName('singRIGHTmiss') != null)
				{
				var oldMiss = animation.getByName('singRIGHTmiss').frames;
				animation.getByName('singRIGHTmiss').frames = animation.getByName('singLEFTmiss').frames;
				animation.getByName('singLEFTmiss').frames = oldMiss;
				}
			}
		}
	}

	override function update(elapsed:Float)
	{
		if (!curCharacter.startsWith('bf'))
		{
			if (animation.curAnim.name.startsWith('sing'))
			{
				holdTimer += elapsed;
			}

			var dadVar:Float = 4;

			if (curCharacter == 'dad')
				dadVar = 6.1;
			if (holdTimer >= Conductor.stepCrochet * dadVar * 0.001)
			{
				trace('dance');
				dance();
				holdTimer = 0;
			}
		}

		switch (curCharacter)
		{
			case 'gf':
				if (animation.curAnim.name == 'hairFall' && animation.curAnim.finished)
					playAnim('danceRight');
		}

		super.update(elapsed);
	}

	private var danced:Bool = false;

	/**
	 * FOR GF DANCING SHIT
	 */
	public function dance()
	{
		if (!debugMode)
		{
			switch (curCharacter)
			{
				case 'gf':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}
				case 'gfded':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'gf-christmas':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'gf-car':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}
				case 'gf-pixel':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'spooky':
					danced = !danced;

					if (danced)
						playAnim('danceRight');
					else
						playAnim('danceLeft');
				default:
					playAnim('idle');
			}
		}
	}

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		animation.play(AnimName, Force, Reversed, Frame);

		var daOffset = animOffsets.get(AnimName);
		if (animOffsets.exists(AnimName))
		{
			offset.set(daOffset[0], daOffset[1]);
		}
		else
			offset.set(0, 0);

		if (curCharacter == 'gf')
		{
			if (AnimName == 'singLEFT')
			{
				danced = true;
			}
			else if (AnimName == 'singRIGHT')
			{
				danced = false;
			}

			if (AnimName == 'singUP' || AnimName == 'singDOWN')
			{
				danced = !danced;
			}
		}
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}
}
