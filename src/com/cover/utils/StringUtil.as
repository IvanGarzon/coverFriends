package com.submarinos.utils
{
	/**
	 * ...
	 * @author Ivancho [®]
	 * @version 1.0
	 */
	
	public class StringUtil 
	{
		
		public static function trim(str:String):String 
		{
			return str.replace(/^\s*(.*?)\s*$/g, "$1");   
		}
	  
		public static  function isEmail(string:String):Boolean	
		{
			var regExp:RegExp = /^([\w\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
			var result:Array = regExp.exec(string);		
			if (!regExp.test(string)) 
			{				
				return false;
			} else if (result.index != 0) 
			{
				return false;
			} else if ( ( String(result[0]).length != string.length ) )
			{
				return false;
			} else {
				return true;
			}			
			return true;
		}
	  
		public static  function isTelephone(string:String):Boolean
		{
			var regExp:RegExp = /(\d{5,9})/;
			var result:Array = regExp.exec(string);		
			if (!regExp.test(string)) {				
				return false;
			} else if (result.index != 0) {
				return false;
			} else if ( ( String(result[0]).length != string.length ) ) {
				return false;
			} else {
				return true;
			}			
		}
		
		/*
		 * Función que determina si una fecha ingresada por día y mes es válida
		*/
		
		public static function isDate(day:int, month:int):Boolean
		{
			var isDa:Boolean = true;
			
			if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12) {
				if (day < 1 || day > 31) {
					isDa = false;
				}
			} else if (month == 4 || month == 6 || month == 9 || month == 11) {
				if (day < 1 || day > 30) {
					isDa = false;
				}
			} else if (month == 2) {
				if (day < 1 || day > 28) {
					isDa = false;
				}
			} else {
				isDa = false;
			}
			
			return isDa;
		}
		
		public static function comprobarMayor(num:Number, nac:Date, hoy:Date):Boolean
		{
			var pasadoCumple = ((nac.getMonth() < hoy.getMonth()) || ((nac.getMonth() == hoy.getMonth()) && (nac.getDate ()  <= hoy.getDate () )))
			var años = pasadoCumple?(hoy.getFullYear() - nac.getFullYear()):(hoy.getFullYear() - nac.getFullYear() - 1);
				
			var valDate:Boolean = (num < años);
			trace(valDate);
				
			return valDate;
		}
		
		public static function checkDate(fecha:String):Boolean
		{
				
			var bandera:Boolean = false;
			var cont:Number = 0;
			var days:Number = 0;
			var month:Number = 0;
			var year:Number = 0;
			var bits:Array = new Array();

			bits = fecha.split("-");
			days = Number(bits[2]);
			month = Number(bits[1]);
			year = Number(bits[0]) * 1;
			
			var _days:Number = 0;
			
			trace('fecha: ' + fecha);
			trace('days: ' + days)
			trace('month: ' + month)
			trace('year: ' + year)

			if (days > 0 && days <= 31 && days != 0)
			{
				trace('days');
				_days = days;
				cont++;
			}
			if (month > 0 && month <= 12 && month != 0)
			{
				
				trace('month');
				
				if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12) 
				{
					trace('month1');
					
					if (_days > 31 && _days < 1)
					{
						trace('month11');
						cont++;
					}
				} else if (month == 4 || month == 6 || month == 9 || month == 11) 
				{
					if (days < 1 || days > 30)
					{
						trace('month2');
						cont++;
					}						
				} else if (month == 2)
				{
					if (days < 1 || days > 28) 
					{
						trace('month3');
						cont++;
					}
				}				
			}
			if (year > 1900 && year <= 9999 && year != 0)
			{
				trace('year');
				cont++;
			}
			if (fecha.length >= 8 && fecha.length <= 10)
			{
				trace('fecha');
				cont++;
			}

			if (cont >= 4) {
				bandera = true;
			}
			
			
			trace('cont: ' + cont)
			
			return bandera;
		}
					
		/**
		 * Convierte un objeto
		 * @param	obj	Objeto a convertir
		 * @return	String	Objeto convertido a una cadena de texto
		 */

		public static function objectToString(obj:Object):String
		{
			var sResponse:String = "";
			var space:String = "";
			for ( var param in obj ){
			   sResponse += space + param + ": " + obj[param];
			   space = " | ";
			}
			
			return sResponse;
		}

		/**
		 * Verifica que solo existan numeros en el campo de texto 
		 * @param cadena	Campo de texto
		 * @param numMenor	Min length
		 * @param numMayor	Max length
		 * @return Booleano
		 * 
		 */
		public static function soloNumeros(cadena:String, numMenor:Number, numMayor:Number):Boolean
		{			
			var compara:String = "0123456789";	
			var bandera = true;
			var i:Number = 0;
			var bits:Array = new Array();
			
			bits = cadena.split("");	
			
			//trace(bits +  " " + bits.length);
			for( i=0; i<bits.length; i++) 	{
				if( compara.lastIndexOf(bits[i]+"") < 0 ){ bandera = false }
				//trace(bits[i]);		
			}
			
			//Si son diferentes de cero, use los valores menor y mayor (para telefonos) 
			if (numMenor > 0 || numMayor > 0) {
				if ( cadena.length < numMenor || cadena.length > numMayor ) bandera = false;
			}
			
			return bandera
		}
		
		/**
		 * Verifica que solo existan numeros en el campo de texto 
		 * @param cadena	Campo de texto
		 * @param numMenor	Min length
		 * @param numMayor	Max length
		 * @return Booleano
		 * 
		 */
		
		public static function findValue(_baseArray:Array, _findString:String):String
		{			
			var baseArray:Array = _baseArray;
			var findString:String = _findString;
			
			var $result = new String();
			
			for ( var i:uint = 0; i < baseArray.length; i++ )
			{
				if( baseArray[i] == findString )
				{
					$result = i;
					break;
				}
			}		
			
			return $result
		}
		
		public static function nameFile(format:String):String
		{
			var myDate:Date = new Date();			
			var day:String = String(myDate.day);
			var month:String = String(myDate.month);
			var hours:String = String(myDate.hours);
			var minutes:String = String(myDate.minutes);
			var seconds:String = String(myDate.seconds);
			
			var fecha:String = day + month + hours + minutes + seconds;
			var aleatorio:Number = Math.floor(Math.random() * (1000000000 - 1 + 1)) + 1; 
			
			var nameFile:String = fecha + '_' + aleatorio + '.' + format;	
			
			//trace('NAME FILE :: ' + nameFile);			
			return nameFile;			
		}// end function

		
	}

}