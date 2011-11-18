//
//  UIImage+Sprite.h
//
//  Created by Rafal Sroka on 11-11-17.
//  Copyright (c) 2011 Rafal Sroka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage (Sprite)

-(NSArray *)spritesWithSpriteSheetImage:(UIImage *)image spriteSize:(CGSize)size;
-(NSArray *)spritesWithSpriteSheetImage:(UIImage *)image inRange:(NSRange)range spriteSize:(CGSize)size;
@end