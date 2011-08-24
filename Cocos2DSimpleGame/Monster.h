//
//  Monster.h
//  Cocos2DSimpleGame
//
//  Created by João Henrique Machado Silva on 6/28/11.
//  Copyright 2011 Nurt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Monster : CCSprite {
    
    int _curHp;
    int _minMoveDuration;
    int _maxMoveDuration;
    int _monsterType;
    int _pointsGain;
}

@property (nonatomic, assign) int hp;
@property (nonatomic, assign) int minMoveDuration;
@property (nonatomic, assign) int maxMoveDuration;
@property (nonatomic, assign) int monsterType;
@property (nonatomic, assign) int pointsGain;

@end

@interface WeakAndFastMonster : Monster {
}
+(id)monster;
@end

@interface StrongAndSlowMonster : Monster {
}
+(id)monster;
@end

@interface JipeMonster : Monster {
}
+(id)monster;
@end

@interface StealthMonster : Monster {
}
+(id)monster;
@end
