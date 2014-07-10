//
//  MyScene.m
//  Missile Command
//
//  Created by Jesus Magana on 7/10/14.
//  Copyright (c) 2014 ZeroLinux5. All rights reserved.
//

#import "MyScene.h"

@interface MyScene () {
    CGSize sizeGlobal;
    
    SKLabelNode *labelflowerBullets1;
    SKLabelNode *labelflowerBullets2;
    SKLabelNode *labelflowerBullets3;
    SKLabelNode *labelMissilesExploded;
    int position;
    int monstersDead;
    int missileExploded;
    
    int flowerBullets1;
    int flowerBullets2;
    int flowerBullets3;
}

@end

@implementation MyScene

- (id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [SKColor colorWithRed:(198.0/255.0) green:(220.0/255.0) blue:(54.0/255.0) alpha:1.0];
        
        position = size.width/3;
        sizeGlobal = size;
        [self addFlowerCommand];
        
        //Label Informing Missiles Exploded
        labelMissilesExploded = [SKLabelNode labelNodeWithFontNamed:@"Hiragino-Kaku-Gothic-ProN"];
        labelMissilesExploded.text = [NSString stringWithFormat:@"Missiles Exploded: %d",missileExploded];
        labelMissilesExploded.fontSize = 30;
        labelMissilesExploded.position = CGPointMake(size.width/2,size.height-labelMissilesExploded.frame.size.height);
        labelMissilesExploded.zPosition = 3;
        [self addChild:labelMissilesExploded];
        
        flowerBullets1 = 10;
        flowerBullets2 = 10;
        flowerBullets3 = 10;
        
        labelflowerBullets1 = [SKLabelNode labelNodeWithFontNamed:@"Hiragino-Kaku-Gothic-ProN"];
        labelflowerBullets1.text = [NSString stringWithFormat:@"%d",flowerBullets1];
        labelflowerBullets1.fontSize = 30;
        labelflowerBullets1.position = CGPointMake(position-position/2,labelflowerBullets1.frame.size.height/2);
        labelflowerBullets1.zPosition = 3;
        [self addChild:labelflowerBullets1];
        
        labelflowerBullets2 = [SKLabelNode labelNodeWithFontNamed:@"Hiragino-Kaku-Gothic-ProN"];
        labelflowerBullets2.text = [NSString stringWithFormat:@"%d",flowerBullets2];
        labelflowerBullets2.fontSize = 30;
        labelflowerBullets2.position = CGPointMake(position*2-position/2,labelflowerBullets2.frame.size.height/2);
        labelflowerBullets2.zPosition = 3;
        [self addChild:labelflowerBullets2];
        
        labelflowerBullets3 = [SKLabelNode labelNodeWithFontNamed:@"Hiragino-Kaku-Gothic-ProN"];
        labelflowerBullets3.text = [NSString stringWithFormat:@"%d",flowerBullets3];
        labelflowerBullets3.fontSize = 30;
        labelflowerBullets3.position = CGPointMake(position*3-position/2,labelflowerBullets3.frame.size.height/2);
        labelflowerBullets3.zPosition = 3;
        [self addChild:labelflowerBullets3];
        
        // Add Monsters
        [self addMonstersBetweenSpace:1];
        [self addMonstersBetweenSpace:2];
        
        // Create Actions
        SKAction *wait = [SKAction waitForDuration:2];
        SKAction *createMissiles = [SKAction runBlock:^{
            [self addMissilesFromSky:size];
        }];
        
        SKAction *updateMissiles = [SKAction sequence:@[wait, createMissiles]];
        [self runAction:[SKAction repeatActionForever:updateMissiles]];

    }
    
    return self;
}

- (void)addFlowerCommand {
    for (int i = 1; i <= 3; i++) {
        SKSpriteNode *flower = [SKSpriteNode spriteNodeWithImageNamed:@"flower.png"];
        flower.zPosition = 2;
        flower.position = CGPointMake(position * i - position / 2, flower.size.height / 2);
        [self addChild:flower];
    }
}

- (void)addMonstersBetweenSpace:(int)spaceOrder {
    for (int i = 0; i< 3; i++) {
        int giveDistanceToMonsters = 60 * i -60;
        int randomMonster = [self getRandomNumberBetween:0 to:1];
        
        SKSpriteNode *monster;
        
        if (randomMonster == 0) {
            monster = [SKSpriteNode spriteNodeWithImageNamed:@"protectCreature4"];
        } else {
            monster = [SKSpriteNode spriteNodeWithImageNamed:@"protectCreature2"];
        }
        
        monster.zPosition = 2;
        monster.position = CGPointMake(position * spaceOrder - giveDistanceToMonsters, monster.size.height / 2);
        
        [self addChild:monster];
    }
}

- (int)getRandomNumberBetween:(int)from to:(int)to {
    return (int)from + arc4random() % (to - from + 1);
}

