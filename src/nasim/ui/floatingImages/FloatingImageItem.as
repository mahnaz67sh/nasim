package nasim.ui.floatingImages
	//nasim.ui.floatingImages.FloatingImageItem
{
	import appManager.displayContentElemets.LightImage;
	import appManager.event.AppEventContent;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	
	import nape.phys.Material;
	import nape.shape.Circle;
	import nape.shape.Polygon;
	import nape.shape.Shape;
	
	import picContest.Pic;
	import picContest.services.types.VPhotoContest;
	
	public class FloatingImageItem extends MovieClip
	{
		private var areaMC:MovieClip ;
		
		private var myData:VPhotoContest ;
		
		private var myLightImage:LightImage ;
		
		private var pressedTime:uint ;
		
		public function FloatingImageItem(data:VPhotoContest)
		{
			super();
			
			myData = data ;
			
			myLightImage = Obj.findThisClass(LightImage,this,true);
			
			areaMC = Obj.get("back_mc",this);
			
			this.gotoAndStop(Math.floor(Math.random()*this.totalFrames)+1);
			
			myLightImage.setUp(myData.imageThumb());
			
			this.buttonMode = true ;
			this.addEventListener(MouseEvent.MOUSE_DOWN,imPressed);
			this.addEventListener(MouseEvent.MOUSE_UP,imReleased);
		}
		
		protected function imReleased(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			if(getTimer()-pressedTime<200)
			{
				Pic.currentImage = myData ;
				this.dispatchEvent(new AppEventContent(Pic.userImages.mediaLink(false,Pic.currentImage)/*imageInfoLink*/));
			}
		}
		
		protected function imPressed(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			pressedTime = getTimer();
		}
		
		
		public function shape():Shape
		{
			var deltaX:Number = areaMC.width/2 ;
			var deltaY:Number = areaMC.height/2 ;
			return new Polygon(Polygon.rect(-deltaX,-deltaY,deltaX*2,deltaY*2));//new Polygon(this.width/2,null,Material.glass())
		}
	}
}