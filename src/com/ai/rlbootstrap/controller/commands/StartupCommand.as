package com.ai.rlbootstrap.controller.commands {
	
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Command;
	
	public class StartupCommand extends Command {
		
		override public function execute():void {
			eventDispatcher.dispatchEvent(new ContextEvent(ContextEvent.STARTUP_COMPLETE));
		}
	}
}