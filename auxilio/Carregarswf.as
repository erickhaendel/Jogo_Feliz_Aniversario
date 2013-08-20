package auxilio
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLRequest;

	public class Carregarswf
	{
		private static var cenas:Array =  new Array("home","config");
		private static var i:int = 0;
		private static var STATE:String = new String;
		
		public function Carregarswf()
		{			
		}
		
		public function carregar(swf:String){
			
			var carregar:Loader = new Loader();
			var endereco:URLRequest= new URLRequest();
			endereco.url = "states/"+swf+"/"+swf+".swf";
			carregar.load(endereco);
			carregar.x = 0;
			return(carregar);
			
		}
		
	}
}