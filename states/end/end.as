package states.end
{
	import auxilio.Carregarswf;
	import auxilio.Dados;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.utils.setInterval;
	

	public class end extends MovieClip
	{
		var cena:MovieClip;
		var cenaconfig:MovieClip = new MovieClip;
		var carregar:Carregarswf = new Carregarswf;
		var lista:Array = new Array;
		var listaPC:Array = new Array;
		var xPlayer,yPlayer,xPC,yPC,xInicial,yInicial:int;
		
		public function end()
		{
			
		}
		
		// Procurar uma forma posteriormente para que essas 3 funcoes fiquem outro lugar.. por que todas as classes tem elas .
		public function carregarCena(){
			var swf = carregar.carregar('end');
			swf.contentLoaderInfo.addEventListener(Event.COMPLETE, loadAction);
			return swf;
		}
		public function loadAction(evt:Event){
			this.cena = evt.target.content;
			this.cena.nome_presente.text = Dados.getNome();
			this.setPositions();
			//Inicializar prensente;
			this.Presentes();
		}
		public function setPositions(){
			this.xPlayer = this.cena.nome_presente.x;
			this.yPlayer = this.cena.nome_presente.y;
			
			this.xPC = this.cena.nome_adv.x;
			this.yPC = this.cena.nome_adv.y;
		}
		public function mudarCena(evt:Event){
			//Mudar de cena;
			screen.mudarState();
		}
		//Função para os presentes.
		public function Presentes(){
			//Array com todos o MovieClip de presentes;
			var pacotes:Array = [this.cena.mc_presente1,this.cena.mc_presente2,this.cena.mc_presente3,this.cena.mc_presente4
				,this.cena.mc_presente5,this.cena.mc_presente6,this.cena.mc_presente7,this.cena.mc_presente8,this.cena.mc_presente9
				,this.cena.mc_presente10];
			
			//Pecorrer array simples de objetos de presentes;
			for (var i:String in pacotes) {
				//Colocar a mãozinha do presente
				pacotes[i].buttonMode = true;
				//Mover objeto
				pacotes[i].addEventListener(MouseEvent.MOUSE_DOWN, puxar);
				//Solvar Objeto
				pacotes[i].addEventListener(MouseEvent.MOUSE_UP, soltar);
			}
		}
		//Função para mover o objeto.
		public function puxar(evento:MouseEvent):void{
			//Recebe o objeto do evento
			var mc = evento.currentTarget;	
			
			this.xInicial = mc.x;
			this.yInicial = mc.y;
			//O faz mover.
			mc.startDrag();
		}
		
		//Função para quando o objeto for solto sobre o nome.
		public function soltar(evento:MouseEvent):void{
		
			//Variavel com o objeto que vou feito o evento.
			var mc = evento.currentTarget;
			//Então eu posso manipulado, por exemplo mc.x = 20; mc.y =20;
			
			//os outros objetos da tela... serão chamados atrasves de
			//this.cena.OBJETO ( Essa objeto cena foi criado ali em 'loadAction'
			//Então podemos usar this.cena.mc_presente10.x = 20; mudando só o valor 10 para o numero do objeto (1,2,3,...)
			if ((mc.x <= this.cena.nome_presente.x + 190))
			{
				if (mc.y >= this.cena.nome_presente.y - 1130)
				{
					//O que deve acontecer quando objeto estiver sobre o nome.
					mc.stopDrag();
					this.organizarPlayer(mc);
				}
				else
				{
					mc.stopDrag();
					mc.x = this.xInicial;
					mc.y = this.yInicial;
				}
			}
			else
			{
				if (mc.x >= 300 && mc.y >= this.cena.nome_adv.y - 1130)
				{
					mc.stopDrag();
					this.organizarPC(mc);
				}
				else
				{
					mc.stopDrag();
					mc.x = this.xInicial;
					mc.y = this.yInicial;
				}
			}
		}
		
		//Organizar presentes.
		private function organizarPlayer(mc:MovieClip){
			
			//If para a primeira inserção na lista.
			if(this.lista.length == 0){ 
				//Inserir em uma array o elemento movido.
				this.lista.push(mc); 
				this.lista[0].x = this.xPlayer + 80;
				this.lista[0].y =  this.yPlayer - 50;
			}
			//Se não for a primeira.
			else {
				//Verificar se ja existe o elemento na lista.
				for (var A = 0 ; A < this.lista.length ; A ++ ){ 
					if ( mc.name == this.lista[A].name ) {
						//Se existir o presente na lista ele será apagado.
						this.lista.splice(A,1);
					}
				}
				for (var B = 0 ; B < this.listaPC.length ; B ++ ){ 
					if ( mc.name == this.listaPC[B].name ) {
						//Se existir o presente na lista ele será apagado.
						this.listaPC.splice(B,1);
					}
				}
				//Adicionar presente a lista.
				this.lista.push(mc);
				//Adicionar posição dos presentes.
				this.organizar();
			}	
		}
		
		//Organizar presentes.
		private function organizarPC(mc:MovieClip){			
			//If para a primeira inserção na lista.
			if(this.listaPC.length == 0){ 
				//Inserir em uma array o elemento movido.
				this.listaPC.push(mc); 
				this.listaPC[0].x = this.xPC + 50;
				this.listaPC[0].y =  this.yPlayer - 50;
			}
				//Se não for a primeira.
			else {
				//Verificar se ja existe o elemento na lista.
				for (var A = 0 ; A < this.listaPC.length ; A ++ ){ 
					if ( mc.name == this.listaPC[A].name ) {
						//Se existir o presente na lista ele será apagado.
						this.listaPC.splice(A,1);
					}
				}
				for (var B = 0 ; B < this.lista.length ; B ++ ){ 
					if ( mc.name == this.lista[B].name ) {
						//Se existir o presente na lista ele será apagado.
						this.lista.splice(B,1);
					}
				}
				//Adicionar presente a lista.
				this.listaPC.push(mc);
				//Adicionar posição dos presentes.
				this.organizar();
			}	
		}
		
		public function organizar(){
			//Adicionar posição dos presentes do Player.
			for ( var i:String in this.listaPC ){	
				this.listaPC[i].x = this.xPC + 50;
				this.listaPC[i].y = ( this.yPC - ( 50 * (int(i) + 1)));
			}
			//Adicionar posição dos presentes do PC
			for ( var x:String in this.lista ){	
				this.lista[x].x = this.xPlayer + 80;
				this.lista[x].y = ( this.yPlayer - ( 50 * (int(x) + 1)));
			}
		}

	}
}