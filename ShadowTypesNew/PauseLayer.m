//
//  PauseLayer.m
//  ShadowTypesNew
//
//  Created by neurologik on 11/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//  TODO: implement a touch area for the quit function in ccTouchesBegan


#import "PauseLayer.h"
#import "GameScene.h"
#import "MainMenuScene.h"
#import "AppDelegate.h"

@interface PauseLayer (Private)
  -(void)resumeGame:(id)sender;
  -(void)quitGame:(id)sender;
@end


@implementation PauseLayer

- (id) init {
  CGSize screenSize = [[CCDirector sharedDirector] winSize];
  ccColor4B c = {0,0,0,200};
    
  if ((self = [super initWithColor:c])) {
    self.isTouchEnabled = YES;
    CCLabelBMFont *paused = [CCLabelBMFont labelWithString:@"PAUSED" fntFile:@"weaponFeedbackLarge.fnt"];
    [paused setColor:ccc3(219,58,81)];

    [paused setPosition:ccp(screenSize.width / 2, ((screenSize.height / 2) + 50))];
    [[paused texture] setAliasTexParameters];
    
    CCLabelBMFont * resumeLabel = [CCLabelBMFont labelWithString:@"resume" fntFile:@"weaponFeedback.fnt"];
    CCLabelBMFont * quitLabel = [CCLabelBMFont labelWithString:@"quit" fntFile:@"weaponFeedback.fnt"];
    
    [[resumeLabel texture] setAliasTexParameters];
    [[quitLabel texture] setAliasTexParameters];
    
    CCMenuItemLabel * resume = [CCMenuItemLabel itemWithLabel:resumeLabel target:self selector:@selector(resumeGame:)];
		CCMenuItemLabel * quit = [CCMenuItemLabel itemWithLabel:quitLabel target:self selector:@selector(quitGame:)];
    
    CCMenu * menu = [CCMenu menuWithItems:resume, quit, nil];
		[menu alignItemsVerticallyWithPadding:10];
    [menu setPosition:ccp(screenSize.width / 2, ((screenSize.height / 2) - 20))];
    
    [self addChild:paused];
    [self addChild: menu];
  }
  
  return self;
}

-(void)resumeGame:(id)sender {
  GameLayer *game = [GameLayer sharedGameLayer];
  [game resume];
  [game removeChildByTag:42 cleanup:NO];
}

-(void)quitGame:(id)sender {
  [AppDelegate get].paused = NO;
  [[CCDirector sharedDirector] resume];
  [[CCDirector sharedDirector] replaceScene:[MainMenuScene node]];

}

-(void) dealloc {
  [super dealloc];
}

@end
