//
//  MenuManager.h
//  Cocos2DSimpleGame
//
//  Created by João Henrique Machado Silva on 6/27/11.
//  Copyright 2011 Nurt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MenuLayer.h"
#import "PrimeiraFaseLayer.h"
#import "SegundaFaseLayer.h"
#import "GameOverScene.h"
#import "TituloFaseLayer.h"
#import "CreditosLayer.h"
#import "BestScoreLayer.h"
#import "CCTransition.h"
#import "TituloFaseLayer.h"

@interface MenuManager : NSObject {
    
}

+(void) goMenu;
+(void) goCredits;
+(void) goBest;
+(void) newGame:(NSString *)title;
+(void) gameOver:(NSString *)message;
+(void) newFase:(NSString *)message fase:(int)fase;



@end
