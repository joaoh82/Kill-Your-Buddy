//
//  TerceiraFaseLayer.m
//  KillYourBuddy
//
//  Created by João Henrique Machado Silva on 7/9/11.
//  Copyright 2011 Nurt. All rights reserved.
//

#import "TerceiraFaseLayer.h"


@implementation TerceiraFaseLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	SegundaFaseLayer *layer = [TerceiraFaseLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(void)addTarget {
    
    //CCSprite *target = [CCSprite spriteWithFile:@"Target.jpg" rect:CGRectMake(0, 0, 27, 40)]; 
    Monster *target = nil;
    int r = arc4random() % 4;
    if (r == 0) {
        target = [WeakAndFastMonster monster];
    }else if (r == 1) {
        target = [StrongAndSlowMonster monster];
    }else if (r == 2) {
        target = [JipeMonster monster];
    }else if (r == 3) {
        target = [StealthMonster monster];
    }
    
    // Determine where to spawn the target along the Y axis
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    int minY = target.contentSize.height/2+30;
    int maxY = (winSize.height - target.contentSize.height/2)-30;
    int rangeY = maxY - minY;
    int actualY = (arc4random() % rangeY) + minY;
    
    // Create the target slightly off-screen along the right edge,
    // and along a random position along the Y axis as calculated above
    target.position = ccp(winSize.width + (target.contentSize.width/2), actualY);
    
    if (target.monsterType == 0 || target.monsterType == 2) {
        [self addChild:target];
    }else if (target.monsterType == 3 || target.monsterType == 1) {
        [airLayer addChild:target];
    }
    
    // Determine speed of the target
    int minDuration = target.minMoveDuration; //2.0;
    int maxDuration = target.maxMoveDuration; //4.0;
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    
    // Create the actions
    id actionMove = [CCMoveTo actionWithDuration:actualDuration 
                                        position:ccp(-target.contentSize.width/2, actualY)];
    id actionMoveDone = [CCCallFuncN actionWithTarget:self 
                                             selector:@selector(spriteMoveFinished:)];
    [target runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
    
    target.tag = 1;
    [_targets addObject:target];
    
    if (target.monsterType == 1) {
        //SEQUENCIA PARA ANIMAR O MOVIMENTO DO AVIÃO
        CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"Airplane.png"];
        [airLayer addChild:spriteSheet];
        
        NSMutableArray *walkAnimFrames = [NSMutableArray array];
        for(int i = 1; i <= 7; ++i) {
            [walkAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"plane%d.png", i]]];
        }
        CCAnimation *walkAnim = [CCAnimation animationWithFrames:walkAnimFrames delay:0.2f];
        CCAction *walkAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkAnim restoreOriginalFrame:NO]];
        
        [target runAction:walkAction];
        [spriteSheet addChild:target];
        
        [walkAnimFrames release];
        [spriteSheet release];
        [walkAnim release];
        [walkAction release];
    }
}

-(void)spriteMoveFinished:(id)sender {
    CCSprite *sprite = (CCSprite *)sender;
    [self removeChild:sprite cleanup:YES];
    
    _player.lifes--;
    //[lblLifes setString:[NSString stringWithFormat:@"%d lifes", _player.lifes]];
    
    if (_player.lifes <= 0) {
        
        [[SimpleAudioEngine sharedEngine] playEffect:@"explosion.wav"];
        
        GameOverScene *gameOverScene = [GameOverScene node];
        [gameOverScene.layer.label setString:@"You Lost :["];
        [[CCDirector sharedDirector] replaceScene:gameOverScene];
    }else{
        [self updateLife];
    }
    
    if (sprite.tag == 1) { // target
        [_targets removeObject:sprite];
        
    } else if (sprite.tag == 2) { // projectile
        [_projectiles removeObject:sprite];
    }
}

-(void) updateLife{
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    [self removeChild:life cleanup:YES];
    
    if (_player.lifes == 3) {
        life = [CCSprite spriteWithFile:@"tank-life3.png"];
    }else if (_player.lifes == 2) {
        life = [CCSprite spriteWithFile:@"tank-life2.png"];
    }else if (_player.lifes == 1) {
        life = [CCSprite spriteWithFile:@"tank-life1.png"];
    }
    
    life.position = ccp(60, winSize.height-30);
    [self addChild:life];   
}

