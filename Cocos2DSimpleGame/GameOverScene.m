//
//  GameOverScene.m
//  Cocos2DSimpleGame
//
//  Created by João Henrique Machado Silva on 6/24/11.
//  Copyright 2011 Nurt. All rights reserved.
//

#import "GameOverScene.h"
#import "PrimeiraFaseLayer.h"
#import "MenuManager.h"

@implementation GameOverScene
@synthesize layer = _layer;


- (id)init {
    
    if ((self = [super init])) {
        self.layer = [GameOverLayer node];
        [self addChild:_layer];
    }
    return self;
}

- (void)dealloc {
    [_layer release];
    _layer = nil;
    [super dealloc];
}

@end

@implementation GameOverLayer
@synthesize label = _label;
@synthesize facebook;

-(id) init
{
    if( (self=[super initWithColor:ccc4(255,255,255,255)] )) {
        
        [[NSUserDefaults standardUserDefaults] setInteger:[[Common appDelegate] _pointMade] forKey:@"lastScore"];
        
        int bestScoreValue = [[[NSUserDefaults standardUserDefaults] valueForKey:@"bestScore"] integerValue];        
        if ([[Common appDelegate] _pointMade] > bestScoreValue) {
            [[NSUserDefaults standardUserDefaults] setInteger:[[Common appDelegate] _pointMade] forKey:@"bestScore"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            bestScoreValue = [[Common appDelegate] _pointMade];
        }
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        self.label = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:32];
        _label.color = ccc3(0,0,0);
        _label.position = ccp(winSize.width/2, winSize.height/2);
        //[self addChild:_label z:1];
        
        CCSprite * bg = [CCSprite spriteWithFile:@"MenuBackground.jpg"];
        bg.position = ccp(bg.contentSize.width/2, winSize.height/2);
        [self addChild:bg z:0];
        
        CCSprite * gameover = [CCSprite spriteWithFile:@"game-over.png"];
        gameover.position = ccp(winSize.width/2, winSize.height-64);
        [self addChild:gameover z:1];
        
        CCSprite * yourscore = [CCSprite spriteWithFile:@"yourscore.png"];
        yourscore.position = ccp(winSize.width/2-111, winSize.height/2);
        [self addChild:yourscore z:1];
        
        CCLabelTTF *yourScore = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d points", [[Common appDelegate] _pointMade]] fontName:@"Marker Felt" fontSize:32];
        yourScore.color = ccc3(255,255,255);
        yourScore.position = ccp(winSize.width/2+100, winSize.height/2);
        [self addChild:yourScore z:1];
        
        CCSprite * bestscore = [CCSprite spriteWithFile:@"bestscore.png"];
        bestscore.position = ccp(winSize.width/2-111, winSize.height/2-50);
        [self addChild:bestscore z:1];
        
        CCLabelTTF *bestScore = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d points", bestScoreValue] fontName:@"Marker Felt" fontSize:32];
        bestScore.color = ccc3(255,255,255);
        bestScore.position = ccp(winSize.width/2+100, winSize.height/2-50);
        [self addChild:bestScore z:1];
        
        CCMenuItemImage *play = [CCMenuItemImage itemFromNormalImage:@"play.png" selectedImage:@"play-on.png" target:self selector:@selector(onPlay:)];
        CCMenuItemImage *quit = [CCMenuItemImage itemFromNormalImage:@"giveup.png" selectedImage:@"giveup-on.png" target:self selector:@selector(onQuit:)];
        CCMenu *menu = [CCMenu menuWithItems:play, quit, nil];
        
        menu.position = ccp(winSize.width-70, 50);
        [menu alignItemsVerticallyWithPadding: 10.0f];
        [self addChild:menu z: 2];
        
        CCMenuItemImage *facebookMenu = [CCMenuItemImage itemFromNormalImage:@"facebook-wood.png" selectedImage:@"facebook-wood-on.png" target:self selector:@selector(shareFacebook:)];
        CCMenu *menu2 = [CCMenu menuWithItems:facebookMenu, nil];
        menu2.position = ccp(winSize.width-30, winSize.height-30);
        [self addChild:menu2 z: 2];
        
	}
    return self;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    
    return [facebook handleOpenURL:url]; 
}

- (void)fbDidLogin {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[facebook accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[facebook expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    
    
}

-(void)shareFacebook:(id)sender{
    facebook = [[Facebook alloc] initWithAppId:@"161772263891893"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"] 
        && [defaults objectForKey:@"FBExpirationDateKey"]) {
        facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
    }
    
    if (![facebook isSessionValid]) {
        //[facebook authorize:nil delegate:self];
        [facebook authorizeWithFBAppAuth:YES safariAuth:NO];
    }
    
    NSString *message = [NSString stringWithFormat:@"I was just playing the game Kill Your Buddy on my iPhone and got %d points this time. You should get it from the Apple App Store.", [[Common appDelegate] _pointMade]];
    NSString *formatedMessage = [message stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //[facebook dialog:@"feed?message=I%20was%20just%20playing%20the%20game%20Kill%20Your%20Buddy%20on%20my%20iPhone.%20You%20should%20get%20it%20from%20the%20Apple%20App%20Store.&name=Kill%20Your%20Buddy"andDelegate:self];
    [facebook dialog:[NSString stringWithFormat:@"feed?message=%@&name=Kill%20Your%20Buddy",formatedMessage] andDelegate:self];
    //[facebook dialog:@"feed" andDelegate:self];
}

- (void)onQuit:(id)sender{
    [MenuManager goMenu];
}

- (void)onPlay:(id)sender{
    
    [MenuManager newGame:@"Get ready to rumble!"];
}

- (void)dealloc {
    [_label release];
    _label = nil;
    [super dealloc];
}

@end