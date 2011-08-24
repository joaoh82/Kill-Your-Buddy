//
//  SegundaFaseLayer.h
//  KillYourBuddy
//
//  Created by João Henrique Machado Silva on 7/2/11.
//  Copyright 2011 Nurt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Player.h"
#import "PauseLayer.h"

@interface SegundaFaseLayer : CCLayerColor 
{
    
    CCLabelTTF *lblPoints;
    
    CCSprite *background;
    CCSprite *background2;
    
    CCSprite *life;
    
    NSMutableArray *_targets;
    NSMutableArray *_projectiles;
    
    int _projectilesDestroyed;
    
    Player *_player;
    CCSprite *_nextProjectile;
    
    CCMenuItemImage *pausePlay;
    CCMenu *menu;
    
    CCSprite *state;
    
    CCLayer *airLayer;
    
    CCParallaxNode *_backgroundNode;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
