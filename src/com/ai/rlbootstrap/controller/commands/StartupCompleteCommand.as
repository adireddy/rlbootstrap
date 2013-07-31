package com.ai.rlbootstrap.controller.commands {
	
	import com.ai.rlbootstrap.controller.events.LoadDataEvent;
	import com.ai.rlbootstrap.view.MainView;
	
	import org.robotlegs.mvcs.Command;
	
	public class StartupCompleteCommand extends Command {		
		
		override public function execute():void	{
			setupView();
			eventDispatcher.dispatchEvent(new LoadDataEvent(LoadDataEvent.LOAD_XML));
			//eventDispatcher.dispatchEvent(new LoadDataEvent(LoadDataEvent.LOAD_JSON));
		}
		
		private function setupView():void {
			contextView.addChild(new MainView());
		}
	}
}