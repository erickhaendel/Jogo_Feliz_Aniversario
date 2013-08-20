package states.config {
	
	import auxilio.Carregarswf;
	import auxilio.Dados;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	
	
	public class config extends MovieClip {
		
		var cena:MovieClip;
		var cenaconfig:MovieClip = new MovieClip;
		var carregar:Carregarswf = new Carregarswf;
		
		public function config() {

		}
		
		
		// Procurar uma forma posteriormente para que essas 3 funcoes fiquem outro lugar.. por que todas as classes tem elas .
		public function carregarCena(){
			var swf = carregar.carregar('config');
			swf.contentLoaderInfo.addEventListener(Event.COMPLETE, loadAction);
			return swf;
		}
		public function loadAction(evt:Event){
			this.cena = evt.target.content;
			this.cena.btnJogar.addEventListener(MouseEvent.CLICK, mudarCena);
		}
		public function mudarCena(evt:Event){
			//Salvar o nome do jogador
			Dados.setNome(this.cena.input_nome.nome.text);
			//Gravar nome no cursor;
			this.cena.cursor.alpha = 0;
			//Mudar de cena;
			
			screen.mudarState();
			
		}
		
		
	}
	
}
