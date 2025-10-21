package;

import flixel.FlxState;
// import flixel.ui.FlxButton;
import flixel.addons.ui.FlxInputText;
import flixel.addons.ui.FlxButtonPlus;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.FlxG;
import hscript.Interp;
import flixel.FlxSprite;

import Calculator;

class PlayState extends FlxState
{ 
	// variables
	var buttonGroup:FlxGroup = new FlxGroup();
	var MAX_PER_ROW:Int = 4;

	override public function create()
	{
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
			var button = new FlxButtonPlus(0, 0, () -> {
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
			}
				
			}, Std.string(i), 50, 50);
				
			// Align buttons in the grid
			button.x = FlxG.width / 2 + 100 * ((buttonGroup.members.length % MAX_PER_ROW) - MAX_PER_ROW/2) + button.width /2;
			button.y = Math.floor(buttonGroup.members.length / MAX_PER_ROW) * 100;
			// Center Text
			button.textNormal.alignment = FlxTextAlign.CENTER;
			button.textHighlight.alignment = FlxTextAlign.CENTER;
			// Vertical centering of text
			button.textNormal.y = button.y + (button.height - button.textNormal.height) / 2;
			button.textHighlight.y = button.y + (button.height - button.textHighlight.height) / 2;
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
