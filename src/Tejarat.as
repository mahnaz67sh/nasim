package
{
	import contents.Contents;
	
	import darkBox.DarkBox;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import picContest.Pic;
	import picContest.PicConst;
	import picContest.PicContestMain;
	
	import popForm.PopMenuContent;
	
	import stageManager.StageManager;
	
	public class Tejarat extends PicContestMain
	{
		public function Tejarat()
		{
			super(0,true,false);
			
			Unicode.estesna= '-[]»«)(":';
			StageManager.add("stage_back_css",0,-1,false,true);
			StageManager.add("scaleble_y_css",0,0,false,true);
			
			trace("PicConst.stageRect : "+PicConst.stageRect);
			
			
			
			//stage.doubleClickEnabled = true ;
			//stage.addEventListener(MouseEvent.CLICK,showPop);
		}
		
		/*protected function showPop(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			//if(!PopMenu1.isOpen)
			//{
				var popText:PopMenuContent = new PopMenuContent('Hi',null,['ok']);
				PopMenu1.popUp('Title',null,popText,2000);
			//}
		}*/
	}
}