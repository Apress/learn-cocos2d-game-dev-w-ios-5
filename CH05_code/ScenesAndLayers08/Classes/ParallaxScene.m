//
//  ParallaxScene.m
//  ScenesAndLayers
//
//  Created by Steffen Itterheim on 30.07.10.
//  Copyright 2010 Steffen Itterheim. All rights reserved.
//

#import "ParallaxScene.h"


@implementation ParallaxScene


+(id) scene
{
	CCScene* scene = [CCScene node];
	ParallaxScene* layer = [ParallaxScene node];
	[scene addChild:layer];
	return scene;
}

-(id) init
{
	if ((self = [super init]))
	{
		// This adds a solid color background.
		CCLayerColor* colorLayer = [CCLayerColor layerWithColor:ccc4(255, 0, 255, 255)];
		[self addChild:colorLayer z:0];

		CGSize screenSize = [[CCDirector sharedDirector] winSize];
		
		// Load the sprites for each parallax layer, from background to foreground.
		CCSprite* para1 = [CCSprite spriteWithFile:@"parallax1.png"];
		CCSprite* para2 = [CCSprite spriteWithFile:@"parallax2.png"];
		CCSprite* para3 = [CCSprite spriteWithFile:@"parallax3.png"];
		CCSprite* para4 = [CCSprite spriteWithFile:@"parallax4.png"];

		// Set the correct offsets depending on the screen and image sizes.
		para1.anchorPoint = CGPointMake(0, 1);
		para2.anchorPoint = CGPointMake(0, 1);
		para3.anchorPoint = CGPointMake(0, 0.6f);
		para4.anchorPoint = CGPointMake(0, 0);
		CGPoint topOffset = CGPointMake(0, screenSize.height);
		CGPoint midOffset = CGPointMake(0, screenSize.height / 2);
		CGPoint downOffset = CGPointZero;

		// Create a parallax node and add the sprites to it.
		CCParallaxNode* paraNode = [CCParallaxNode node];
		[paraNode addChild:para1 z:1 parallaxRatio:CGPointMake(0.5f, 0) positionOffset:topOffset];
		[paraNode addChild:para2 z:2 parallaxRatio:CGPointMake(1, 0) positionOffset:topOffset];
		[paraNode addChild:para3 z:4 parallaxRatio:CGPointMake(2, 0) positionOffset:midOffset];
		[paraNode addChild:para4 z:3 parallaxRatio:CGPointMake(3, 0) positionOffset:downOffset];
		[self addChild:paraNode z:0 tag:ParallaxSceneTagParallaxNode];

		// Move the parallax node to show the parallaxing effect.
		CCMoveBy* move1 = [CCMoveBy actionWithDuration:5 position:CGPointMake(-160, 0)];
		CCMoveBy* move2 = [CCMoveBy actionWithDuration:15 position:CGPointMake(160, 0)];
		CCSequence* sequence = [CCSequence actions:move1, move2, nil];
		CCRepeatForever* repeat = [CCRepeatForever actionWithAction:sequence];
		[paraNode runAction:repeat];
	}
	
	return self;
}

-(void) dealloc
{
	CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
