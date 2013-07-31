package com.ai.rlbootstrap.controller.events {
	
	import flash.events.Event;
	
	public class ModelReadyEvent extends Event {
		
		public static const READY:String = "ModelReadyEvent.READY";
		
		public function ModelReadyEvent(type:String) {
			super(type, false, false);			
		}
		
		override public function clone():Event {
			return new ModelReadyEvent(type);
		}
	}
}