package nasim.ui.pages.profileDetected
	// nasim.ui.pages.profileDetected.ProfileDetect
{
	import appManager.event.AppEvent;
	import appManager.event.AppEventContent;
	
	import contents.LinkData;
	import contents.PageData;
	import contents.interFace.DisplayPageInterface;
	
	import flash.display.MovieClip;
	
	import picContest.Pic;
	
	public class ProfileDetect extends MovieClip implements DisplayPageInterface
	{
		public function ProfileDetect()
		{
			super();
		}
		
		public function setUp(pageData:PageData):void
		//profile_page ,local_storage_page	pageData.links1[0];
		{
		Pic.userManager.isLogedIn();
		var link_profile_page:LinkData= pageData.links1[1];
		var link_locacal_storage_page:LinkData= pageData.links1[0]
			if (Pic.userManager.isLogedIn()==true)
			{
				dispatchEvent(new AppEventContent(link_profile_page))
			}
			else
			{
				dispatchEvent(new AppEventContent(link_locacal_storage_page))
			}
		}
		}
	}
