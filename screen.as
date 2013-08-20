package
{
	import auxilio.Carregarswf;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.ui.Mouse;
	import flash.utils.setInterval;
	
	import states.config.config;
	import states.end.end;
	import states.home.home;
	import states.level1.level1;

	
	public class screen extends Sprite
	{
		private var cena:MovieClip;
		private var carregar:Carregarswf = new Carregarswf;
		
		private var cenahome:home =  new home;
		private var cenaconfig:config =  new config;
		//private var cenalevel1:level1 = new level1;
		private var cenafinal:end =  new end;
		
		private var swf:Loader = new Loader;
		
		public static var LEVEL = 1;
		public static var CURRENT_STAGE = 1;
		
		
		public function screen()
		{
			this.AbrirCena();
			Mouse.cursor = 'hand';
			//verificar se está no level current.
			setInterval(verificarLevel,100);
		}
		
		//melhorar essa função, mas no caso... para cada level criado vamos criar um if.
		public function AbrirCena() {
			this.removeChildren();
			if ( LEVEL == 1 ) {
				addChild(this.cenahome.carregarCena());
			}
			if( LEVEL == 2 ){
				addChild(this.cenaconfig.carregarCena());
			}
			if (LEVEL == 3 ) {
				var cenalevel1:level1 = new level1;
				addChild(cenalevel1.carregarCena());
			}
			if (LEVEL == 4 ) {
				
				addChild(this.cenafinal.carregarCena());
			}
		}
		
		public static function mudarState(){
			LEVEL ++;
		}
		//Verificando se o levl é o mesmo do current stage, para que possa mudar de level.
		public function verificarLevel(){
			if (LEVEL == CURRENT_STAGE ){
			}
			else {
				CURRENT_STAGE = LEVEL;
				this.AbrirCena();
			}
		}
		
	}
}