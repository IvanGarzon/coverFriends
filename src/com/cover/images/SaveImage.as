////////////////////////////////////////////////////////////////////////////////
//																			  //
//  Ivan Garzón Cruz														  //
//  ivangarzoncruz@gmail.com												  //
//  Copyright 2011															  //	
//  All Rights Reserved ©.													  //
//																			  //
////////////////////////////////////////////////////////////////////////////////

package com.cover.images 
{
	import com.adobe.images.JPGEncoder;
	import com.cover.events.CoverEvent;
		
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.external.ExternalInterface;
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
	import flash.net.FileReference;
	
	import com.greensock.*;
	import com.greensock.easing.*;

	
	/**
	 * ...
	 * @author Ivancho [®]
	 * 
	 */
	
	public class SaveImage extends MovieClip
	{
		//--------------------------------------
		//  VARIABLES
		//--------------------------------------
		
		private var imgBA:BitmapData;
		private var imgBitmap:Bitmap;
		private var saveHelper:FileReference;
		
		
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
		
		public function SaveImage() 
		{
			//addEventListener(CoverEvent.SAVE_IMAGE, saveImage);
			
		}// end function	
		
		
		//---------------------------------------
		// PRIVATE METHODS
		//---------------------------------------	
		
			
		
		private function onComplete(event:Event):void 
		{
			//trace(event.target.data.write);
			ExternalInterface.call('alert', event.target.data.write);
			//dispatchEvent(new FileEvent(FileEvent.IMAGE_SAVE, event.target.data.write));
		}
		
		//---------------------------------------
		// PUBLIC METHODS
		//---------------------------------------	
		
		/**
		 * @param null
		 * @return void
		 */	  
		
		public function createName():String
		{
			var myDate:Date = new Date();			
			var day:String = String(myDate.day);
			var month:String = String(myDate.month);
			var hours:String = String(myDate.hours);
			var minutes:String = String(myDate.minutes);
			var seconds:String = String(myDate.seconds);
			
			var fecha:String = day + month + hours + minutes + seconds;
			var aleatorio:Number = Math.floor(Math.random() * (100000 - 1 + 1)) + 1; 			
			var nameFile:String = 'cover_' + fecha + '_' + aleatorio + ".jpg";	
			
			return nameFile;			
		}
		
		/**
		 * @param Event
		 * @return void
		 */	  
		
		/**
		 * @param null
		 * @return void
		 */	
		
		//public function saveImage(event:CoverEvent):void 
		public function saveImage(target:MovieClip):void 
		{
			/*saveHelper = new FileReference();
			
			var bitmapData:BitmapData;		
			var mat:Matrix;		
			
			bitmapData = new BitmapData(target.width, target.height, true, 0);
			mat = new Matrix(1,0,0,1, -target.x, -target.y);
			bitmapData.draw(this, mat);
			
			// encode image to ByteArray
			var byteArray:ByteArray;
			var nombreArchivo:String = createName();
			var jpgEncoder:JPGEncoder = new JPGEncoder(100);
			byteArray = jpgEncoder.encode(bitmapData);   
			saveHelper.save(byteArray, nombreArchivo);*/
			
			
			//TweenMax.to(target, .1, {colorMatrixFilter:{saturation:0}});
			
			var mat:Matrix;		
			
			var bitmapData:BitmapData = new BitmapData(target.width, target.height, true, 0);
			mat = new Matrix(1, 0, 0, 1, -target.x, -target.y);
			bitmapData.draw(this, mat);
			
			var jpgEncoder:JPGEncoder = new JPGEncoder(100);
			var jpgStream:ByteArray = jpgEncoder.encode(bitmapData);			
			
			var header:URLRequestHeader = new URLRequestHeader ( "Content-type", "application/octet-stream" );						
			var jpgURLRequest:URLRequest = new URLRequest ( "php/jpg_encoder_download.php?name=" + createName());	
			
			/*Security.loadPolicyFile('http://api.facebook.com/crossdomain.xml');
			Security.allowDomain('http://profile.ak.fbcdn.net');
			Security.allowInsecureDomain('http://profile.ak.fbcdn.net')

			var context:LoaderContext = new LoaderContext();
			context.checkPolicyFile = true;
			context.applicationDomain = ApplicationDomain.currentDomain;*/			
			
			jpgURLRequest.requestHeaders.push(header);				
			jpgURLRequest.method = URLRequestMethod.POST;				
			jpgURLRequest.data = jpgStream;					
			
			var jpgURLLoader:URLLoader = new URLLoader();	
			jpgURLLoader.addEventListener(Event.COMPLETE, onComplete);
			jpgURLLoader.dataFormat = URLLoaderDataFormat.VARIABLES; 
			jpgURLLoader.load(jpgURLRequest);
				
			return;
		}// end function	
		
	}

}