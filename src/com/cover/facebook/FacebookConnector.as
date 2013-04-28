package com.cover.facebook 
{	
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.external.ExternalInterface;
	import flash.net.navigateToURL;
	
	import com.cover.facebook.user_info;
	import com.cover.services.Gateway;
	import com.cover.events.ServiceEvent;
	import com.cover.utils.StringUtil;
	
	public class FacebookConnector extends EventDispatcher 
	{
		private var _userInfo:user_info
		private var _service:Gateway;		
		private var _token:String;		
		
		public function FacebookConnector() 
		{
			
		}
		
		public function Connect():void
		{
			_service = new Gateway();
			_service.addEventListener(ServiceEvent.GET_USER_FACEBOOK, getUserFacebookResult);
			_service.getUserFacebook();
		}
		
		public function loginUserFacebook():void
		{
			_service = new Gateway();
			_service.addEventListener(ServiceEvent.LOGIN_USER_FACEBOOK, loginUserFacebookResult);
			_service.loginUserFacebook();
		}
		
		//---------------------------------------
		//  EVENT HANDLERS
		//---------------------------------------
		
		
		private function loginUserFacebookResult(event:ServiceEvent):void
		{	
			_service.removeEventListener(ServiceEvent.LOGIN_USER_FACEBOOK, loginUserFacebookResult);
			
			var result:Object = event.data as Object;
			//ExternalInterface.call('alert', result.error)
			
			if (result.error == 1)
			{
				ExternalInterface.call('alert', 'LOGIN');				
			}
			else
			{
				navigateToURL(new URLRequest(result.loginUrl), "_blank");
			}
			
			return;
		}// end function
		
		
		/**
		 * Result sendRegister() 
		 * @event ServiceEvent
		 * @return void
		 */	 
		
		private function getUserFacebookResult(event:ServiceEvent):void
		{	
			_service.removeEventListener(ServiceEvent.GET_USER_FACEBOOK, getUserFacebookResult);
			
			var result:Object = event.data as Object;
			
			if (result.error == 1)
			{
				userInfo = new user_info();	
				
				userInfo.user_id 		= event.data.id;			
				userInfo.user_name 		= event.data.name;			
				userInfo.first_name 	= event.data.first_name;
				userInfo.last_name 		= event.data.last_name;
				userInfo.user_email 	= event.data.email;			
				userInfo.user_birthday 	= event.data.birthday;			
				userInfo.user_picture	= event.data.picUser;	
				
				dispatchEvent(new Event("userConnected"));				
			}
			else 
			{
				
			}
		
			return;
		}// end function
		
		public function shareStory(value:String, name:String, tipo:Number):void
		{	
			var _params:Object = new Object();	
			var historia:String = value as String;
			historia = historia.substr(0, 250);
			historia = historia + '...' ;
				
			switch(tipo)
			{
				case(1):
					name = 'Arequipia';
					break;
				case(2):
					name = 'Chocoteutis';
					break;
				case(3):
					name = 'Fresalius';
					break;
				case(4):
					name = 'Moractis';
					break;
			}
				
			_params.message = "Comparte esta parte de la historia del Mundo " + name + " y continúa creando los otros mundos.";				
			_params.name = 'Submarinos Marinela';
			_params.link = 'http://apps.facebook.com/submarinos/';
			_params.caption = '{*actor*} ha compartido esta parte de la historia.';
			_params.description = historia;
			_params.source = 'http://www.pruebaacida.com/subfacebook/facebook/submarinoIni.jpg';
				
			_service = new Gateway();
			_service.addEventListener(ServiceEvent.SHARE_STORY_USER, shareStoryUserResult);
			_service.shareStoryUser(_params);
		}
		
		
		
		private function shareStoryUserResult(event:ServiceEvent):void 
		{
			dispatchEvent(new Event("requestShare"));	
		}
		
		
		/*private function GetIdInfoHandler(result:Object, fail:Object):void
		{
			galleryInfo = new gallery_info();
			galleryInfo.user_pic = Facebook.getImageUrl(result.id);
			//ExternalInterface.call('alert', galleryInfo.user_pic);
			
			dispatchEvent(new Event("userConnected"));
		}*/	
				
		
		
		public function GetUserInfo()
		{
			return userInfo;
		}
		
		public function GetIdInfo()
		{
			return galleryInfo;
		}

	}
}