//
//  PauseLayer.m
//  KillYourBuddy
//
//  Created by João Henrique Machado Silva on 7/4/11.
//  Copyright 2011 Nurt. All rights reserved.
//

#import "PauseLayer.h"


@implementation PauseLayer

-(id) init{
	if( (self=[super initWithColor:ccc4(0,0,0,255)] )) {

        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        [self setOpacity:100];
        [self setIsTouchEnabled:YES];
        
        CCMenuItemImage *play = [CCMenuItemImage itemFromNormalImage:@"play.png" selectedImage:@"play-on.png" target:self selector:@selector(onPlay:)];
        CCMenuItemImage *quit = [CCMenuItemImage itemFromNormalImage:@"giveup.png" selectedImage:@"giveup-on.png" target:self selector:@selector(onQuit:)];
        CCMenu *menu = [CCMenu menuWithItems:play, quit, nil];
        
        menu.position = ccp(240, winSize.height/2);
        [menu alignItemsVerticallyWithPadding: 20.0f];
        [self addChild:menu z: 2];
        
	}
    return self;
}

- (void)onQuit:(id)sender{
    [[Common appDelegate] setGamePaused:NO];
    
    [[CCDirector sharedDirector] resume];
    
	[MenuManager goMenu];
}

- (void)onPlay:(id)sender{
    
    [[Common appDelegate] setGamePaused:NO];
    
    [self removeFromParentAndCleanup:YES];
    [[CCDirector sharedDirector] resume];
}


@end
