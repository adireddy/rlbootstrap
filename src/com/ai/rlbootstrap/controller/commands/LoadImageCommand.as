package com.ai.rlbootstrap.controller.commands {	
	
	import com.ai.rlbootstrap.controller.events.LoadImageEvent;
	import com.ai.rlbootstrap.model.AssetsModel;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import org.robotlegs.mvcs.Command;
	
	public class LoadImageCommand extends Command {
		
		[Inject]
		public var assetsModel:AssetsModel;
		
		[Inject]
		public var evt:LoadImageEvent;
		
		private var _imgLoader:Loader;
		
		override public function execute():void {
			_imgLoader = new Loader();
			_imgLoader.load(new URLRequest(assetsModel.xmlData.item.(@id == evt.id).@image));
			_imgLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, setImage);
		}
		
		private function setImage(event:Event):void {
			eventDispatcher.dispatchEvent(new LoadImageEvent(LoadImageEvent.LOADED_IMAGE, "", _imgLoader.content));
			_imgLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, setImage);
		}
	}
}