package auxilio
{	
	public class Dados
	{
		private static var NOME
		private static var APELIDO;
		private static var SEXO;
		private static var IDADE;
		
		public function Dados()
		{
		}
		
		public static function setNome(nome:String){
			NOME = nome;
		}
		public static function getNome(){
			return NOME;
		}
		public static function setApelido(apelido:String){
			APELIDO = apelido;
		}
		public static function setSexo(sexo:String){
			SEXO = sexo;
		}
		
		public static function GetAll(){
		}
	}
}