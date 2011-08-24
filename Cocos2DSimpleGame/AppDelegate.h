//
//  AppDelegate.h
//  Cocos2DSimpleGame
//
//  Created by João Henrique Machado Silva on 6/24/11.
//  Copyright Nurt 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"
#import "FBConnect.h"

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
    
    int _pointMade;
    Player *_player;
    
    BOOL soundGame;
    BOOL gamePaused;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) Player *_player;

@property (nonatomic) int _pointMade;

@property (nonatomic) BOOL soundGame;
@property (nonatomic) BOOL gamePaused;

@end

@interface UIViewController (KillYourBuddy)
- (AppDelegate *)appDelegate;
@end
