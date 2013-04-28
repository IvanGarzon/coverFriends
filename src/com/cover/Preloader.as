package com.blurteam{
	import flash.display.*;
	import flash.events.*;
	import flash.errors.*;
	import flash.net.*;
	import flash.system.Capabilities;
	import flash.system.*;
	import com.blurteam.PrecargaPreview;
	//import com.greensock.*;
	//import com.greensock.easing.*;

	public class Preloader extends MovieClip {
		private var _animPreview:PrecargaPreview; 
		private var _anchuraIni:Number;
		private var _alturaIni:Number;
		private var _loaderSWF:Loader;
		
		public function Preloader() {
			stage.scaleMode = StageScaleMode.NO_SCALE; 
			stage.align = StageAlign.TOP_LEFT;
			_loaderSWF = new Loader();
			_animPreview = new PrecargaPreview();
			addEventListener(Event.ENTER_FRAME, init);
			stage.addEventListener(Event.RESIZE, resizeHandlerPre);
		}
		function resizeHandlerPre (e:Event):void {	
			//TweenMax.to(_animPreview, .9, {x:stage.stageWidth/2, y:stage.stageHeight/2, ease:Back.easeOut});
        }
		private function init(evento:Event=null):void{
			if(stage.stageWidth == 0){
				return;
				
			}
			removeEventListener(Event.ENTER_FRAME, init);
			_anchuraIni = 514;
			_alturaIni = 775;
			//_animPreview.x = _anchuraIni/2;
			//_animPreview.y = _alturaIni/2;
			//_animPreview.init(loaderInfo.parameters.colorPrecarga);
			addChild(_animPreview);
			_animPreview.x = stage.stageWidth / 2
			_animPreview.y = stage.stageHeight/2
			//TweenMax.to(_animPreview, .9, {x:stage.stageWidth/2, y:stage.stageHeight/2, ease:Back.easeOut});
			
			
			//_loaderSWF.contentLoaderInfo.addEventListener(Event.OPEN, _animPreview.openHandler);
			_loaderSWF.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, _animPreview.progressHandler);
			//_loaderSWF.contentLoaderInfo.addEventListener(Event.COMPLETE, _animPreview.completeHandler);
			/*
			*/
			_loaderSWF.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			_loaderSWF.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			
			_loaderSWF.load(getRequest());
			
			
		}
		
		private function getRequest():URLRequest{
			var request:URLRequest = new URLRequest();
			var variables:URLVariables= new URLVariables();
			var hayVariables:Boolean = false;
			var params:Object = loaderInfo.parameters;
			for(var param:String in params){
				if(param!="cargar" && param!="evitarCache"){
					variables[param] = params[param];
					hayVariables = true;
				}
			}
			if(params.evitarCache === "true" && (Capabilities.playerType == "PlugIn" || Capabilities.playerType == "ActiveX")){
				variables.a = String(Math.random());
				hayVariables = true;
			}
			if(hayVariables){
				request.data = variables;
			}
			request.url = (params.cargar != null)? params.cargar : "home.swf";
			
			return request;
			
		}
		private function errorHandler(evento:IOErrorEvent):void{
			throw(new Error(evento));
		}
		private function completeHandler(evento:Event=null):void {
			stage.removeEventListener(Event.RESIZE, resizeHandlerPre);
			var _contenido:MovieClip = MovieClip(_loaderSWF.content);
			var _anchuraContenido:Number = _loaderSWF.contentLoaderInfo.width;
			var _alturaContenido:Number = _loaderSWF.contentLoaderInfo.height;
			//_contenido.x = (_anchuraContenido - _anchuraIni)/2;
			//_contenido.y = (_alturaContenido - _alturaIni)/2;
			addChild(_contenido);
			limpiar();
			//_contenido.juego.gotoAndStop(2);
		}
		private function limpiar():void{
			_loaderSWF.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, _animPreview.progressHandler);
			_loaderSWF.contentLoaderInfo.removeEventListener(Event.COMPLETE, completeHandler);
			_loaderSWF.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			_loaderSWF = null;
			removeChild(_animPreview);
			_animPreview = null;
		}
	}
}