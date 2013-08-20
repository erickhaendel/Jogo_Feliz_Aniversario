package states.home {
	
	import auxilio.Carregarswf;
	import auxilio.MouseCursor;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;

	
	public class home extends MovieClip {
		
		var cena:MovieClip;
		var mouse:MouseCursor = new MouseCursor;
		var cenahome:MovieClip = new MovieClip;
		var carregar:Carregarswf = new Carregarswf;
		
		public function home() {
			
		}
		
		// Procurar uma forma posteriormente para que essas 3 funcoes fiquem outro lugar.. por que todas as classes tem elas .
		public function carregarCena(){
			var swf = carregar.carregar('home');
			swf.contentLoaderInfo.addEventListener(Event.COMPLETE, loadAction);
			return swf;
		}
		public function loadAction(evt:Event){
			cena = evt.target.content;
			cena.home.btnProfessor.addEventListener(MouseEvent.CLICK, mudarCena);
		}
		public function mudarCena(evt:Event){
			screen.mudarState();
		}
		
		
	}
	
}
