package com.ai.rlbootstrap {
	
	import com.ai.rlbootstrap.controller.commands.LoadImageCommand;
	import com.ai.rlbootstrap.controller.commands.LoadJSONCommand;
	import com.ai.rlbootstrap.controller.commands.LoadXMLCommand;
	import com.ai.rlbootstrap.controller.commands.StartupCommand;
	import com.ai.rlbootstrap.controller.commands.StartupCompleteCommand;
	import com.ai.rlbootstrap.controller.events.LoadDataEvent;
	import com.ai.rlbootstrap.controller.events.LoadImageEvent;
	import com.ai.rlbootstrap.model.AssetsModel;
	import com.ai.rlbootstrap.view.MainView;
	import com.ai.rlbootstrap.view.MainViewMediator;
	
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Context;
	
	public class ApplicationContext extends Context {
		
		public function ApplicationContext(contextView:DisplayObjectContainer = null, autoStartup:Boolean = true) {
			super(contextView, autoStartup);
		}
		
		override public function startup():void	{			
			mapSingletons();
			mapMediators();
			mapCommands();
			dispatchEvent(new ContextEvent(ContextEvent.STARTUP));
		}
		
		private function mapSingletons():void {
			injector.mapSingleton(AssetsModel);
		}
		
		private function mapMediators():void {
			mediatorMap.mapView(MainView, MainViewMediator);
		}
		
		private function mapCommands():void {
			commandMap.mapEvent(ContextEvent.STARTUP, StartupCommand, ContextEvent, true);
			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, StartupCompleteCommand, ContextEvent, true);
			
			commandMap.mapEvent(LoadDataEvent.LOAD_XML, LoadXMLCommand, LoadDataEvent);
			commandMap.mapEvent(LoadDataEvent.LOAD_JSON, LoadJSONCommand, LoadDataEvent);
			commandMap.mapEvent(LoadImageEvent.LOAD_IMAGE, LoadImageCommand, LoadImageEvent);
		}
	}
}