//METHOD CALLED AFTER ANY TOUCH ON THE SCREEN
- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (_nextProjectile != nil) return;
    
    // Choose one of the touches to work with
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    // Set up initial location of projectile
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    _nextProjectile = [[CCSprite spriteWithFile:@"Projectile2.png"] retain];
    _nextProjectile.position = ccp(50, winSize.height/2);
    
    // Determine offset of location to projectile
    int offX = location.x - _nextProjectile.position.x;
    int offY = location.y - _nextProjectile.position.y;
    
    // Bail out if we are shooting down or backwards
    if (offX <= 0) return;
    
    // Play a sound!
    [[SimpleAudioEngine sharedEngine] playEffect:@"oneshoot.m4a"];
    
    // Determine where we wish to shoot the projectile to
    int realX = winSize.width + (_nextProjectile.contentSize.width/2);
    float ratio = (float) offY / (float) offX;
    int realY = (realX * ratio) + _nextProjectile.position.y;
    CGPoint realDest = ccp(realX, realY);
    
    // Determine the length of how far we're shooting
    int offRealX = realX - _nextProjectile.position.x;
    int offRealY = realY - _nextProjectile.position.y;
    float length = sqrtf((offRealX*offRealX)+(offRealY*offRealY));
    float velocity = 480/1; // 480pixels/1sec
    float realMoveDuration = length/velocity;
    
    // Determine angle to face
    float angleRadians = atanf((float)offRealY / (float)offRealX);
    float angleDegrees = CC_RADIANS_TO_DEGREES(angleRadians);
    float cocosAngle = -1 * angleDegrees;
    float rotateSpeed = 0.5 / M_PI; // Would take 0.5 seconds to rotate 0.5 radians, or half a circle
    float rotateDuration = fabs(angleRadians * rotateSpeed);    
    [_player runAction:[CCSequence actions:
                        [CCRotateTo actionWithDuration:rotateDuration angle:cocosAngle],
                        [CCCallFunc actionWithTarget:self selector:@selector(finishShoot)],
                        nil]];
    
    // Move projectile to actual endpoint
    [_nextProjectile runAction:[CCSequence actions:
                                [CCMoveTo actionWithDuration:realMoveDuration position:realDest],
                                [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveFinishedProjectile:)],
                                nil]];
    
    // Add to projectiles array
    _nextProjectile.tag = 2;
    
}


- (void)finishShoot {
    
    // Ok to add now - we've finished rotation!
    [self addChild:_nextProjectile];
    [_projectiles addObject:_nextProjectile];
    
    // Release
    [_nextProjectile release];
    _nextProjectile = nil;
    
}

- (void) scroll:(ccTime)dt {
    
    CGPoint backgroundScrollVel = ccp(-240, 0);
    _backgroundNode.position = ccpAdd(_backgroundNode.position, ccpMult(backgroundScrollVel, dt));
    
    // Add at end of your update method
    NSArray *spaceDusts = [NSArray arrayWithObjects:background, background2, nil];
    for (CCSprite *spaceDust in spaceDusts) {
        if ([_backgroundNode convertToWorldSpace:spaceDust.position].x < -(spaceDust.contentSize.width/2)) {
            [_backgroundNode incrementOffset:ccp(2*spaceDust.contentSize.width,0) forChild:spaceDust];
        }
    }
    
}

- (void)pauseGame:(id)sender{
    
    [[CCDirector sharedDirector] pause];
    
    if (![[Common appDelegate] gamePaused]) {
        PauseLayer *layer = [PauseLayer node];
        layer.tag = 100;
        [self addChild:layer];
        [[Common appDelegate] setGamePaused:YES];
    }
    
}

