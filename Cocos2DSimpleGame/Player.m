//
//  Player.m
//  KillYourBuddy
//
//  Created by João Henrique Machado Silva on 6/30/11.
//  Copyright 2011 Nurt. All rights reserved.
//

#import "Player.h"


@implementation Player

@synthesize lifes = _lifes;

@end

@implementation Player1

+ (id)newPlayer {
    
    Player1 *player = nil;
    if ((player = [[[super alloc] initWithFile:@"Player2.png"] autorelease])) {
        player.lifes = LIFES;
    }
    return player;
    
}

@end