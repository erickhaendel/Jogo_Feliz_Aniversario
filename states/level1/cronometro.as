package states.level1
{
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import fl.transitions.easing.*;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import flash.utils.getTimer;

public class cronometro {
    private var _mark:int;
    private var _started:Boolean = false;
	private	var min = 0;
	//Construtor
	public function cronometro()
	{
	}

    public function start():void { 
        _mark = getTimer(); 
        _started = true;
    }
    public function returnNumber(x:String):String {
		var num:String = "0";
		if (x == "0"){num = "0"};
		if (x == "1"){num = "1"};
		if (x == "2"){num = "2"};
		if (x == "3"){num = "3"};
		if (x == "4"){num = "4"};
		if (x == "5"){num = "5"};
		if (x == "6"){num = "6"};
		if (x == "7"){num = "7"};
		if (x == "8"){num = "8"};
		if (x == "9"){num = "9"};
		return num;
	}

    public function getElapsed():String { 
		var milisecInt = _started ? getTimer() - _mark : 0;
		var milisec = milisecInt.toString();
		var time = 0;
		var segundo:String = "00";
		if (milisec.length == 4){
			var sec = milisec.slice(0, 1);
			segundo = ("0"+sec);

        }
		if (milisec.length == 5){
			sec = milisec.slice(0, 2);
			if (sec.slice(0, 1) == "6"){
				min = min + 1;
				this._started = false;
				this.start();
			}
			else{
			segundo = sec;
			}
		}
		var minuto = min.toString();
		var tempo = minuto.concat(":" , segundo);
		return tempo;
    }
}
}