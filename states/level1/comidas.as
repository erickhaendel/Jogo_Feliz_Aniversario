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

	public class comidas
	{
		public static var LISTA_COMIDAS:Array = new Array;
		public var comidas_prontas:Array =  new Array
		public var parte_comidas:Array =  new Array;
		public var parte_comidasNaesteira:Array =  new Array;
		public var parte_comidas_preto:Array =  new Array;
		public var desafio:MovieClip =  new MovieClip;
		public var comida_desafio:MovieClip = new MovieClip;
		public var cena:MovieClip = new MovieClip;
		public var pos_comida_array =  new int;
		public static var DISTANCIA_Y = 0;
		public static var DISTANCIA_X = 0;
		public static var I = 0;
		public static var POS:int = new int;
		public static var ELEMENTO:MovieClip = new MovieClip;
		public var myTweenX:Tween;
		public var elem:elemento;
		public var NumPos: Array =  new Array ( 0 , 1 , 2 );
		public var intervalo:uint;
		public var comidasNaEsteira:Array =  new Array ();  
		public var partesDisponiveis:Array =  new Array ("00","01","02","10","11","12","20","21","22","30","31","32","40","41","42");
		public var contadorComidaSombra = 0;
		public var tempo:cronometro =  new cronometro;
		//Construtor
		public function comidas()
		{
		}
		
		public function criar(recebe:MovieClip){
			this.cena =  recebe;
			this.tempo.start();
			//Pegando as coordenadas da esteira para ser usadas para as partes das comidas.
			DISTANCIA_Y = this.cena.esteira.y - 30;
			DISTANCIA_X = this.cena.esteira.x;
			
			//Comidas que serão usadas para desafio.
			this.comidas_prontas 		=  [recebe.pirulito, recebe.brigadeiro, recebe.sorvete, recebe.hotdog,recebe.bemcasado];
			
			//Sobra das comidas, 3 sombras para cada comida.
			this.parte_comidas_preto 	=  [[recebe.pirulito_1_preto, recebe.pirulito_2_preto, recebe.pirulito_3_preto],
											[recebe.brigadeiro_1_preto,recebe.brigadeiro_2_preto,recebe.brigadeiro_3_preto],
											[recebe.sorvete_1_preto,recebe.sorvete_2_preto,recebe.sorvete_3_preto],
											[recebe.hotdog_1_preto,recebe.hotdog_2_preto,recebe.hotdog_3_preto],
											[recebe.bemcasado_1_preto,recebe.bemcasado_2_preto,recebe.bemcasado_3_preto]]	
			//Parte das comidas, no total são 3 para cada comida.
			this.parte_comidas 			= [	[recebe.pirulito_1, recebe.pirulito_2, recebe.pirulito_3],
											[recebe.brigadeiro_1,recebe.brigadeiro_2,recebe.brigadeiro_3],
											[recebe.sorvete_1,recebe.sorvete_2,recebe.sorvete_3],
											[recebe.hotdog_1,recebe.hotdog_2,recebe.hotdog_3],
											[recebe.bemcasado_1,recebe.bemcasado_2,recebe.bemcasado_3]]
				
			//Quadro de desafio.	
			this.desafio =  recebe.desafio;
			//Começar os desafios.
			this.Mostrardesafio();
		}
		/* Mostrar comida que será escolhida para ser construido*/
		public function Mostrardesafio():void{
			//Escolher comida do desafio.
			this.comida_desafio = randComidaPronta();
			//Posicionar em x e y em relação ao quadro de amostra.
			this.comida_desafio.x = this.desafio.x;
			this.comida_desafio.y = this.desafio.y + 10;
			//Mostrar sombra das partes a serem construidas.
			this.mostrarSombra(this.parte_comidas_preto[this.pos_comida_array]);
			//Repetir função de alimentos na esteira a cada tempo
			this.moverNaEsteira();
			this.intervalo = setInterval(this.moverNaEsteira,1000);
			
			
		}
		
		// Radomizar a escolhe do elemento para ser contruido, retornado o elemento.
		public function randComidaPronta():MovieClip
		{
			var minNum =  0;
			var maxNum = (this.comidas_prontas.length) - 1;
			//Posição da array, escolhido randomicamente.
			//this.pos_comida_array = (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
			this.pos_comida_array = 0;
			return this.comidas_prontas[pos_comida_array];
		}
		//Retornar um numero randomico de 0 a 2 para a substring das partes dos alimentos.
		public function rand():int{
			var minNum =  0;
			var maxNum = (this.NumPos.length) - 1;
			//Posição da array, escolhido randomicamente.
			var pos = (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
			var parteAlimento = this.NumPos[pos];	
			return parteAlimento;
		}
		//Mostrar sombra 
		public function mostrarSombra(sombras:Array):void{
			for (var i = 0 ; i < 3 ; i ++ ){
				sombras[i].x = 350 + ( i * 130);
				sombras[i].y = 90 ;
				sombras[i].alpha = 0.6;
			} 		
		}
		//Tirar as sombras do box.
		public function resetarSombra(): void {
			var sombras = this.parte_comidas_preto[this.pos_comida_array +this.contadorComidaSombra];
			for (var i = 0 ; i < 3 ; i ++ ){
				sombras[i].x = -200;
			} 
		}
		
		//Mover alimentos na esteira.
		public function moverNaEsteira():void{
			//Verificar se o primeiro elemento já foi colocando no seu lugar, se foi.. ele exclui da array de posição.
			var parte1 = null;
			var parte2 = null;
			var parte3 = null;
						
			
			var tempo = this.tempo.getElapsed();
			trace(tempo);
			trace('--');
			this.cena.tempo_jogo.text = tempo;
			trace(this.cena.tempo_jogo.text ) ;
			
			if ( elemento.CONTAGEM_1 ) {
					parte1 = (this.pos_comida_array+this.contadorComidaSombra).toString() + "0";
					excluiDaLista(parte1, this.partesDisponiveis);
					excluiDaLista(parte1, this.comidasNaEsteira);
				//	trace("EXCLUIU DOS DOIS "+parte1);
				/*	for(var a=0; a<this.NumPos.length; a++){
						if ( this.NumPos[a] == 0 ) {
							this.NumPos.splice(a,1);
						}
					} */
			}
			if (elemento.CONTAGEM_2) {
				parte2 = (this.pos_comida_array+this.contadorComidaSombra).toString() + "1";
				excluiDaLista(parte2, this.partesDisponiveis);	
				excluiDaLista(parte2, this.comidasNaEsteira);
			//	trace("EXCLUIU DOS DOIS "+parte2);				
			/*	for(var b=0; b<this.NumPos.length; b++){
					if ( this.NumPos[b] == 1 ) {
						this.NumPos.splice(b,1);
					}
				}*/
			}
			if ( elemento.CONTAGEM_3 ) {
				parte3 = (this.pos_comida_array+this.contadorComidaSombra).toString() + "2";
				excluiDaLista(parte3, this.partesDisponiveis);	
				excluiDaLista(parte3, this.comidasNaEsteira);
			//	trace("EXCLUIU DOS DOIS "+parte3);	
			/*	for(var c=0; c<this.NumPos.length; c++){
					if ( this.NumPos[c] == 2 ) {
						this.NumPos.splice(c,1);
					}
				}*/
			}
			//Finaliza o desafio se todos estiverem prontos.
			if ( (elemento.CONTAGEM_1) && (elemento.CONTAGEM_2) && (elemento.CONTAGEM_3) ) {
				
	/*			trace("********COMIDAS PRONTAS INSERIDAS*******")
				trace(parte1);
				trace(parte2);
				trace(parte3);
	*/			this.partesDisponiveis.push(parte1);
				this.partesDisponiveis.push(parte2);
				this.partesDisponiveis.push(parte3);
				pronto();

			}
			else {
				
				var idParteComida = this.partesDisponiveis[Math.floor(Math.random() * this.partesDisponiveis.length)];
				var comida = int(idParteComida.substr(0,1));
				var parteDaComida = int(idParteComida.substr(1,1));
				
				//trace("((((((((((PROXIMA COMIDA))))))))))")
				//trace(idParteComida);

				this.elem =  new elemento(this.parte_comidas[comida][parteDaComida],DISTANCIA_X,DISTANCIA_Y);
				this.elem.set_elemento_preto(this.parte_comidas_preto[comida]);	
				
				if(this.comidasNaEsteira.length < 8 && this.comidasNaEsteira[6] == undefined){
				//	this.comidasNaEsteira.push(idParteComida);
				//	excluiDaLista(idParteComida, this.partesDisponiveis);
				
					this.comidasNaEsteira[6] = this.comidasNaEsteira[5];
					this.comidasNaEsteira[5] = this.comidasNaEsteira[4];
					this.comidasNaEsteira[4] = this.comidasNaEsteira[3];
					this.comidasNaEsteira[3] = this.comidasNaEsteira[2];
					this.comidasNaEsteira[2] = this.comidasNaEsteira[1];
					this.comidasNaEsteira[1] = this.comidasNaEsteira[0];
					this.comidasNaEsteira[0] = idParteComida;
					excluiDaLista(idParteComida, this.partesDisponiveis);
										
		/*			trace("00000000000000000000000");
					trace(this.comidasNaEsteira[6]);
					trace(this.comidasNaEsteira[5]);
					trace(this.comidasNaEsteira[4]);
					trace(this.comidasNaEsteira[3]);
					trace(this.comidasNaEsteira[2]);
					trace(this.comidasNaEsteira[1]);
					trace(this.comidasNaEsteira[0]); 
		*/		}
				//atualiza a lista das comidas na esteira
				else{
				//	trace("++++COMIDA INSERIDA DA EST. NAS CD++++");
				//	trace(this.comidasNaEsteira[6]);
					
					this.partesDisponiveis.push(this.comidasNaEsteira[6])
					this.comidasNaEsteira[6] = this.comidasNaEsteira[5];
					this.comidasNaEsteira[5] = this.comidasNaEsteira[4];
					this.comidasNaEsteira[4] = this.comidasNaEsteira[3];
					this.comidasNaEsteira[3] = this.comidasNaEsteira[2];
					this.comidasNaEsteira[2] = this.comidasNaEsteira[1];
					this.comidasNaEsteira[1] = this.comidasNaEsteira[0];
					this.comidasNaEsteira[0] = idParteComida;
					excluiDaLista(idParteComida, this.partesDisponiveis);
	/*				
					trace("++++COMIDAS NA ESTEIRA++++");
					trace(this.comidasNaEsteira[6]);
					trace(this.comidasNaEsteira[5]);
					trace(this.comidasNaEsteira[4]);
					trace(this.comidasNaEsteira[3]);
					trace(this.comidasNaEsteira[2]);
					trace(this.comidasNaEsteira[1]);
					trace(this.comidasNaEsteira[0]);
					
					trace("++++COMIDA EXCLUIDA DAS CD++++");
					trace(idParteComida);
					
					trace("++++COMIDAS DISPONIVEIS++++");
					
					for (var i:uint=0; i < this.partesDisponiveis.length; i++) {
						trace(this.partesDisponiveis[i]);
		    		}
	*/				

					}							
			}					
		}
		//Funçao que exclui parte da comida da lista de possibilidades
		function excluiDaLista(value:String, arr:Array):void {
		    for (var i:uint=0; i < arr.length; i++) {
		        if (arr[i]==value) {
		            arr.splice(i, 1);
		        }
		    }
		 }		
		//Funçao que tira a comida com as as partes e as sombras da área de montagem 
		function tiraDaFrente(arr:Array):void {
		    for (var i:uint=0; i < arr.length; i++) {
					arr[i].x = - 200;
		    }
		 }	

		//Quando a comida for feita por completo.
		public function pronto():void{
			//Setando as posições da comida para a mesa.
			this.comida_desafio.x =  350 + (POS * 100);
			this.comida_desafio.y = 350;
			POS ++;
			this.comida_desafio.width =  this.comida_desafio.width /2;
			this.comida_desafio.scaleY = this.comida_desafio.scaleX;    
			this.contadorComidaSombra =this.contadorComidaSombra+1;           
			this.resetar();
		}
		

		
		//Resetar desafio para um novo.
		private function resetar():void {
			this.NumPos = [0,1,2];
			elemento.CONTAGEM_1 = false;
			elemento.CONTAGEM_2 = false;
			elemento.CONTAGEM_3 = false;
			this.resetaPosicao();
			this.removeComidaFeita();
			if ( this.comidas_prontas.length != 0) {
				this.Mostrardesafio2();
			}
			else {
				clearInterval(this.intervalo);
				screen.mudarState();	
			}
		}
		
		//resetar a posição das partes da comida limpa e preta.
		private function resetaPosicao():void {
			for ( var i=0; i < (this.parte_comidas.length); i++) {
				for ( var a=0; a < this.parte_comidas[i].length; a ++ ) {
					//trace(i+","+a);
					this.parte_comidas_preto[i][a].x = -200;
					this.parte_comidas[i][a].x = -200;
				}
			}
		}
		
		private function removeComidaFeita():void {
			this.comidas_prontas.splice(this.pos_comida_array,1);
			//this.parte_comidas.splice(this.pos_comida_array,1);
			//this.parte_comidas_preto.splice(this.pos_comida_array,1);
			//this.comidas_prontas[this.pos_comida_array].x = -200;
			this.parte_comidas[this.pos_comida_array][0].y = -200;
			this.parte_comidas_preto[this.pos_comida_array][0].y = -200;
			this.parte_comidas[this.pos_comida_array][1].y = -200;
			this.parte_comidas_preto[this.pos_comida_array][1].y = -200;
			this.parte_comidas[this.pos_comida_array][2].y = -200;
			this.parte_comidas_preto[this.pos_comida_array][2].y = -200;
		}
		public function Mostrardesafio2():void{
			//Escolher comida do desafio.
			this.comida_desafio = this.comidas_prontas[this.pos_comida_array];
			//this.pos_comida_array = this.pos_comida_array +1;
			//Posicionar em x e y em relação ao quadro de amostra.
			this.comida_desafio.x = this.desafio.x;
			this.comida_desafio.y = this.desafio.y + 10;
			//Mostrar sombra das partes a serem construidas.
			this.mostrarSombra(this.parte_comidas_preto[this.pos_comida_array+this.contadorComidaSombra]);
		
		}
	/*	public function randComidaPronta2():MovieClip
		{

			this.pos_comida_array = this.pos_comida_array +1;
			return this.comidas_prontas[this.pos_comida_array];
		}	*/		
	}
}