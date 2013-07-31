package com.ai.rlbootstrap.controller.events {
	
	import flash.events.Event;
	
	public class LoadDataEvent extends Event {
		
		public static const LOAD_XML:String = "LoadDataEvent.LOAD_XML";
		public static const LOAD_JSON:String = "LoadDataEvent.LOAD_JSON";
		
		public function LoadDataEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event {
			return new LoadDataEvent(type);
		}
	}
}