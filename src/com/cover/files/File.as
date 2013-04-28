////////////////////////////////////////////////////////////////////////////////
//																			  //
//  Ivan Garzón Cruz														  //
//  ivangarzoncruz@gmail.com												  //
//  Copyright 2011															  //	
//  All Rights Reserved ©.													  //
//																			  //
////////////////////////////////////////////////////////////////////////////////

package com.submarinos.files 
{
	import com.adobe.images.JPGEncoder;
	import com.submarinos.events.FileEvent;
	import flash.display.DisplayObject;
	
	import flash.display.MovieClip;	
	import flash.display.Sprite; 
	import flash.net.FileReference;
	import flash.net.FileFilter;
	import flash.events.IOErrorEvent;
	import flash.events.Event;
	import flash.utils.ByteArray;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	
	
	/**
	 * ...
	 * @author Ivancho [®]
	 * 
	 */
	
	public class File extends Sprite
	{
		//--------------------------------------
		//  VARIABLES
		//--------------------------------------
		
		private var loadFileRef:FileReference;
		
		//--------------------------------------
		//  CONSTANTS
		//--------------------------------------
		
		private static const FILE_TYPES:Array = [new FileFilter("Image Files", "*.jpg;*.jpeg;*.gif;*.png;*.JPG;*.JPEG;*.GIF;*.PNG")];
		private static const THUMB_WIDTH:uint = 240;
		private static const THUMB_HEIGHT:uint = 180;
		
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
		
		public function File() 
		{
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			//onInit();
		}// end function	
		
		
		//---------------------------------------
		// PRIVATE METHODS
		//---------------------------------------	
		
		/**
		 * @param null
		 * @return void
		 */	
		
		private function addedToStageHandler(event:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			onInit();
				
		}// end function
		
		/**
		 * @param null
		 * @return void
		 */	  
		
		private function onInit(event:Event = null):void
		{
			//trace('onInit Registro');			
		}// end function 
		
		
		public function loadFile():void 
		{
			loadFileRef = new FileReference();
			loadFileRef.addEventListener(Event.SELECT, selectHandler);
			loadFileRef.browse(FILE_TYPES);
		}
 
		private function selectHandler(event:Event):void
		{
			loadFileRef.removeEventListener(Event.SELECT, selectHandler);
			loadFileRef.addEventListener(Event.COMPLETE, loadCompleteHandler);
			loadFileRef.load();
		}
 
		private function loadCompleteHandler(e:Event):void
		{
			loadFileRef.removeEventListener(Event.COMPLETE, loadCompleteHandler);	
			
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadBytesHandler);
			loader.loadBytes(loadFileRef.data);
			loadFileRef = null;			
		}
		
		private function loadBytesHandler(event:Event):void
		{
			var loaderInfo:LoaderInfo = event.target as LoaderInfo;
			loaderInfo.removeEventListener(Event.COMPLETE, loadBytesHandler);
			
			var target:Bitmap;
			target = loaderInfo.content as Bitmap;
			
			dispatchEvent(new FileEvent(FileEvent.FILE_LOAD, target));
		}
 	}

}