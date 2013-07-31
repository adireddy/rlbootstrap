package com.ai.rlbootstrap.view {
	
	import com.ai.rlbootstrap.controller.events.LoadImageEvent;
	import com.ai.rlbootstrap.controller.events.ModelReadyEvent;
	import com.ai.rlbootstrap.model.AssetsModel;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class MainViewMediator extends Mediator {
		
		[Inject]
		public var view:MainView;
		
		[Inject]
		public var assetsModel:AssetsModel;
		
		override public function onRegister():void {
			eventMap.mapListener(eventDispatcher, ModelReadyEvent.READY, setData);
			eventMap.mapListener(eventDispatcher, LoadImageEvent.LOADED_IMAGE, setImage);
			
			view.addEventListener(view.LIST_CHANGE, handleListSelection);
			view.init();
		}
		
		private function handleListSelection(event:Event):void {
			view.desc = assetsModel.xmlData.item.(@id == view.selectedIndex + 1);
			eventDispatcher.dispatchEvent(new LoadImageEvent(LoadImageEvent.LOAD_IMAGE, String(view.selectedIndex + 1)));
		}		
		
		private function setData(event:ModelReadyEvent):void {
			eventMap.unmapListener(eventDispatcher, ModelReadyEvent.READY, setData);
			var listData:Array = [];
			for each (var item:XML in assetsModel.xmlData.item){
				listData.push(item.@label);
			}
			view.setData(listData);
		}
		
		private function setImage(event:LoadImageEvent):void {
			view.setImage(event.image);
		}
	}
}