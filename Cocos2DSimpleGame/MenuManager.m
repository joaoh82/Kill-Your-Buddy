//
//  MenuManager.m
//  Cocos2DSimpleGame
//
//  Created by João Henrique Machado Silva on 6/27/11.
//  Copyright 2011 Nurt. All rights reserved.
//

#import "MenuManager.h"

@interface MenuManager()
+(void) go: (CCLayer *) layer;
+(CCScene *) wrap: (CCLayer *) layer;
@end

@implementation MenuManager

+(void) goMenu{
    CCLayer *layer = [MenuLayer node];
    [MenuManager go:layer];
}

+(void) goCredits{
    CCLayer *layer = [CreditosLayer node];
    [MenuManager go:layer];
}

+(void) goBest{
    CCLayer *layer = [BestScoreLayer node];
    [MenuManager go:layer];
}

+(void) newGame:(NSString *)title{
    //CCLayer *layer = [PrimeiraFaseLayer node];
    TituloFaseLayer *layer = [TituloFaseLayer node];
    [layer.title setString:title];
    [layer setNextLevel:1];
    [MenuManager go:layer];
    
}

+(void) newFase:(NSString *)message fase:(int)fase{
    TituloFaseLayer *layer = [TituloFaseLayer node];
    [layer.title setString:message];
    [layer setNextLevel:fase];
    [MenuManager go:layer];
}

+(void) gameOver:(NSString *)message{
    
    GameOverLayer *layer = [GameOverLayer node];
    [layer.label setString:message];
    [MenuManager go:layer];
    
}

+(void) go:(CCLayer *)layer{
    CCDirector *director = [CCDirector sharedDirector];
    CCScene *newScene = [MenuManager wrap:layer];
    if ([director runningScene]) {
        
        //CCTransitionFade *tran = [CCTransitionFade transitionWithDuration:1 scene:newScene withColor:ccWHITE];
        CCTransitionPageTurn *tran = [CCTransitionPageTurn transitionWithDuration:1 scene:newScene backwards:YES];
        
        //[director replaceScene:newScene];
        [director replaceScene:tran];
    }else{
        [director runWithScene:newScene];
    }
}

+(CCScene*) wrap:(CCLayer *)layer{
    CCScene *newScene = [CCScene node];
    [newScene addChild:layer];
    return newScene;
}

@end