-(void)updateState:(id)sender{
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    // Determine speed of the state
    int actualDuration = 300.0;
    
    // Create the actions
    id actionMove = [CCMoveTo actionWithDuration:actualDuration 
                                        position:ccp(winSize.width+200, winSize.height-300)];
    id actionMoveDone = [CCCallFuncN actionWithTarget:self 
                                             selector:@selector(stateFinished:)];
    [state runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
}

-(void)stateFinished:(id)sender {
    
    if (_player.lifes > 0) {
        
        GameOverScene *gameOverScene = [GameOverScene node];
        [gameOverScene.layer.label setString:@"You Won!"];
        [[CCDirector sharedDirector] replaceScene:gameOverScene];
        
    }
    
}

-(void)gameLogic:(ccTime)dt {
    [self addTarget];
}

- (void)update:(ccTime)dt {
    
    NSMutableArray *projectilesToDelete = [[NSMutableArray alloc] init];
    NSMutableArray *targetsToDelete = [[NSMutableArray alloc] init];
    
    CGRect playerRect = CGRectMake(_player.position.x - (_player.contentSize.width/2), 
                                   _player.position.y - (_player.contentSize.height/2), 
                                   _player.contentSize.width,
                                   _player.contentSize.height);
    
    for (Monster *target in _targets) {
        CGRect targetRect = CGRectMake(
                                       target.position.x - (target.contentSize.width/2), 
                                       target.position.y - (target.contentSize.height/2), 
                                       target.contentSize.width, 
                                       target.contentSize.height);
        
        if (CGRectIntersectsRect(playerRect, targetRect)) {
            [[SimpleAudioEngine sharedEngine] playEffect:@"booom.wav"];
            
            [_targets removeObject:target];
            if (target.monsterType != 1) {
                [self removeChild:target cleanup:YES];	
            }else{
                [airLayer removeChild:target cleanup:YES];	
            }
            
            _player.lifes--;
            //[lblLifes setString:[NSString stringWithFormat:@"%d lifes", _player.lifes]];
            
            if (_player.lifes <= 0) {
                
                [[SimpleAudioEngine sharedEngine] playEffect:@"explosion.wav"];
                _projectilesDestroyed = 0;
                
                //SEQUENCIA PARA ANIMAR A EXPLOSÃO DO JOGADOR                
                CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"Explosion_Sprite.png"];
                [self addChild:spriteSheet];
                
                NSMutableArray *walkAnimFrames = [NSMutableArray array];
                for(int i = 1; i <= 4; ++i) {
                    [walkAnimFrames addObject:
                     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"explosion%d.png", i]]];
                }
                CCAnimation *walkAnim = [CCAnimation animationWithFrames:walkAnimFrames delay:0.1f];
                
                CCAction *walkAction = [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:walkAnim restoreOriginalFrame:NO] times:1];
                
                id actionDone = [CCCallFuncN actionWithTarget:self 
                                                     selector:@selector(gameOverLose:)];
                [_player runAction:[CCSequence actions:walkAction, actionDone, nil]];
                [spriteSheet addChild:_player];
                
                [walkAnimFrames release];
                [spriteSheet release];
                [walkAnim release];
                [walkAction release];
            }else{
                [self updateLife];
            }
        }						
    }
    
    for (CCSprite *projectile in _projectiles) {
        CGRect projectileRect = CGRectMake(
                                           projectile.position.x - (projectile.contentSize.width/2), 
                                           projectile.position.y - (projectile.contentSize.height/2), 
                                           projectile.contentSize.width, 
                                           projectile.contentSize.height);
        
        BOOL monsterHit = FALSE;
        
        for (Monster *target in _targets) {
            CGRect targetRect = CGRectMake(
                                           target.position.x - (target.contentSize.width/2), 
                                           target.position.y - (target.contentSize.height/2), 
                                           target.contentSize.width, 
                                           target.contentSize.height);
            
            if (CGRectIntersectsRect(projectileRect, targetRect)) {
                //[targetsToDelete addObject:target];				
                monsterHit = TRUE;
                Monster *monster = (Monster *)target;
                monster.hp--;
                if (monster.hp <= 0) {
                    [targetsToDelete addObject:target];
                }
                break;
            }						
        }
        
        if (monsterHit) {
            [projectilesToDelete addObject:projectile];
            [[SimpleAudioEngine sharedEngine] playEffect:@"explosion.caf"];
        }
        
        for (CCSprite *projectile in projectilesToDelete) {
            [_projectiles removeObject:projectile];
            [self removeChild:projectile cleanup:YES];
            
        }
        
        for (Monster *target in targetsToDelete) {
            
            [[Common appDelegate] set_pointMade:[[Common appDelegate] _pointMade]+target.pointsGain];
            
            [lblPoints setString:[NSString stringWithFormat:@"%d points", [[Common appDelegate] _pointMade]]];
            
            [_targets removeObject:target];
            
            [[SimpleAudioEngine sharedEngine] playEffect:@"booom.wav"];
            
            //SEQUENCIA PARA ANIMAR A EXPLOSÃO DO ALVO           
            CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"Explosion_Sprite.png"];
            if (target.monsterType != 1) {
                [self addChild:spriteSheet];
            }else{
                [airLayer addChild:spriteSheet];
            }
            
            
            NSMutableArray *walkAnimFrames = [NSMutableArray array];
            for(int i = 1; i <= 4; ++i) {
                [walkAnimFrames addObject:
                 [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"explosion%d.png", i]]];
            }
            CCAnimation *walkAnim = [CCAnimation animationWithFrames:walkAnimFrames delay:0.1f];
            
            CCAction *walkAction = [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:walkAnim restoreOriginalFrame:NO] times:1];
            
            id actionDone = [CCCallFuncN actionWithTarget:self 
                                                 selector:@selector(removeTarget:)];
            [target runAction:[CCSequence actions:walkAction, actionDone, nil]];
            [spriteSheet addChild:target];
            
            [walkAnimFrames release];
            [spriteSheet release];
            [walkAnim release];
            [walkAction release];
            
            //[self removeChild:target cleanup:YES];	
            
            _projectilesDestroyed++;
        }
    }
    
    [targetsToDelete release];
    [projectilesToDelete release];
}

