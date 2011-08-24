//
//  MenuLayer.m
//  Cocos2DSimpleGame
//
//  Created by João Henrique Machado Silva on 6/27/11.
//  Copyright 2011 Nurt. All rights reserved.
//

#import "MenuLayer.h"

@implementation MenuLayer

-(id) init{
	self = [super init];
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    CCSprite * bg = [CCSprite spriteWithFile:@"MenuBackground.jpg"];
    bg.position = ccp(bg.contentSize.width/2, winSize.height/2);
    [self addChild:bg];
    
    
    CCSprite * title = [CCSprite spriteWithFile:@"kill-your-buddy.png"];
	//CCLabelTTF *title = [CCLabelTTF labelWithString:@"Kill Your Buddy" fontName:@"Marker Felt" fontSize:48];
    
    CCMenuItemImage *startNew = [CCMenuItemImage itemFromNormalImage:@"new-game.png" selectedImage:@"new-game-on.png" target:self selector:@selector(onNewGame:)];
    CCMenuItemImage *scores = [CCMenuItemImage itemFromNormalImage:@"best-score-menu.png" selectedImage:@"best-score-menu-on.png" target:self selector:@selector(onBest:)];
    CCMenuItemImage *credits = [CCMenuItemImage itemFromNormalImage:@"credits.png" selectedImage:@"credits-on.png" target:self selector:@selector(onCredits:)];
	CCMenu *menu = [CCMenu menuWithItems:startNew, scores, credits, nil];
    
	title.position = ccp(240, 250);
	[self addChild: title];
    
	menu.position = ccp(240, 100);
	[menu alignItemsVerticallyWithPadding: 10.0f];
	[self addChild:menu z: 2];
    
    soundMenu = [CCMenuItemImage itemFromNormalImage:@"sound-icon.png" selectedImage:@"sound-icon-off.png" target:self selector:@selector(soundGame:)];
    menu2 = [CCMenu menuWithItems:soundMenu, nil];
    menu2.position = ccp(winSize.width-30, winSize.height-30);
    [self addChild:menu2 z: 2];

    soundGame = [[Common appDelegate] soundGame];
    if (soundGame) {
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"bamboozled.m4a"];
    }
    
	return self;
}

- (void)soundGame:(id)sender{
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    [self removeChild:menu2 cleanup:YES];
    
    soundGame = [[Common appDelegate] soundGame];
    
    if (!soundGame) {
        [[Common appDelegate] setSoundGame:YES];
        soundMenu = [CCMenuItemImage itemFromNormalImage:@"sound-icon.png" selectedImage:@"sound-icon-off.png" target:self selector:@selector(soundGame:)];
        menu2 = [CCMenu menuWithItems:soundMenu, nil];
        menu2.position = ccp(winSize.width-30, winSize.height-30);
        [self addChild:menu2 z: 2];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"bamboozled.m4a"];
    }else{
        [[Common appDelegate] setSoundGame:NO];
        soundMenu = [CCMenuItemImage itemFromNormalImage:@"sound-icon-off.png" selectedImage:@"sound-icon.png" target:self selector:@selector(soundGame:)];
        menu2 = [CCMenu menuWithItems:soundMenu, nil];
        menu2.position = ccp(winSize.width-30, winSize.height-30);
        [self addChild:menu2 z: 2];
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    }
    
}

- (void)onNewGame:(id)sender{
	[MenuManager newGame:@"Get ready to rumble!"];
}

- (void)onCredits:(id)sender{
	[MenuManager goCredits];
}

- (void)onBest:(id)sender{
	[MenuManager goBest];
}

@end
