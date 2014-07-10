//
//  MenuScene.m
//  Missile Command
//
//  Created by Jesus Magana on 7/10/14.
//  Copyright (c) 2014 ZeroLinux5. All rights reserved.
//

#import "MenuScene.h"

#import "MyScene.h"
#import "MultiScene.h"

@interface MenuScene () {
    CGSize sizeGlobal;
    UIButton *singlePlayerButton;
    UIButton *multiPlayerButton;
}

@end

@implementation MenuScene

- (id)initWithSize:(CGSize)size {
    self = [super initWithSize:size];
    
    if (self) {
        self.backgroundColor = [SKColor colorWithRed:(198.0/255.0) green:(220.0/255.0) blue:(54.0/255.0) alpha:1.0];
        
        SKSpriteNode *title = [SKSpriteNode spriteNodeWithImageNamed:@"title"];
        title.zPosition = 2;
        title.scale = 0.4;
        title.position = CGPointMake(size.width/2,size.height/2);
        [self addChild:title];
        
        sizeGlobal = size;
    }
    
    return self;
}
- (void)didMoveToView:(SKView *)view {
    UIImage *buttonImageNormal = [UIImage imageNamed:@"singleBtn.png"];
    singlePlayerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    singlePlayerButton.frame = CGRectMake(sizeGlobal.height/8, sizeGlobal.width/2+250, buttonImageNormal.size.width, buttonImageNormal.size.height);
    singlePlayerButton.backgroundColor = [UIColor clearColor];
    [singlePlayerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    UIImage *strechableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    [singlePlayerButton setBackgroundImage:strechableButtonImageNormal forState:UIControlStateNormal];
    [singlePlayerButton addTarget:self action:@selector(moveToSinglePlayerGame) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:singlePlayerButton];
    
    UIImage *buttonImageNormal2 = [UIImage imageNamed:@"multiBtn.png"];
    multiPlayerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    multiPlayerButton.frame = CGRectMake(sizeGlobal.height/2+100, sizeGlobal.width/2+250, buttonImageNormal2.size.width, buttonImageNormal2.size.height);
    multiPlayerButton.backgroundColor = [UIColor clearColor];
    [multiPlayerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    UIImage *strechableButtonImageNormal2 = [buttonImageNormal2 stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    [multiPlayerButton setBackgroundImage:strechableButtonImageNormal2 forState:UIControlStateNormal];
    [multiPlayerButton addTarget:self action:@selector(moveToMultiPlayerGame) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:multiPlayerButton];
}

- (void)moveToSinglePlayerGame {
    SKScene * scene = [MyScene sceneWithSize:self.view.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    SKTransition* transition = [SKTransition revealWithDirection:SKTransitionDirectionLeft duration:1];
    SKView * skView = (SKView *)self.view;
    [skView presentScene:scene transition:transition];
    
    [singlePlayerButton removeFromSuperview];
    [multiPlayerButton removeFromSuperview];
}
- (void)moveToMultiPlayerGame {
    SKScene * scene = [MultiScene sceneWithSize:self.view.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    SKTransition* transition = [SKTransition revealWithDirection:SKTransitionDirectionLeft duration:1];
    SKView * skView = (SKView *)self.view;
    [skView presentScene:scene transition:transition];
    
    [singlePlayerButton removeFromSuperview];
    [multiPlayerButton removeFromSuperview];
}

@end
