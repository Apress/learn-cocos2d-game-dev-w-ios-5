//
//  ParallaxBackground.m
//  ScrollingWithJoy
//
//  Created by Steffen Itterheim on 04.08.10.
//
//  Updated by Andreas Loew on 20.06.11:
//  * retina display
//  * framerate independency
//  * using TexturePacker http://www.texturepacker.com
//
//  Copyright Steffen Itterheim and Andreas Loew 2010-2011. 
//  All rights reserved.
//

#import "ParallaxBackground.h"


@implementation ParallaxBackground

-(id) init
{
	if ((self = [super init]))
	{
		CGSize screenSize = [[CCDirector sharedDirector] winSize];
		
		// Get the game's texture atlas texture by adding it. Since it's added already it will simply return 
		// the CCTexture2D associated with the texture atlas.
		CCTexture2D* gameArtTexture = [[CCTextureCache sharedTextureCache] addImage:@"game-art.pvr.ccz"];
		
		// Create the background spritebatch
		spriteBatch = [CCSpriteBatchNode batchNodeWithTexture:gameArtTexture];
		[self addChild:spriteBatch];
		
		// Add the 6 different layer objects and position them on the screen
		for (int i = 0; i < 7; i++)
		{
			NSString* frameName = [NSString stringWithFormat:@"bg%i.png", i];
			CCSprite* sprite = [CCSprite spriteWithSpriteFrameName:frameName];
			sprite.position = CGPointMake(screenSize.width / 2, screenSize.height / 2);
			[spriteBatch addChild:sprite z:i];
		}
		
		scrollSpeed = 1.0f;
		[self scheduleUpdate];
	}
	
	return self;
}

-(void) update:(ccTime)delta
{
	CCSprite* sprite;
	CCARRAY_FOREACH([spriteBatch children], sprite)
	{
		CGPoint pos = sprite.position;
		pos.x -= (scrollSpeed + sprite.zOrder) * (delta * 20);
		sprite.position = pos;
	}
}

@end
