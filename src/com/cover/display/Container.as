package com.cover.display 
{
	/**
	 * ...
	 * @author Ivancho
	 */
	
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.utils.getDefinitionByName;
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
	
	import com.adobe.images.*;	
	import com.greensock.*;
	import com.greensock.easing.*;
	
	import com.cover.events.ServiceEvent;
	import com.cover.services.Gateway;
	import com.cover.events.CoverEvent;
	import com.cover.images.SaveImage;
	
	import fl.motion.AdjustColor;
	import flash.filters.ColorMatrixFilter;	
	 
	public class Container extends MovieClip
	{
		private var _cover:MovieClip;
		private var _picUser:Array;
		
		private var _idPic:int;		
		private var _service:Gateway;
		private var _coverEvent:CoverEvent;
		private var _saveImage:SaveImage;
		
		private var contPic:int;		
		private var posX:int;
		private var posY:int;
		
		public function Container() 
		{
			onInit();			
		}// end constructor
		
		private function onInit():void
		{			
			trace('onInit');
			Security.loadPolicyFile("http://graph.facebook.com/crossdomain.xml");
			Security.loadPolicyFile("http://profile.ak.fbcdn.net/crossdomain.xml");
			Security.allowDomain("*");
			Security.allowInsecureDomain("*");
			_picUser = [];
			_idPic = 0;
			loadFriendsPic();		
		}
			
		/**
		 * 
		 * @param void
		 * @return void
		 */	 
		
		public function loadFriendsPic():void
		{
			_service = new Gateway();
			_service.addEventListener(ServiceEvent.LOAD_FRIENDS_PIC, loadFriendsPicResult);
			_service.loadFriendsPic();	
			
			//var urlPic:String = 'images/picUser.jpg';
			//var urlPic:String = 'http://profile.ak.fbcdn.net/hprofile-ak-snc4/372325_512057089_1861680592_q.jpg';
			//loadFriendsPicStatic(urlPic);
			
			return;
		}// end function		
		
			
		/**
		 * @param ServiceEvent
		 * @return void
		 */	 
		
		private function loadFriendsPicResult(event:ServiceEvent):void
		{	
			var result:Number = event.data.error as Number;
			var i:Number;
			var children:Array = [];			
			
			/*for (i = 0; i < Cover.numChildren; i++) 
			{
				children.push(Cover.getChildAt(i));				
			}
				
			for (i = 0; i < children.length; i++) 
			{
				children[i].parent.removeChild(children[i]);  
			}*/
			
			if (result == 1)
			{		
				var picUser:Array = event.data.picUser as Array;		
				
				for (i = 0; i <= 119; i++)
				{
					if (i == 119)
					{
						loadFriendsPicAll(_picUser);							
					}
					else
					{
						_picUser.push(picUser[i]);												
						//_picUser.push('images/bordello.jpg');												
					}			
				}	
			} 
			else if (result == 0)
			{
				//dispatchEvent(new Event('loadTypeStory'));
				//trace("*** YOU DON'T HAVE ANY FRIEND ***");
			}
			
			return;
		}// end function
		
		/**
		 * SHOW ALERT
		 * @param mensaje
		 * @return	
		*/	
		
		private function loadFriendsPicAll(value:Array):void
		{			
			_cover = new Contenedor();
			contPic = 0;
				
			var totalRows:Number = 350 / 50;
			var totalCols:Number = 850 / 50; 
			
			var my_thumb_width:int = 50;
			var my_thumb_height:int = 50;
			
			var x_counter:Number = 0;
			var y_counter:Number = 0;
			
			for (var i:int = 0; i < value.length; i++) 
			{								
				var thumb_loader:Loader = new Loader();
				thumb_loader.load(new URLRequest(value[i]));
				thumb_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, thumbLoaded);

				thumb_loader.name = 'myLoader_ ' + i;

				thumb_loader.x = (my_thumb_width) * x_counter;
				thumb_loader.y = (my_thumb_height) * y_counter;

				if (x_counter + 1 < totalCols) 
				{
					x_counter++;
				}
				else
				{
					x_counter = 0;
					y_counter++;
				}
			}	
			
			//_cover.scaleX = _cover.scaleY = .5;
			//_cover.x = ((stage.stageWidth / 2) - (_cover.width / 2));
			//_cover.y = ((stage.stageHeight / 2) - (_cover.height / 2));
			//addChild(_cover);
			
			//_coverEvent = new CoverEvent(CoverEvent.SHOW_BUTTONS, _cover);
			//dispatchEvent(_coverEvent);			
			
			return;
		}// end function
		
		private function thumbLoaded(e:Event):void 
		{
			var my_thumb:Loader = Loader(e.target.loader);		
			
			/*var classRef:Class;
			var myObject:MovieClip;				
			classRef = getDefinitionByName("FriendPic") as Class;
			myObject = new classRef();			
			myObject.mcPic.holder.addChild(my_thumb);*/
			
			_cover.addChild(my_thumb);
			contPic++;
			
			if (contPic == _picUser.length)
			{
				trace('savePic');
				//savePic(container);
				
				//_cover.scaleX = _cover.scaleY = .5;
				_cover.x = ((stage.stageWidth / 2) - (_cover.width / 2));
				_cover.y = ((stage.stageHeight / 2) - (_cover.height / 2));
				addChild(_cover);	
				adjustColors(_cover);
				//savePic(_cover);
				
				//_saveImage = new SaveImage();
				//_saveImage.saveImage(_cover);
			}		
			
			return;
		}// end function
		
		private function savePic(target:MovieClip):void
		{
			_saveImage = new SaveImage();
			var nameFile:String = _saveImage.createName();
			
			var mat:Matrix;		
			
			var bitmapData:BitmapData = new BitmapData(target.width, target.height, true, 0);
			mat = new Matrix(1, 0, 0, 1, -target.x, -target.y);
			bitmapData.draw(this, mat);
			
			var jpgEncoder:JPGEncoder = new JPGEncoder(100);
			var jpgStream:ByteArray = jpgEncoder.encode(bitmapData);			
			
			var header:URLRequestHeader = new URLRequestHeader ( "Content-type", "application/octet-stream" );						
			var jpgURLRequest:URLRequest = new URLRequest ( "php/jpg_encoder_download.php?name=" + nameFile);	
			
			Security.loadPolicyFile('http://api.facebook.com/crossdomain.xml');
			Security.allowDomain('http://profile.ak.fbcdn.net');
			Security.allowInsecureDomain('http://profile.ak.fbcdn.net')

			var context:LoaderContext = new LoaderContext();
			context.checkPolicyFile = true;
			context.applicationDomain = ApplicationDomain.currentDomain;			
			
			jpgURLRequest.requestHeaders.push(header);				
			jpgURLRequest.method = URLRequestMethod.POST;				
			jpgURLRequest.data = jpgStream;					
			
			var jpgURLLoader:URLLoader = new URLLoader();	
			jpgURLLoader.addEventListener(Event.COMPLETE, onComplete);
			jpgURLLoader.dataFormat = URLLoaderDataFormat.VARIABLES; 
			jpgURLLoader.load(jpgURLRequest);
			
			return;
		}//end of function
		
		/**
		 * @param Event
		 * @return void
		 */	  	
		
		private function onComplete(event:Event):void 
		{
			//ExternalInterface.call('alert', event.target.data.write);			
			_service.addEventListener(ServiceEvent.GET_ID_ALBUM, geiIdAlbumResult);
			_service.getIdAlbum(event.target.data.write);	
		}
		
		private function adjustColors(target:MovieClip):void
		{
			var colorFilter:AdjustColor = new AdjustColor();
			var mColorMatrix:ColorMatrixFilter;
			var mMatrix:Array = [];
			
			/*colorFilter.brightness = 10
			colorFilter.contrast =  20
			colorFilter.saturation =  40
			colorFilter.hue =  30*/
			
			/*var sepia = new flash.filters.ColorMatrixFilter();
			sepia.matrix = [0.3930000066757202,
							0.7689999938011169,
							0.1889999955892563,
							0,
							0,
							0.3490000069141388,
							0.6859999895095825,
							0.1679999977350235,
							0,
							0,
							0.2720000147819519,
							0.5339999794960022,
							0.1309999972581863,
							0,
							0,
							0,
							0,
							0,
							1,
							0,
							0,
							0,
							0,
							0,
							1];

			//mMatrix = colorFilter.CalculateFinalFlatArray();
			//mColorMatrix = new ColorMatrixFilter(mMatrix);*/
			
			var colour:Array = [];
			colour = colour.concat( [0.34, 0.33, 0.33, 0.00, 30.00] );
			colour = colour.concat( [0.33, 0.34, 0.33, 0.00, 20.00] );
			colour = colour.concat( [0.33, 0.33, 0.34, 0.00, 0.00] );
			colour = colour.concat( [0.00, 0.00, 0.00, 1.00, 0.00] );

			var colourFilter:ColorMatrixFilter = new ColorMatrixFilter( colour );

			target.filters = [ colourFilter ];
			//target.filters = [sepia];
			savePic(target);
		}		
		
			/**
		 * @param ServiceEvent
		 * @return void
		 */	 
		
		private function geiIdAlbumResult(event:ServiceEvent):void
		{	
			var result:Number = event.data.error as Number;
			
			if (result == 1)
			{
				var idAlbum:String = event.data.idAlbum as String;
				ExternalInterface.call('alert', idAlbum);
			}
			else if (result == 2)
			{
				ExternalInterface.call('alert', result);
			}
		
		}
	}
}