package com.cover.display 
{
	/**
	* ...
	* @author Ivancho[©]
	*/
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	
	import com.cover.events.CoverEvent;
	
	public class Buttons extends MovieClip
	{
		///---------------------------------
		//  STATIC 
		//----------------------------------
			
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
			
		//----------------------------------
		//  VARAIBLES
		//----------------------------------
		
		private var _buttons:MovieClip;
		private var _coverEvent:CoverEvent;
			
		//----------------------------------
		//  STATIC METHODS
		//----------------------------------
			
		//----------------------------------
		//  CONSTRUCTOR
		//----------------------------------		
			
		public function Buttons() 
		{			
			if (stage) add();
			else addEventListener(Event.ADDED_TO_STAGE, add);
		}
		
		//----------------------------------
		//  PRIVATE METHODS
		//----------------------------------
		
		/**
		 * @param null
		 * @return	
		*/	
		
		private function add(event:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, add);
			onInit();
		}
		
		/**
		 * @param null
		 * @return	
		*/	
		
		private function onInit():void
		{
			_buttons = new Control();
			_buttons.x = ((stage.stageWidth / 2));
			_buttons.y = ((stage.stageHeight / 2) + 150);
			
			_buttons.mcPublish.buttonMode = true;
			_buttons.mcPublish.mouseChildren = false;
			_buttons.mcPublish.addEventListener(MouseEvent.CLICK, actionButton);
			
			_buttons.mcReload.buttonMode = true;
			_buttons.mcReload.mouseChildren = false;
			_buttons.mcReload.addEventListener(MouseEvent.CLICK, actionButton);			
			
			addChild(_buttons);
		}
			
		//----------------------------------
		//  PUBLIC METHODS
		//----------------------------------
		
		//-----------------------------------
		//  EVENT HANDLERS
		//-----------------------------------
		
		private function actionButton(event:MouseEvent):void
		{
			_coverEvent = new CoverEvent(CoverEvent.SAVE_COVER, '');
			dispatchEvent(_coverEvent);
			
			return;		
		}//end function
			
		//-----------------------------------
		//  PROPERTIES (Getters/Setters)
		//-----------------------------------
		
	}

}