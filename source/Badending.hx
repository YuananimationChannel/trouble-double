package;

import Random;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.tweens.FlxTween;

class Badending extends FlxState {
	var image1:FlxSprite;
    var image2:FlxSprite;
    var image3:FlxSprite;
    var image4:FlxSprite;
    var image5:FlxSprite;
    var image6:FlxSprite;

	override public function create():Void {
		super.create();

        FlxG.sound.playMusic(Paths.music('gameOver-dt'));
        
		image1 = new FlxSprite();
        image1.loadGraphic(Paths.image("endings/bad_ending1"));
        image1.setGraphicSize(1280,720);
        image1.updateHitbox();
        image1.screenCenter();

        image2 = new FlxSprite();
        image2.loadGraphic(Paths.image("endings/bad_ending2"));
        image2.setGraphicSize(1280,720);
        image2.updateHitbox();
        image2.screenCenter();

        image3 = new FlxSprite();
        image3.loadGraphic(Paths.image("endings/bad_ending3"));
        image3.setGraphicSize(1280,720);
        image3.updateHitbox();
        image3.screenCenter();

        image4 = new FlxSprite();
        image4.loadGraphic(Paths.image("endings/bad_ending4"));
        image4.setGraphicSize(1280,720);
        image4.updateHitbox();
        image4.screenCenter();

        image5 = new FlxSprite();
        image5.loadGraphic(Paths.image("endings/bad_ending5"));
        image5.setGraphicSize(1280,720);
        image5.updateHitbox();
        image5.screenCenter();

        image6 = new FlxSprite();
        image6.loadGraphic(Paths.image("endings/bad_ending6"));
        image6.setGraphicSize(1280,720);
        image6.updateHitbox();
        image6.screenCenter();

        switch(Random.int(1, 6)) {
            case 1:
                add(image1);
            case 2:
                add(image2);
            case 3:
                add(image3);
            case 4:
                add(image4);
            case 5:
                add(image5);
            case 6:
                add(image6);
        }
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);

        if(FlxG.keys.justPressed.ANY)
            {
                FlxG.switchState(new MainMenuState());
            }
	}
}
