//
//  Player.h
//  KillYourBuddy
//
//  Created by João Henrique Machado Silva on 6/30/11.
//  Copyright 2011 Nurt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Player : CCSprite {
    int _lifes;
}

@property (nonatomic, assign) int lifes;

@end

@interface Player1 : Player {
}
+(id)newPlayer;
@end