//
//  CreditosLayer.m
//  KillYourBuddy
//
//  Created by João Henrique Machado Silva on 7/7/11.
//  Copyright 2011 Nurt. All rights reserved.
//

#import "CreditosLayer.h"


@implementation CreditosLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	CreditosLayer *layer = [CreditosLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init{
	if( (self=[super initWithColor:ccc4(255,255,255,255)] )) {
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        CCSprite * bg = [CCSprite spriteWithFile:@"MenuBackground.jpg"];
        bg.position = ccp(bg.contentSize.width/2, winSize.height/2);
        [self addChild:bg];
        
        CCSprite * title = [CCSprite spriteWithFile:@"credits-title.png"];
        title.position = ccp(winSize.width/2, winSize.height/2+100);
        [self addChild: title];
        
        CCLabelTTF *developer = [CCLabelTTF labelWithString:@"Developer:" fontName:@"Marker Felt" fontSize:16];
        developer.position = ccp(winSize.width/2, winSize.height/2+30);
        [self addChild: developer];
        
        CCLabelTTF *joao = [CCLabelTTF labelWithString:@"João Henrique Machado Silva" fontName:@"Marker Felt" fontSize:24];
        joao.position = ccp(winSize.width/2, winSize.height/2+10);
        [self addChild: joao];
        
        CCLabelTTF *desginer = [CCLabelTTF labelWithString:@"Designer:" fontName:@"Marker Felt" fontSize:16];
        desginer.position = ccp(winSize.width/2, winSize.height/2-30);
        [self addChild: desginer];
        
        CCLabelTTF *olavo = [CCLabelTTF labelWithString:@"Olavo Machado" fontName:@"Marker Felt" fontSize:24];
        olavo.position = ccp(winSize.width/2, winSize.height/2-50);
        [self addChild: olavo];
        
        CCMenuItemImage *menuBtn = [CCMenuItemImage itemFromNormalImage:@"menu.png" selectedImage:@"menu-on.png" target:self selector:@selector(onMenu:)];
        CCMenu *menu = [CCMenu menuWithItems:menuBtn, nil];
        
        menu.position = ccp(winSize.width-70, 35);
        [menu alignItemsVerticallyWithPadding: 10.0f];
        [self addChild:menu z: 2];

	}
    return self;
}

- (void)onMenu:(id)sender{
    [MenuManager goMenu];
}

@end
