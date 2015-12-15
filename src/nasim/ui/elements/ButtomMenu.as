package nasim.ui.elements
{
	import appManager.mains.App;
	import appManager.mains.AppWithContent;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class ButtomMenu extends MovieClip
	{
		public function ButtomMenu()
		{
			super();
			
			this.mouseChildren = this.mouseEnabled = false ;
			
			this.stop();
			this.addEventListener(Event.ENTER_FRAME,anim);
		}
		private function anim(event:Event)
		{
			if(App.isInHome)
			{
				this.prevFrame();
			}
			else
			{
				this.nextFrame();
			}
		}
	}
}