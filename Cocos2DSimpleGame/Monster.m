//
//  Monster.m
//  Cocos2DSimpleGame
//
//  Created by João Henrique Machado Silva on 6/28/11.
//  Copyright 2011 Nurt. All rights reserved.
//

#import "Monster.h"


@implementation Monster

@synthesize hp = _curHp;
@synthesize minMoveDuration = _minMoveDuration;
@synthesize maxMoveDuration = _maxMoveDuration;
@synthesize monsterType = _monsterType;
@synthesize pointsGain = _pointsGain;

@end

@implementation WeakAndFastMonster

+ (id)monster {
    
    WeakAndFastMonster *monster = nil;
    if ((monster = [[[super alloc] initWithFile:@"tank2.png"] autorelease])) {
        monster.hp = 1;
        monster.minMoveDuration = 3;
        monster.maxMoveDuration = 6;
        monster.monsterType = 0;
        monster.pointsGain = 5;
    }
    return monster;
    
}

@end

@implementation StrongAndSlowMonster

+ (id)monster {
    
    StrongAndSlowMonster *monster = nil;
    if ((monster = [[[super alloc] initWithFile:@"Plane.png"] autorelease])) {
        monster.hp = 3;
        monster.minMoveDuration = 6;
        monster.maxMoveDuration = 12;
        monster.monsterType = 1;
        monster.pointsGain = 10;
    }
    return monster;
    
}

@end

@implementation JipeMonster

+ (id)monster {
    
    StrongAndSlowMonster *monster = nil;
    if ((monster = [[[super alloc] initWithFile:@"jipe.png"] autorelease])) {
        monster.hp = 2;
        monster.minMoveDuration = 4;
        monster.maxMoveDuration = 8;
        monster.monsterType = 2;
        monster.pointsGain = 8;
    }
    return monster;
    
}

@end

@implementation StealthMonster

+ (id)monster {
    
    StrongAndSlowMonster *monster = nil;
    if ((monster = [[[super alloc] initWithFile:@"plane-stealth.png"] autorelease])) {
        monster.hp = 4;
        monster.minMoveDuration = 4;
        monster.maxMoveDuration = 8;
        monster.monsterType = 3;
        monster.pointsGain = 15;
    }
    return monster;
    
}

@end
