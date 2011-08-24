//
//  MenuLayer.h
//  Cocos2DSimpleGame
//
//  Created by João Henrique Machado Silva on 6/27/11.
//  Copyright 2011 Nurt. All rights reserved.
//

#import "cocos2d.h"
#import "MenuManager.h"
#import "SimpleAudioEngine.h"

@interface MenuLayer : CCLayer {
    CCMenuItemImage *soundMenu;
    CCMenu *menu2;
    BOOL soundGame;
}

- (void)onNewGame:(id)sender;
- (void)onCredits:(id)sender;


@end
