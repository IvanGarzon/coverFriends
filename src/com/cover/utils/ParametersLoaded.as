package com.leoburnett.barza.utils
{
	import flash.display.*;
	import flash.events.*;
	
	/**
	 * ...
	 * @author Ivancho [®]
	 * @version 1.0
	 */
	
	public class ParametersLoaded
	{
			
		public static function ParamLoaded(mainStage:MovieClip):String
		{			
			var _unicode:String = '';
			var _referer:String = '';
			var _paramObj:Object;
			
			try 
			{
				_paramObj = new Object();
				_paramObj = LoaderInfo(mainStage.root.loaderInfo).parameters;
					
				_unicode = _paramObj["id"];
				_referer = _paramObj["re"];			
				
			}
			catch (error:Error)
			{
				trace("error al cargar los parametros");
			}				
			_unicode = (_unicode != null)?_unicode:'';			
			return _unicode;		
			
		}	
	}	
}