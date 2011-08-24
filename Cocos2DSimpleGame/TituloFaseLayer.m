//
//  TituloFaseLayer.m
//  KillYourBuddy
//
//  Created by João Henrique Machado Silva on 7/4/11.
//  Copyright 2011 Nurt. All rights reserved.
//

#import "TituloFaseLayer.h"


@implementation TituloFaseLayer

@synthesize title, nextLevel;

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	PrimeiraFaseLayer *layer = [PrimeiraFaseLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init{
	if( (self=[super initWithColor:ccc4(255,255,255,255)] )) {
    
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        CCSprite * bg = [CCSprite spriteWithFile:@"MenuBackground.jpg"];
        bg.position = ccp(bg.contentSize.width/2, winSize.height/2);
        [self addChild:bg];
        
        title = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:36];
        
        title.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild: title];
    
        [self runAction:[CCSequence actions:
                         [CCDelayTime actionWithDuration:3],
                         [CCCallFunc actionWithTarget:self selector:@selector(nextScene)],
                         nil]];
        
	}
    return self;
}

- (void)nextScene {
    
    if (nextLevel == 1) {
         CCTransitionFade *tran = [CCTransitionPageTurn transitionWithDuration:1 scene:[PrimeiraFaseLayer scene]];
        [[CCDirector sharedDirector] replaceScene:tran];
    }else if (nextLevel == 2) {
        CCTransitionFade *tran = [CCTransitionPageTurn transitionWithDuration:1 scene:[SegundaFaseLayer scene]];
        [[CCDirector sharedDirector] replaceScene:tran];
    }else if (nextLevel == 3) {
        CCTransitionFade *tran = [CCTransitionPageTurn transitionWithDuration:1 scene:[TerceiraFaseLayer scene]];
        [[CCDirector sharedDirector] replaceScene:tran];
    }
    
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
    
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
