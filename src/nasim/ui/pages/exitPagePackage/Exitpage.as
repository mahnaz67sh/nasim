package nasim.ui.pages.exitPagePackage
	//nasim.ui.pages.exitPagePackage.Exitpage
{
	import appManager.event.AppEvent;
	import appManager.event.AppEventContent;
	
	import contents.LinkData;
	import contents.PageData;
	import contents.interFace.DisplayPageInterface;
	
	import flash.display.MovieClip;
	
	import picContest.Pic;
	
	public class Exitpage extends MovieClip implements DisplayPageInterface
	{
		public function Exitpage()
		{
			super();
		}
		
		public function setUp(pageData:PageData):void
		
		{
			
			Pic.userManager.logOut();
			var link_login_page:LinkData= pageData.links1[0];
			this.dispatchEvent(new AppEventContent(link_login_page));
		}
	}
}