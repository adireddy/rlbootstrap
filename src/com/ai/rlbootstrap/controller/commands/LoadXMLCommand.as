package com.ai.rlbootstrap.controller.commands {	
	
	import com.ai.rlbootstrap.controller.events.ModelReadyEvent;
	import com.ai.rlbootstrap.model.AssetsModel;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.robotlegs.mvcs.Command;
	
	public class LoadXMLCommand extends Command implements ILoadDataCommand {
		
		[Inject]
		public var assetsModel:AssetsModel;
		
		private var _xmlLoader:URLLoader;
		
		override public function execute():void {
			loadData();
		}
		
		public function loadData():void {
			_xmlLoader = new URLLoader();
			_xmlLoader.addEventListener(Event.COMPLETE, setData);
			_xmlLoader.load(new URLRequest(AssetsModel.DATA_XML_PATH));
		}
		
		public function setData(event:Event):void {
			assetsModel.xmlData = new XML(_xmlLoader.data);
			eventDispatcher.dispatchEvent(new ModelReadyEvent(ModelReadyEvent.READY));
		}
	}
}