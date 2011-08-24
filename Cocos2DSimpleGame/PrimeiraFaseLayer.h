//
//  HelloWorldLayer.h
//  Cocos2DSimpleGame
//
//  Created by João Henrique Machado Silva on 6/24/11.
//  Copyright Nurt 2011. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "MenuManager.h"
#import "Player.h"
#import "SimpleAudioEngine.h"
#import "GameOverScene.h"
#import "SegundaFaseLayer.h"
#import "Monster.h"
#import "PauseLayer.h"
#import "CCParallaxNode-Extras.h"

// HelloWorldLayer
@interface PrimeiraFaseLayer : CCLayerColor
{
    CCLabelTTF *lblPoints;
    
    NSMutableArray *_targets;
    NSMutableArray *_projectiles;
    
    int _projectilesDestroyed;
    
    Player *_player;
    CCSprite *_nextProjectile;
    
    CCSprite *background;
    CCSprite *background2;
    
    CCSprite *life;
    
    CCSprite *state;
    
    CCMenuItemImage *pausePlay;
    CCMenu *menu;
    
    CCLayer *airLayer;
    
    CCParallaxNode *_backgroundNode;

}

@property (nonatomic, retain) CCLabelTTF *lblPoints;
@property (nonatomic, retain) Player *_player;

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
