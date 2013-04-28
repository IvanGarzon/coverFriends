////////////////////////////////////////////////////////////////////////////////
//																			  //
//  Ivan Garzón Cruz														  //
//  ivangarzoncruz@gmail.com												  //
//  Copyright 2011															  //	
//  All Rights Reserved ©.													  //
//																			  //
////////////////////////////////////////////////////////////////////////////////

package com.submarinos.images 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.IBitmapDrawable;
	import flash.display.BlendMode;
	import flash.display.PixelSnapping;
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author Ivancho [®]
	 * @version 1.0
	 */
	
	public class CropImage 
	{

		/*public static function cropBitmap($x:Number, $y:Number, $width:Number, $height:Number, $displayObject:IBitmapDrawable = null):Bitmap
		{
			var cropArea:Rectangle = new Rectangle( 0, 0, $width, $height );
			var croppedBitmap:Bitmap = new Bitmap( new BitmapData( $width, $height ), PixelSnapping.ALWAYS, true );
			var what:* = (($displayObject!=null) ? $displayObject : Stage);
			croppedBitmap.bitmapData.draw(what, new Matrix(1, 0, 0, 1, -$x, -$y) , null, BlendMode.NORMAL, cropArea, true );
			return croppedBitmap;
		}*/
		
		public static function crop( rect, matrix, _width:Number, _height:Number, displayObject:DisplayObject):Bitmap
		{
			//Create cropped image
			var croppedBitmap:Bitmap = new Bitmap( new BitmapData( _width, _height ), PixelSnapping.ALWAYS, true );
			croppedBitmap.bitmapData.draw(displayObject, matrix , null, null, rect, true );
			return croppedBitmap;
		}
	}
}