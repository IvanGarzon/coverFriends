//////////////////////////////////////////////////////////////////////////////////
//																				//
//  Ivan Garzón Cruz															//
//  Copyright 2011																//
//	ivangarzoncruz@gmail.com													//
//  @Lehenbizico																//	
//  All Rights Reserved.														//
//																				//
//////////////////////////////////////////////////////////////////////////////////

package 
{
	/**
	 * Class Name: Main
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 10.1
	 * @dateCreate 24/01/2012
	 * @author Ivancho[©]	 
	 */	
		
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;	
	import flash.external.ExternalInterface;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.utils.getDefinitionByName;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.Security;	
	import flash.utils.ByteArray;
	
	import com.cover.display.Container;
	import com.cover.display.Buttons;
	import com.cover.events.CoverEvent;
	import com.cover.images.SaveImage;
	
	import com.adobe.images.*;	
	import com.greensock.*;
	import com.greensock.easing.*;
	
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import fl.transitions.TweenEvent;	
	
	public class Main extends MovieClip 
	{
		//--------------------------------------
		//  VARIABLES
		//--------------------------------------
		
		private var Cover:Container;
		private var BarButtons:Buttons;
		
		private var _saveImage:SaveImage;
		private var _cover:MovieClip;
		
		private var loaderCover:Loader;
		private var container:MovieClip;
		private var picUser:Array;
		private var bitmapUser:Array;
		private var totalRows:int;
		private var totalCols:int;
		private var contPic:int;
		
		private var posX:int;
		private var posY:int;
		
		private var rows:int;
		private var columns:int;
		
		private var classRef:Class;
		private	var myObject:MovieClip;
		
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
		
		public function Main() 
		{
			if (stage) add();
			else addEventListener(Event.ADDED_TO_STAGE, add);
		}
		
		//---------------------------------------
		// PRIVATE METHODS
		//---------------------------------------
		
		private function add(event:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, add);
			onInit();
		}
		
		private function onInit():void
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			Cover = new Container();
			addChild(Cover);
			
			Cover.addEventListener(CoverEvent.SHOW_BUTTONS, showButtons);
			
			/*picUser = new Array();
			bitmapUser = new Array();
			
			container = new MovieClip();
					
			contPic = 0;
			posX = 5;
			posY = 5;
			
			totalRows = 850 / 50;
			totalCols = 350 / 50; 
			
			for (var i:uint = 0; i <= 25; i++)
			{
				if (i == 25)
				{
					loadFriendsPic(picUser);					
				}
				else
				{
					picUser.push('images/bordello.jpg');			
				}			
			}*/			
		}
		
		/*
		private function loadFriendsPic(value:Array):void
		{
			var my_thumb_width:int = 50;
			var my_thumb_height:int = 50;
			
			var x_counter:Number = 0;
			var y_counter:Number = 0;
			
			var columns:Number = 5;				
				
			for (var i:int = 0; i < value.length; i++) 
			{								
				var thumb_loader:Loader = new Loader();
				thumb_loader.load(new URLRequest(value[i]));
				thumb_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, thumbLoaded);

				thumb_loader.name = 'myLoader_ ' + i;

				thumb_loader.x = (my_thumb_width) * x_counter;
				thumb_loader.y = (my_thumb_height) * y_counter;

				if (x_counter + 1 < columns) 
				{
					x_counter++;
				}
				else
				{
					x_counter = 0;
					y_counter++;
				}
			}			
		}
		*/
		
		/*		
		private function thumbLoaded(e:Event):void 
		{
			var my_thumb:Loader = Loader(e.target.loader);		
			
			/*var classRef:Class;
			var myObject:MovieClip;				
			classRef = getDefinitionByName("FriendPic") as Class;
			myObject = new classRef();			
			myObject.mcPic.holder.addChild(my_thumb);*/
			
			/*container.addChild(my_thumb);
			contPic++;
			
			if (contPic == picUser.length)
			{
				trace('savePic');
				addChild(container);
				//savePic(container);
			}		
		}	
		*/
		
		/*
		function savePic(target:MovieClip):void
		{
			//ExternalInterface.call('alert', target.width + '   ' + target.height);
			//trace(target.width + '   ' + target.height);
			
			var mat:Matrix;		
			
			var bitmapData:BitmapData = new BitmapData(target.width, target.height, true, 0);
			mat = new Matrix(1, 0, 0, 1, -target.x, -target.y);
			bitmapData.draw(this, mat);
			
			var jpgEncoder:JPGEncoder = new JPGEncoder(100);
			var jpgStream:ByteArray = jpgEncoder.encode(bitmapData);			
			
			var header:URLRequestHeader = new URLRequestHeader ( "Content-type", "application/octet-stream" );						
			var jpgURLRequest:URLRequest = new URLRequest ( "php/jpg_encoder_download.php?name=" + 'imagen.jpg');	
			
			jpgURLRequest.requestHeaders.push(header);				
			jpgURLRequest.method = URLRequestMethod.POST;				
			jpgURLRequest.data = jpgStream;					
			
			var jpgURLLoader:URLLoader = new URLLoader();	
			jpgURLLoader.addEventListener(Event.COMPLETE, onComplete);
			jpgURLLoader.dataFormat = URLLoaderDataFormat.VARIABLES; 
			jpgURLLoader.load(jpgURLRequest);
			
			return;
		}//end of function
		*/
		
		//---------------------------------------
		// PUBLIC METHODS
		//---------------------------------------
		
		//---------------------------------------
		//  EVENT HANDLERS
		//---------------------------------------	
		
		private function showButtons(event:CoverEvent):void
		{
			_cover = event.data as MovieClip;
			
			BarButtons = new Buttons();
			addChild(BarButtons);			
			
			BarButtons.addEventListener(CoverEvent.SAVE_COVER, saveCover);
			
		}
		
		private function saveCover(event:CoverEvent):void
		{			
			_saveImage = new SaveImage();
			_saveImage.saveImage(_cover);
		}		
		
		//---------------------------------------
		//  GETTER/SETTERS
		//---------------------------------------
		
		
	}
}