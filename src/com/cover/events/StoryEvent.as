package com.submarinos.events
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ivancho [®]
	 * @version 1.0
	 */
	
	
	public class StoryEvent extends Event
	{
		public var data:*;
		
		/**
		* @constants
		**/			
		
		public static const LOAD_STORY:String = "loadStoryResult";		
		public static const SAVE_STORY:String = "saveStoryResult";		
		
		public function StoryEvent(type:String, _data:*, bubbles:Boolean=false, cancelable:Boolean=false)
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
			return formatToString("StoryEvent", "type", "data", "bubbles", "cancelable", "eventPhase"); 
		}// end function	
	}
}