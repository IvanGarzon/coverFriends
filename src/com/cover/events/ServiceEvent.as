package com.cover.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ivancho [®]
	 * @version 1.0
	 */
	
	public class ServiceEvent extends Event
	{
		
		public var data:*;		

		/**
		* CONSTANTS
		**/
		
		// STATIC CONST FRIENDS
		public static const LOAD_FRIENDS_PIC:String = "loadFriensPicResult";		
		public static const GET_ID_ALBUM:String = "getIdAlbumResult";		
		
		public function ServiceEvent(type:String, _data:* = null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			data = _data;			
		} 
		
		public override function clone():Event 
		{ 
			return new ServiceEvent(type, data, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("CommEvent", "type", "data", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}