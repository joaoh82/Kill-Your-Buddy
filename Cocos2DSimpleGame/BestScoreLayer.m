//
//  BestScoreLayer.m
//  KillYourBuddy
//
//  Created by João Henrique Machado Silva on 7/7/11.
//  Copyright 2011 Nurt. All rights reserved.
//

#import "BestScoreLayer.h"


@implementation BestScoreLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	CreditosLayer *layer = [CreditosLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init{
	if( (self=[super initWithColor:ccc4(255,255,255,255)] )) {
        
        int bestScoreValue = [[[NSUserDefaults standardUserDefaults] valueForKey:@"bestScore"] integerValue];
        int lastScoreValue = [[[NSUserDefaults standardUserDefaults] valueForKey:@"lastScore"] integerValue];        
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];

        
        CCSprite * bg = [CCSprite spriteWithFile:@"MenuBackground.jpg"];
        bg.position = ccp(bg.contentSize.width/2, winSize.height/2);
        [self addChild:bg z:0];
        
        CCSprite * gameover = [CCSprite spriteWithFile:@"best-score.png"];
        gameover.position = ccp(winSize.width/2, winSize.height-64);
        [self addChild:gameover z:1];
        
        CCSprite * yourscore = [CCSprite spriteWithFile:@"lastscore.png"];
        yourscore.position = ccp(winSize.width/2-111, winSize.height/2);
        [self addChild:yourscore z:1];
        
        CCLabelTTF *yourScore = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d points", lastScoreValue] fontName:@"Marker Felt" fontSize:32];
        yourScore.color = ccc3(255,255,255);
        yourScore.position = ccp(winSize.width/2+100, winSize.height/2);
        [self addChild:yourScore z:1];
        
        CCSprite * bestscore = [CCSprite spriteWithFile:@"bestscore.png"];
        bestscore.position = ccp(winSize.width/2-111, winSize.height/2-50);
        [self addChild:bestscore z:1];
        
        CCLabelTTF *bestScore = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d points", bestScoreValue] fontName:@"Marker Felt" fontSize:32];
        bestScore.color = ccc3(255,255,255);
        bestScore.position = ccp(winSize.width/2+100, winSize.height/2-50);
        [self addChild:bestScore z:1];
        
        CCMenuItemImage *menuBtn = [CCMenuItemImage itemFromNormalImage:@"menu.png" selectedImage:@"menu-on.png" target:self selector:@selector(onMenu:)];
        CCMenu *menu = [CCMenu menuWithItems:menuBtn, nil];
        menu.position = ccp(winSize.width-70, 35);
        [menu alignItemsVerticallyWithPadding: 10.0f];
        [self addChild:menu z: 2];
        
	}
    return self;
}

- (void)onMenu:(id)sender{
    [MenuManager goMenu];
}

@end
