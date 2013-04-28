package com.cover.events
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ivancho [®]
	 * @version 1.0
	 */
	
	
	public class CoverEvent extends Event
	{
		public var data:*;
		
		/**
		* @constants
		**/			
		
		public static const SHOW_BUTTONS:String = "showButtonsResult";		
		public static const SAVE_IMAGE:String = "saveImageResult";		
		public static const SAVE_COVER:String = "saveCoverResult";		
		public static const RELOAD_COVER:String = "reloadCoverResult";		
		
		public function CoverEvent(type:String, _data:*, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.data = _data;
		}
		
		public override function clone():Event 
		{ 
			return new FileEvent(type, data, bubbles, cancelable);
		} // end function
			
		public override function toString():String 
		{ 
			return formatToString("CoverEvent", "type", "data", "bubbles", "cancelable", "eventPhase"); 
		}// end function	
	}
}