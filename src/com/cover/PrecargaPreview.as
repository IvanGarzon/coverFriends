package com.blurteam{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.errors.*;
	import flash.text.TextField;
	
	public class PrecargaPreview extends MovieClip{
		public function progressHandler(evento:ProgressEvent):void {
			var p:Number = evento.bytesLoaded*100 / evento.bytesTotal;
			p = Math.round(p);
			this.mcTexto.mcNumero.text = String(p);
			this.mcBar.scaleX = p / 100;
		}
	}
}