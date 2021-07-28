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
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class Cut2 extends FlxSpriteGroup {
  var data:Array<String> = [];
  var dialogueSections:Array<Array<String>>=[];
  public var finishThing:Void->Void;
  var dialogueBox:DialogueBox;
  var cutsceneImage:FlxSprite;
  var cutsceneSec:Int = 0;
  var thishit:FlxSprite;
  var canSkip:Bool=false;
  var shitPattern = new EReg("\\[.+\\]","i");
  public function new(?data:Array<String>){
    super();

    this.data=data;
    parseDialogue();
    cutsceneImage = new FlxSprite();
    updateGraphic();

    thishit = new FlxSprite(0, 0).makeGraphic(Std.int(FlxG.width * 3), Std.int(FlxG.height * 3), 0xFF000000);
    thishit.scrollFactor.set();
    thishit.alpha = 1;
    thishit.setGraphicSize(Std.int(thishit.width*(1+(1-FlxG.camera.zoom))));
    add(thishit);

    FlxTween.tween(thishit, {alpha: 0}, .5, {
      ease: FlxEase.quadInOut,
      onComplete: function(twn:FlxTween)
      {
        doShit();
      }
    });

  }

  function updateGraphic(){
    cutsceneImage.loadGraphic(Paths.image("cutscenes/cutscenesong2/cut" + Std.string(cutsceneSec+1) ) );
    cutsceneImage.updateHitbox();

    cutsceneImage.setGraphicSize(1280,720);
    cutsceneImage.updateHitbox();
    cutsceneImage.screenCenter();
    add(cutsceneImage);
  }

  function doShit() {
    if(dialogueSections[cutsceneSec].length>0){
      canSkip=false;
      dialogueBox = new DialogueBox(false, dialogueSections[cutsceneSec]);
      dialogueBox.finishThing = function(){
        cutsceneSec++;
        if(cutsceneSec==dialogueSections.length){
          FlxTween.tween(thishit, {alpha: 1}, .5, {
            ease: FlxEase.quadInOut,
            onComplete: function(twn:FlxTween)
            {
              remove(cutsceneImage);
              FlxTween.tween(thishit, {alpha: 0}, .5, {
                ease: FlxEase.quadInOut,
                onComplete: function(twn:FlxTween)
                {
                  remove(thishit);
                  finishThing();
                }
              });
            }
          });
        }else{
          canSkip=true;
        }
      }
      add(dialogueBox);
    }else{
      cutsceneSec++;
      if(cutsceneSec==dialogueSections.length){
        FlxTween.tween(thishit, {alpha: 0}, .5, {
          ease: FlxEase.quadInOut,
          onComplete: function(twn:FlxTween)
          {
            remove(cutsceneImage);
            FlxTween.tween(thishit, {alpha: 1}, .5, {
              ease: FlxEase.quadInOut,
              onComplete: function(twn:FlxTween)
              {
                remove(thishit);
                finishThing();
              }
            });
          }
        });
      }else{
        canSkip=true;
      }
    }
  }

  override function update(elapsed:Float){
    super.update(elapsed);
    if(canSkip && FlxG.keys.justPressed.ANY){
      canSkip=false;
      FlxTween.tween(thishit, {alpha: 1}, .5, {
        ease: FlxEase.quadInOut,
        onComplete: function(twn:FlxTween)
        {
          FlxTween.tween(thishit, {alpha: 0}, .5, {ease: FlxEase.quadInOut});
          updateGraphic();
          doShit();
        }
      });

    }
    
    if(FlxG.keys.justPressed.SPACE && cutsceneImage.visible)
      {
        remove(dialogueBox);
        remove(cutsceneImage);
        remove(thishit);
        new FlxTimer().start(0.2, function(tmr:FlxTimer)
          {
            finishThing();
            kill();
            FlxG.sound.music.stop();
          });
		}
  }


  function parseDialogue(){
    var currentSection = -1;
    for (i in data){
      if(shitPattern.match(i) ){
        currentSection++;
        dialogueSections[currentSection]=[];
      }else{
        dialogueSections[currentSection].push(i);
      }
    }
  }
}
