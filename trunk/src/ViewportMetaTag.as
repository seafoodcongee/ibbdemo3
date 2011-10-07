/*	

iBBDemo3
Copyright (c) 2011 apptaro

All rights reserved.
apptaro@gmail.com

Open Source License
===================
iBBDemo3 is licensed under the terms of the Open Source GPL 3.0 license. 

http://www.gnu.org/licenses/gpl.html

*/
package
{
	public class ViewportMetaTag
	{
		public var deviceWidth:Boolean;
		public var width:Number;
		public var deviceHeight:Boolean;
		public var height:Number;
		public var userScalable:Boolean;
		public var initialScale:Number;
		public var maximumScale:Number;
		public var minimumScale:Number;
		
		public function ViewportMetaTag():void
		{
		}
		
		public static function parse(document:Object):ViewportMetaTag
		{
			var viewportMetaTag:ViewportMetaTag = new ViewportMetaTag();
			try {
				var metaTags:Object = document.getElementsByTagName("meta");
				for (var i:uint = 0; i < metaTags.length; i++) {
					if (metaTags[i].name == "viewport") {
						var parts:Array = metaTags[i].content.split(",");
						for (var j:uint = 0; j < parts.length; j++) {
							var strs:Array = parts[j].split("=");
							var param:String = strs[0].replace(/^([\s|\t|\n]+)?(.*)([\s|\t|\n]+)?$/gm, "$2");
							var value:String = strs[1].replace(/^([\s|\t|\n]+)?(.*)([\s|\t|\n]+)?$/gm, "$2");
							if (param == "width") {
								if (value == "device-width") viewportMetaTag.deviceWidth = true;
								else if (!isNaN(Number(value))) viewportMetaTag.width = Number(value);
							} else if (param == "height") {
								if (value == "device-height") viewportMetaTag.deviceHeight = true;
								else if (!isNaN(Number(value))) viewportMetaTag.height = Number(value);
							} else if (param == "user-scalable") {
								viewportMetaTag.userScalable = (value == "yes") ? true : ((value == "no") ? false : null);
							} else if (param == "initial-scale") {
								if (!isNaN(Number(value))) viewportMetaTag.initialScale = Number(value);
							} else if (param == "maximum-scale") {
								if (!isNaN(Number(value))) viewportMetaTag.maximumScale = Number(value);
							} else if (param == "minimum-scale") {
								if (!isNaN(Number(value))) viewportMetaTag.minimumScale = Number(value);
							}
						}
					}
				}
			} catch (e:Error) {
			}
			return viewportMetaTag;
		}
	}
}
