package com.cover.events
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ivancho [®]
	 * @version 1.0
	 */
	
	
	public class FileEvent extends Event
	{
		public var data:*;
		
		/**
		* @constants
		**/			
		
		public static const FILE_LOAD:String = "fileLoad";
		public static const FILE_UNLOAD:String = "fileUnload";		
		
		public static const IMAGE_SAVE:String = "imageSave";		
		
		public function FileEvent(type:String, _data:*, bubbles:Boolean=false, cancelable:Boolean=false)
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
			return formatToString("FileEvent", "type", "data", "bubbles", "cancelable", "eventPhase"); 
		}// end function	
	}
}