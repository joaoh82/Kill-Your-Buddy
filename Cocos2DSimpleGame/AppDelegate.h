//
//  AppDelegate.h
//  Cocos2DSimpleGame
//
//  Created by João Henrique Machado Silva on 6/24/11.
//  Copyright Nurt 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
