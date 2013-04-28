package com.submarinos.core
{
	/**
	 * ...
	 * @author Ivancho [®]
	 * @version 1.0
	 */
	
	public class Singleton
	{
		private static var instance:Singleton = new Singleton();
			
		public var idType:Number;
		public var story:String = '';
		
		public function Singleton()
		{
			if(instance)
			{
				throw new Error ("We cannot create a new instance. Please use Singleton.getInstance()");
			}
		}
			
		public static function getInstance():Singleton
		{
			return instance;
		}
	}
}