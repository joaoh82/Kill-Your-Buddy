//
//  GameOverScene.h
//  Cocos2DSimpleGame
//
//  Created by João Henrique Machado Silva on 6/24/11.
//  Copyright 2011 Nurt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Facebook.h"

@interface GameOverLayer : CCLayerColor <FBDialogDelegate, FBSessionDelegate> {
    CCLabelTTF *_label;
    
    Facebook *facebook;
}
@property (nonatomic, retain) CCLabelTTF *label;

@property (nonatomic, retain) Facebook *facebook;
@end

@interface GameOverScene : CCScene {
    GameOverLayer *_layer;
}
@property (nonatomic, retain) GameOverLayer *layer;
@end
