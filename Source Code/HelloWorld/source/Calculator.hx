// it was all useless after all
class Calculator {
    var a:Float;
    var b:Float;
    public function new(a, b) {
        this.a = a;
        this.b = b;
    }

    public function add(a:Float, b:Float):Float {
        return a + b;
    }

    public function subtract(a:Float, b:Float):Float {
        return a - b;
    }

    public function multiply(a:Float, b:Float):Float {
        return a * b;
    }

    public function divide(a:Float, b:Float):Float {
        if (b == 0) {
            throw "Division by zero is not allowed.";
        }
        return a / b;
    }
}