-(void)removeTarget:(Monster*)targetSended{
    
    if (targetSended.monsterType != 1) {
        [self removeChild:targetSended cleanup:YES];	
    }else{
        [airLayer removeChild:targetSended cleanup:YES];
    }
    
}

-(void)gameOverLose:(ccTime)delta{
    
    [MenuManager gameOver:@"You lost :["];
    
    [self unschedule:_cmd];
}

// on "init" you need to initialize your instance
-(id) init
{
	if( (self=[super initWithColor:ccc4(255,255,255,255)] )) {
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Explosion_Sprite.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Airplane.plist"];
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        pausePlay = [CCMenuItemImage itemFromNormalImage:@"pause.png" selectedImage:@"pauseOn.png" target:self selector:@selector(pauseGame:)];
        menu = [CCMenu menuWithItems:pausePlay, nil];
        menu.position = ccp(winSize.width-30, winSize.height-30);
        [self addChild:menu z: 2];
        
        _backgroundNode = [CCParallaxNode node];
        [self addChild:_backgroundNode z:0];
        
        //create both sprite to handle background
        background = [CCSprite spriteWithFile:@"background.jpg"];
        background2 = [CCSprite spriteWithFile:@"background.jpg"];
        
        // 3) Determine relative movement speeds for space dust and background
        CGPoint dustSpeed = ccp(0.1, 0.1);
        CGPoint bgSpeed = ccp(0.05, 0.05);
        
        [_backgroundNode addChild:background z:0 parallaxRatio:dustSpeed positionOffset:ccp(0,winSize.height/2)];
        [_backgroundNode addChild:background2 z:0 parallaxRatio:dustSpeed positionOffset:ccp(background.contentSize.width,winSize.height/2)];      
        
        //add schedule to move backgrounds
        [self schedule:@selector(scroll:)];
        
        airLayer = [CCLayer node];
        [self addChild:airLayer z:1];
        
        _targets = [[NSMutableArray alloc] init];
        _projectiles = [[NSMutableArray alloc] init];
        
        //_player = [[CCSprite spriteWithFile:@"Player2.png"] retain];
        _player = [Player1 newPlayer];
        _player.lifes = [[[Common appDelegate] _player] lifes];
        _player.position = ccp(_player.contentSize.width/2, winSize.height/2);
        [self addChild:_player];		
        
        [self schedule:@selector(gameLogic:) interval:0.8];
        
        [self schedule:@selector(update:)];
        
        self.isTouchEnabled = YES;
        
        lblPoints = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d points", [[Common appDelegate] _pointMade]] fontName:@"Marker Felt" fontSize:16];
        lblPoints.color = ccORANGE;
        lblPoints.position = ccp(winSize.width-100, winSize.height-30);
        [self addChild:lblPoints];
        
        life = [CCSprite spriteWithFile:@"tank-life3.png"];
        life.position = ccp(60, winSize.height-30);
        [self addChild:life];
        [self updateLife];
        
        if ([[Common appDelegate] soundGame]) {
            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"bamboozled.m4a"];
        }
        
        CCSprite *tankBackground = [CCSprite spriteWithFile:@"tankBackground.png"];
        tankBackground.position = ccp(winSize.width/2,15);
        [airLayer addChild:tankBackground];
        
        state = [CCSprite spriteWithFile:@"tank-small.png"];
        state.position = ccp(20, winSize.height-305);
        [airLayer addChild:state];
        [self schedule:@selector(updateState:)];
        
    }
    return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
    
    [_targets release];
    _targets = nil;
    [_projectiles release];
    _projectiles = nil;
    
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
