//
//  MenuScene.m
//  Missile Command
//
//  Created by Jesus Magana on 7/10/14.
//  Copyright (c) 2014 ZeroLinux5. All rights reserved.
//

#import "MenuScene.h"

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
    }
    
    return self;
}

@end