- (void)addMissilesFromSky:(CGSize)size {
    int numberMissiles = [self getRandomNumberBetween:0 to:3];
    
    for (int i = 0; i < numberMissiles; i++) {
        SKSpriteNode *missile;
        missile = [SKSpriteNode spriteNodeWithImageNamed:@"enemyMissile"];
        missile.scale = 0.6;
        missile.zPosition = 1;
        
        int startPoint = [self getRandomNumberBetween:0 to:size.width];
        missile.position = CGPointMake(startPoint, size.height);
        
        int endPoint = [self getRandomNumberBetween:0 to:size.width];
        
        SKAction *move =[SKAction moveTo:CGPointMake(endPoint, 0) duration:15];
        SKAction *remove = [SKAction removeFromParent];
        [missile runAction:[SKAction sequence:@[move,remove]]];
        
        [self addChild:missile];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        // Return if User Taps Below a Flower
        if (location.y < 120) return;
        
        int bulletBeginning = 0;
        
        if (location.x >= 0 && location.x < position) {
            bulletBeginning = position-position/2;
            
            if (flowerBullets1 > 0)
                flowerBullets1--;
            else{
                if(flowerBullets1 == 0 && flowerBullets2 > 0){
                    flowerBullets2--;
                    [labelflowerBullets2 setText:[NSString stringWithFormat:@"%d",flowerBullets2]];
                    bulletBeginning = [self positionOfWhichFlowerShouldBegin:2];
                }
                else if(flowerBullets3 > 0){
                    flowerBullets3--;
                    [labelflowerBullets3 setText:[NSString stringWithFormat:@"%d",flowerBullets3]];
                    bulletBeginning =[self positionOfWhichFlowerShouldBegin:3];
                }
                else{
                    return;
                }
            }
            [labelflowerBullets1 setText:[NSString stringWithFormat:@"%d",flowerBullets1]];
        }
        else if((location.x >= position && location.x < position*2)){
            bulletBeginning = position*2-position/2;
            if(flowerBullets2 > 0)
                flowerBullets2--;
            else{
                if(location.x < sizeGlobal.width/2){
                    if(flowerBullets1 > 0){
                        flowerBullets1--;
                        [labelflowerBullets1 setText:[NSString stringWithFormat:@"%d",flowerBullets1]];
                        bulletBeginning =[self positionOfWhichFlowerShouldBegin:1];
                    }
                    else if (flowerBullets3 > 0){
                        flowerBullets3--;
                        [labelflowerBullets3 setText:[NSString stringWithFormat:@"%d",flowerBullets3]];
                        bulletBeginning =[self positionOfWhichFlowerShouldBegin:3];
                    }
                    else{
                        return;
                    }
                }
                else{
                    if(flowerBullets3 > 0){
                        flowerBullets3--;
                        [labelflowerBullets3 setText:[NSString stringWithFormat:@"%d",flowerBullets3]];
                        bulletBeginning =[self positionOfWhichFlowerShouldBegin:3];
                    }
                    else if (flowerBullets1 > 0){
                        flowerBullets1--;
                        [labelflowerBullets1 setText:[NSString stringWithFormat:@"%d",flowerBullets1]];
                        bulletBeginning =[self positionOfWhichFlowerShouldBegin:1];
                    }
                    else{
                        return;
                    }
                }
                
            }
            [labelflowerBullets2 setText:[NSString stringWithFormat:@"%d",flowerBullets2]];
        }
        else{
            bulletBeginning = position*3-position/2;
            if(flowerBullets3 > 0)
                flowerBullets3--;
            else{
                if(flowerBullets3 == 0 && flowerBullets2 > 0){
                    flowerBullets2--;
                    [labelflowerBullets2 setText:[NSString stringWithFormat:@"%d",flowerBullets2]];
                    bulletBeginning =[self positionOfWhichFlowerShouldBegin:2];
                }
                else if(flowerBullets1 > 0){
                    flowerBullets1--;
                    [labelflowerBullets1 setText:[NSString stringWithFormat:@"%d",flowerBullets1]];
                    bulletBeginning =[self positionOfWhichFlowerShouldBegin:1];
                }
                else{
                    return;
                }
            }
            [labelflowerBullets3 setText:[NSString stringWithFormat:@"%d",flowerBullets3]];
        }
        
        SKSpriteNode *bullet = [SKSpriteNode spriteNodeWithImageNamed:@"flowerBullet"];
        bullet.zPosition = 1;
        bullet.scale = 0.6;
        bullet.position = CGPointMake(bulletBeginning,110);
        bullet.color = [SKColor redColor];
        bullet.colorBlendFactor = 0.5;
        
        float duration = (2 * location.y)/sizeGlobal.width;
        
        SKAction *move =[SKAction moveTo:CGPointMake(location.x,location.y) duration:duration];
        SKAction *remove = [SKAction removeFromParent];
        
        [bullet runAction:[SKAction sequence:@[move,remove]]];
        [self addChild:bullet];
    }
}

- (int)positionOfWhichFlowerShouldBegin:(int)number {
    return position * number - position / 2;
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
