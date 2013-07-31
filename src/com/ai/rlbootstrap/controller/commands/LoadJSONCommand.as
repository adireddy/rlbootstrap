package com.ai.rlbootstrap.controller.commands {	
	
	import com.adobe.serialization.json.JSON;
	import com.ai.rlbootstrap.controller.events.ModelReadyEvent;
	import com.ai.rlbootstrap.model.AssetsModel;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.robotlegs.mvcs.Command;
	
	public class LoadJSONCommand extends Command implements ILoadDataCommand {
		
		[Inject]
		public var assetsModel:AssetsModel;
		
		private var _jsonLoader:URLLoader;
		
		override public function execute():void {
			loadData();
		}
		
		public function loadData():void {
			_jsonLoader = new URLLoader();
			_jsonLoader.addEventListener(Event.COMPLETE, setData);
			_jsonLoader.load(new URLRequest(AssetsModel.DATA_JSON_PATH));
		}
		
		public function setData(event:Event):void {
			var raw:String = String(_jsonLoader.data);
			assetsModel.jsonData = com.adobe.serialization.json.JSON.decode(raw) as Array;
			
			// For some reason could not able to parse the JSON
			// JSONParseError: String contains unescaped control character (0x00-0x1F)
			
			eventDispatcher.dispatchEvent(new ModelReadyEvent(ModelReadyEvent.READY));
		}
	}
}