//
//  TituloFaseLayer.h
//  KillYourBuddy
//
//  Created by João Henrique Machado Silva on 7/4/11.
//  Copyright 2011 Nurt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "PrimeiraFaseLayer.h"
#import "SegundaFaseLayer.h"
#import "TerceiraFaseLayer.h"

@interface TituloFaseLayer : CCLayerColor {
    CCLabelTTF *title;
    int nextLevel;
}

@property (nonatomic, retain) CCLabelTTF *title;
@property (nonatomic) int nextLevel;

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
