package {
	
	import com.ai.rlbootstrap.ApplicationContext;
	
	import flash.display.Sprite;
	
	[SWF(backgroundColor="#FFFFFF", frameRate="24", width="800", height="600")]	
	public class RLBootstrap extends Sprite {
		
		protected var _context:ApplicationContext;
		
		public function RLBootstrap() {
			_context = new ApplicationContext(this);
		}
	}
}