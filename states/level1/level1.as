package states.level1 {
	
	import auxilio.Carregarswf;
	import auxilio.Dados;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.utils.setInterval;
	
	
	public class level1 extends MovieClip {
		
		var cena:MovieClip;
		var cenaconfig:MovieClip = new MovieClip;
		var carregar:Carregarswf = new Carregarswf;
		var elementos:comidas =  new comidas;
			
		public function level1() {
		}
		
		// Procurar uma forma posteriormente para que essas 3 funcoes fiquem outro lugar.. por que todas as classes tem elas .
		public function carregarCena(){
			var swf = carregar.carregar('level1');
			swf.contentLoaderInfo.addEventListener(Event.COMPLETE, loadAction);
			return swf;
		}
		public function loadAction(evt:Event){
			this.cena = evt.target.content;
			this.cena.cursor.alpha = 0;
			desafio();


			//addChild(evt.target.content);
			//this.cena.cursor.addEventListener(MouseEvent.CLICK, mudarCena);
		}
		public function mudarCena(evt:Event){
			screen.mudarState();			
		}
		
		//Inserção do elemento para a caixa de desafio.
		private function desafio(){
			elementos.criar(this.cena);

			
		}
		
		
	}
	
}
