package com.cover.services 
{
	import com.cover.events.ServiceEvent;
	
	import flash.events.EventDispatcher;
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	import flash.net.Responder;
	import flash.net.NetStream;
	import flash.net.Responder;
	import flash.net.navigateToURL;
	import flash.system.Capabilities;
	import flash.external.ExternalInterface;
	
	[Event(name = "loadFriensPicResult", type="com.cover.events.ServiceEvent")]	
	
	/**
	 * ...
	 * @author Ivancho [®]
	 * @version 1.0
	 */
	
	public class Gateway extends EventDispatcher
	{
		//{	VARIABLES
		/**
		 *	Control Vars 
		 */
		
		private var _gateway:NetConnection;		
		private var _gatewayUrl:String = '';
		
		/**
		 * Consts
		 */
		
		/**
		 * @constructor
		 */
		
		public function Gateway( ) 
		{
			//	Create connection instance
			_gateway = new NetConnection();
			
			if (Capabilities.playerType == "External")
			{
				_gatewayUrl = "http://localhost/htdocs/Dropbox/coverFriends/bin/amfphp/gateway.php";
			} 
			else
			{
				_gatewayUrl = "amfphp/gateway.php";
			}					
			
			init();
		}
		
		/**
		 * Set class defaults
		 */
		
		private function init():void
		{
			//trace(sGatewayUrl);
			_gateway.objectEncoding = ObjectEncoding.AMF0;
			_gateway.connect(_gatewayUrl);
		}
		
		//}
		//{	METHODS
		
		public function loadFriendsPic():void
		{
			var oResponder:Responder = new Responder(onLoadFriendsPicResult, onFault);
			_gateway.call("CF_Facebook.loadFriendsPic", oResponder);
		}
		
		public function getIdAlbum(urlCoverPhoto:String):void
		{
			//ExternalInterface.call('alert', 'getIdAlbum');
			
			var oResponder:Responder = new Responder(onGetIdAlbumResult, onFault);
			_gateway.call("CF_Facebook.getIdAlbum", oResponder, urlCoverPhoto);
		}
		
		//}
		//{EVENTS
		
		private function onFault(oResult:Object):void
		{
			trace("COMM=> FAULT");
		}
		
		//}
		//{RESULTS
		
		private function onLoadFriendsPicResult(result:Object):void
		{
			var data:Object = result as Object;			
			dispatchEvent(new ServiceEvent(ServiceEvent.LOAD_FRIENDS_PIC, data));
		}
		
		private function onGetIdAlbumResult(result:Object):void
		{
			var data:Object = result as Object;			
			dispatchEvent(new ServiceEvent(ServiceEvent.GET_ID_ALBUM, data));
		}
		
		//}
		//{	ACCESORS
		
	}
	
}