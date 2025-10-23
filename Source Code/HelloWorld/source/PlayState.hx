package;

import Calculator;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
// import flixel.addons.ui.FlxButtonPlus;
import flixel.addons.ui.FlxInputText;
import flixel.addons.ui.FlxUIButton;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
// import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import hscript.Interp;


class PlayState extends FlxState
{ 
	// variables
	var buttonGroup:FlxGroup = new FlxGroup();
	var MAX_PER_ROW:Int = 4;

	override public function create()
	{
		//FlxG.scaleMode = new FillScaleMode();
		// ADD flxbitmap text 
		super.create();
		
		var calc:Calculator;
		// Buttons.
		var calculatorUI:Array<Dynamic> = [
			1,2,3,"+",
			4,5,6,"-",
			7,8,9,"*",
			"C",0,"=","/"
		];
			
		// Input field
		var inputField = new FlxInputText(0, 0, 400, "", 40);
		inputField.antialiasing = true;

		// Position input field
		inputField.x = FlxG.width / 2 + 100 * ((buttonGroup.members.length % MAX_PER_ROW) - MAX_PER_ROW/2) + 0 /2;
		inputField.y = Math.floor(buttonGroup.members.length / MAX_PER_ROW) * 100;
		inputField.filterMode = FlxInputText.ONLY_NUMERIC;
		buttonGroup.add(inputField);

		// Empty objects for spacing
		var emptyObject = new FlxSprite();
		var emptyObject2 = new FlxSprite();
		var emptyObject3 = new FlxSprite();

		buttonGroup.add(emptyObject);
		buttonGroup.add(emptyObject2);
		buttonGroup.add(emptyObject3);


		add(inputField);

				
		// loop through array(calculatorUI) to create buttons
		for (i in calculatorUI) {
			var button = new FlxUIButton(0, 0, Std.string(i), () -> {
			if (i == "C"){
				inputField.text = "";
			}
			else if (i == "="){
				var result = calculations(inputField.text);
				trace("Result: " + result);
				inputField.text = Std.string(result);
			}
			else {
				inputField.text += Std.string(i);
			}});
			// Resize buttons
			button.resize(50, 50);
			button.antialiasing = true;
				
			// Align buttons in the grid
			button.x = FlxG.width / 2 + 100 * ((buttonGroup.members.length % MAX_PER_ROW) - MAX_PER_ROW/2) + button.width /2;
			button.y = Math.floor(buttonGroup.members.length / MAX_PER_ROW) * 100;
			
			// button.label.setFormat(null, 0, FlxColor.BLACK, "center");
			// Center Text
			// button.textNormal.alignment = FlxTextAlign.CENTER;
			// button.textHighlight.alignment = FlxTextAlign.CENTER;
			// Vertical centering of text
			// button.textNormal.y = button.y + (button.height - button.textNormal.height) / 2;
			// button.textHighlight.y = button.y + (button.height - button.textHighlight.height) / 2;
			// Add to group and state
			buttonGroup.add(button);
			add(button);
			
		}
		



	}



	function calculations(expr:String):Dynamic {
        var interp = new Interp();
        try {
			var parser = new hscript.Parser();
			var ast = parser.parseString(expr);
			var interp = new hscript.Interp();
			return interp.execute(ast);
        } catch (e:Dynamic) {
            trace("Invalid calculation: " + expr);
            return null;
        }
    }

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
