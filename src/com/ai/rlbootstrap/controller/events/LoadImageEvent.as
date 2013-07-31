package com.ai.rlbootstrap.controller.events {
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	public class LoadImageEvent extends Event {
		
		public static const LOAD_IMAGE:String = "LoadImageEvent.LOAD_IMAGE";
		public static const LOADED_IMAGE:String = "LoadImageEvent.LOADED_IMAGE";
		
		private var _id:String;		
		private var _image:DisplayObject;
		
		public function LoadImageEvent(type:String, id:String = "", img:DisplayObject = null, bubbles:Boolean = false, cancelable:Boolean = false) {
			_id = id;
			_image = img;
			super(type, bubbles, cancelable);
		}
		
		public function get image():DisplayObject {
			return _image;
		}
		
		public function set image(value:DisplayObject):void {
			_image = value;
		}
		
		public function get id():String {
			return _id;
		}
		
		public function set id(value:String):void {
			_id = value;
		}
		
		override public function clone():Event {
			return new LoadImageEvent(type, id, image);
		}
	}
}