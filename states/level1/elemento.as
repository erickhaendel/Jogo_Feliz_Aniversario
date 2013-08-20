package states.level1
{
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import fl.transitions.easing.*;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class elemento
	{
		public var ele_preto:Array 	=	new Array;
		public var obj:MovieClip 	=  	new MovieClip;
		public var distancia_x:int 	=  	new int;
		public var distancia_y:int 	=  	new int;
		public var x 				= 	new int;
		public var y				= 	new int;
		public var myTweenX:Tween;
		public static var CONTAGEM:int 			= new int;
		public static var CONTAGEM_1:Boolean 	= false;
		public static var CONTAGEM_2:Boolean 	= false;
		public static var CONTAGEM_3:Boolean 	= false;
		public var encaixou:Boolean 	= false;
		
		public function elemento(mc:MovieClip, x,y)
		{
			this.obj 			=  mc;
			this.obj.y 			=  y;
			this.distancia_x 	=  x;
		
			//Movimentar o alimento a esteira.
			this.moverNaEsteira();
		}
		//Adicionar as sombras dos alimentos para desafio.
		public function set_elemento_preto(array:Array){
			this.ele_preto =  array;
		}
		public function moverNaEsteira(){
			//Cria animaçao dos elmentos na esteira.
			this.myTweenX =  new Tween(this.obj, "x", None.easeIn, this.distancia_x , 1600, 15, true);
			//this.myTweenX.addEventListener(TweenEvent.MOTION_CHANGE, onFinish);
			//Eventos para o cursor mover os elementos
			this.obj.addEventListener(MouseEvent.MOUSE_DOWN, drag);
			this.obj.addEventListener(MouseEvent.MOUSE_UP, dragStop);
		}
		//Parar a animação.
		public function onFinish(e:TweenEvent):void{
			this.myTweenX.stop();
		}
		//Iniciar locomoção do objeto e da um stop na animação
		public function drag(evt:Event):void{
			if(this.encaixou){
				this.obj.stopDrag();
			}
			else{
				this.obj.startDrag();
				myTweenX.stop();				
			}
		}
		//Parar locomoção do objeto.
		public function dragStop(evt:Event){
			this.stopPosX(evt.target.x);
			this.stopPosY(evt.target.y);
			this.comparar(evt.target.name);
			if(this.encaixou){
				this.obj.stopDrag();
				//this.encaixou = false;
			}
			else{
				this.caindo();
			}			
		}
		//Comprar as posições do objeto que foi solto, com a da sombra do objeto.
		public function comparar(name:String){
			if (name.indexOf('1') != -1){
				if ((this.ele_preto[0].x >= this.x - 10) && (this.ele_preto[0].x < this.x + this.ele_preto[0].width)){
					if ((this.ele_preto[0].y >= this.y - 10) && (this.ele_preto[0].y < this.y + this.ele_preto[0].height)){
						CONTAGEM_1 = true;
						this.obj.x = this.ele_preto[0].x;
						this.obj.y = this.ele_preto[0].y;
						this.encaixou = true;
					}
				}				
			}
			else if (name.indexOf('2') != -1){
				if ((this.ele_preto[1].x >= this.x - 10) && (this.ele_preto[1].x < this.x + this.ele_preto[1].width)){
					if ((this.ele_preto[1].y >= this.y - 10) && (this.ele_preto[1].y < this.y + this.ele_preto[1].height)){
						CONTAGEM_2 = true;
						this.obj.x = this.ele_preto[1].x;
						this.obj.y = this.ele_preto[1].y;
						this.encaixou = true;
					}
				} 
			}
			else{
				if ((this.ele_preto[2].x >= this.x - 10) && (this.ele_preto[2].x < this.x + this.ele_preto[2].width)){
					if ((this.ele_preto[2].y >= this.y - 10) && (this.ele_preto[2].y < this.y + this.ele_preto[2].height)){
						CONTAGEM_3 = true;
						this.obj.x = this.ele_preto[2].x;
						this.obj.y = this.ele_preto[2].y;
						this.encaixou = true;
					}
				} 
			}
		}
		
		
		
		public function stopPosX(val:int):void{
			this.x = val;
		}
		public function caindo():void{
			this.obj.stopDrag();
			this.myTweenX =  new Tween(this.obj, "y", None.easeIn, this.obj.y , this.obj.y + 1200, 1, true);
		}		
		public function stopPosY(val:int):void{
			this.y = val;
		}
		
		public function resetaPosicao():void{
			this.obj.x = -200;
		}
	}
}