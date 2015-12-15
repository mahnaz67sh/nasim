package nasim.ui.floatingImages
	//nasim.ui.floatingImages.FloatingImages
{
	import contents.Contents;
	import contents.LinkData;
	import contents.PageData;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import nape.constraint.PivotJoint;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyList;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Circle;
	import nape.space.Space;
	import nape.util.BitmapDebug;
	
	import picContest.services.types.VPhotoContest;
	import picContest.services.webCaller.GetPhotos;
	
	public class FloatingImages extends MovieClip
	{
		
		private static const active_debug:Boolean = false ;
		
		private var space:Space ;
		
		private var debug:BitmapDebug ;
		private var handJoint:PivotJoint;
		
		private var bubleChanse:uint = 50 ;
		
		private var bubbls:Vector.<FloatingImageItem>,
					bodies:Vector.<Body>;
		
		private var W:Number,
					H:Number ;
		
		private const PI:Number = 3.14;
		
		private var service_getAllImages:GetPhotos ;
		
		private var engineStarted:Boolean = false;
		
		private var currentImageIndex:uint ;
		
		private var totalImageOnStage:uint = 100  ;
		
		
		public function FloatingImages()
		{
			super();
			
			service_getAllImages = new GetPhotos(true,true);
			service_getAllImages.addEventListener(Event.COMPLETE,imagesLoaded);
			service_getAllImages.addEventListener(Event.CHANGE,imagesLoaded);
			service_getAllImages.addEventListener(Event.UNLOAD,reloadImageList);
			
			
			W = this.width;
			H = this.height ;
			
			bubbls = new Vector.<FloatingImageItem>();
			bodies = new Vector.<Body>();
			
			space = new Space(new Vec2(0,0));
			
			if(active_debug)
			{
				debug = new BitmapDebug(this.width,this.height);
				this.addChild(debug.display);
			}
			
			handJoint = new PivotJoint(space.world, null, Vec2.weak(), Vec2.weak());
			handJoint.space = space;
			handJoint.active = false;
			
			// We also define this joint to be 'elastic' by setting
			// its 'stiff' property to false.
			//
			// We could further configure elastic behaviour of this
			// constraint through the 'frequency' and 'damping'
			// properties.
			handJoint.stiff = false;
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			
			this.addEventListener(Event.REMOVED_FROM_STAGE,unLoad);
			
			service_getAllImages.load('0','0','0','','true','','','0',totalImageOnStage.toString(),GetPhotos.sort_date);
			
			//this.addEventListener(Event.ENTER_FRAME,generateLinks);
			//this.addEventListener(Event.ENTER_FRAME,anim);
		}
		
		protected function reloadImageList(event:Event):void
		{
			// TODO Auto-generated method stub
			service_getAllImages.reLoad();
		}
		
		protected function imagesLoaded(event:Event):void
		{
			// TODO Auto-generated method stub
			totalImageOnStage = service_getAllImages.data.length ;
			currentImageIndex = Math.floor(Math.random()*totalImageOnStage);
			if(!engineStarted)
			{
				this.addEventListener(Event.ENTER_FRAME,anim);
			}
			
			engineStarted = true ;
		}		
		
		
		
		protected function mouseUpHandler(event:MouseEvent):void
		{
			handJoint.active = false;
			// TODO Auto-generated method stub
			
		}
		
		protected function mouseDownHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			var mousePoint:Vec2 = Vec2.get(mouseX, mouseY);
			
			// Determine the set of Body's which are intersecting mouse point.
			// And search for any 'dynamic' type Body to begin dragging.
			var bodies:BodyList = space.bodiesUnderPoint(mousePoint);
			for (var i:int = 0; i < bodies.length; i++) {
				var body:Body = bodies.at(i);
				
				if (!body.isDynamic()) {
					continue;
				}
				
				// Configure hand joint to drag this body.
				// We initialise the anchor point on this body so that
				// constraint is satisfied.
				//
				// The second argument of worldPointToLocal means we get back
				// a 'weak' Vec2 which will be automatically sent back to object
				// pool when setting the handJoint's anchor2 property.
				handJoint.body2 = body;
				handJoint.anchor2.set(body.worldPointToLocal(mousePoint, true));
				
				// Enable hand joint!
				handJoint.active = true;
				
				break;
			}
			
			// Release Vec2 back to object pool.
			mousePoint.dispose();
		}
		
		protected function unLoad(event:Event):void
		{
			// TODO Auto-generated method stub
			service_getAllImages.cansel();
			this.removeEventListener(Event.ENTER_FRAME,anim);
			this.removeEventListener(Event.REMOVED_FROM_STAGE,unLoad);
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			//this.removeEventListener(Event.ENTER_FRAME,generateLinks);
			
			for(var i = 0 ; i<bodies.length ; i++)
			{
				bodies[i].space = null ;
				bodies[i] = null ;
				this.removeChild(bubbls[i]);
				
				bodies.splice(i,1);
				bubbls.splice(i,1);
			}
		}
		
		private function anim(e:Event)
		{
			if(Math.floor(Math.random()*bubleChanse) == 0)
			{
				//Create buble
				addBuble();
			}
			
			if (handJoint.active) {
				handJoint.anchor1.setxy(mouseX, mouseY);
			}
			
			space.step(0.032);
			if(active_debug)
			{
				debug.clear();
				debug.draw(space);
				debug.flush();
			}
			
			for(var i = 0 ; i<bodies.length ; i++)
			{
				bubbls[i].x = bodies[i].position.x;
				bubbls[i].y = bodies[i].position.y;
				bubbls[i].rotation = bodies[i].rotation/PI*180;
				
				if(bubbls[i].x > W*2 || bubbls[i].y>2000 || bubbls[i].y<-2000 || bubbls[i].x<W*-1 )
				{
					bodies[i].space = null ;
					bodies[i] = null ;
					this.removeChild(bubbls[i]);
					
					bodies.splice(i,1);
					bubbls.splice(i,1);
				}
			}
		}
		
		
		
		
		
		private function addBuble():void
		{
			// TODO Auto Generated method stub
			//var newBub:FloatingImageItem = new FloatingImageItem(RandomPic.getNextLink());
			var currentImage:VPhotoContest = service_getAllImages.data[currentImageIndex];
			
			var newBub:FloatingImageItem = new FloatingImageItem(currentImage);
			bubbls.push(newBub);
			this.addChild(newBub);
			
			var speed:Number = 100*Math.random()+100;
			
			var bub:Body = new Body(BodyType.DYNAMIC,new Vec2(-2*newBub.width,Math.random()*H));
			bub.shapes.add(newBub.shape());
			bub.space = space ;
			bub.velocity = new Vec2(speed,0);
			//bub.rotation = Math.random()*1-.5;
			bub.angularVel = (Math.random()*0.2)-0.1 ;
			bodies.push(bub);
			
			currentImageIndex = (currentImageIndex+1)%totalImageOnStage ;
			
			//linkIndex = linkIndex%randomImageLinks.length;
		}	
	}
}

