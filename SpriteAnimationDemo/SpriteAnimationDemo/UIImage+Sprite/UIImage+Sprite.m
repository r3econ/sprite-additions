//
//  UIImage+Sprite.m
//
//  Created by Rafal Sroka on 11-11-17.
//  Copyright (c) 2011 Rafal Sroka. All rights reserved.
//

#import "UIImage+Sprite.h"

@implementation UIImage (Sprite)

-(NSArray *)spritesWithSpriteSheetImage:(UIImage *)image spriteSize:(CGSize)size {

    return [self spritesWithSpriteSheetImage:self inRange:NSMakeRange(0, lroundf(MAXFLOAT)) 
                                  spriteSize:size];
}

-(NSArray *)spritesWithSpriteSheetImage:(UIImage *)image inRange:(NSRange)range spriteSize:(CGSize)size {

    if (!image || CGSizeEqualToSize(size, CGSizeZero) || range.length == 0) return nil;
    NSLog(@"%i %i", range.location, range.length);
    CGImageRef spriteSheet = [image CGImage];
    NSMutableArray *tempArray = [[[NSMutableArray alloc] init] autorelease];
    
    int width = CGImageGetWidth(spriteSheet);
    int height = CGImageGetHeight(spriteSheet);
    
    int maxI = width / size.width;
    
    int startI = 0;
    int startJ = 0;
    int length = 0;
    
    int startPosition = range.location;
    
    // Extracting initial I & J values from range info
    //
    if (startPosition != 0) {
        
        for (int k=1; k<=maxI; k++) {
            
            int d = k * maxI;
            
            if (d/startPosition == 1) {
                startI = maxI - (d % startPosition);
                break;
            }
            else if (d/startPosition > 1) {
                startI = startPosition;
                break;
            }
            
            startJ++;
            
        }
    }
    
    int positionX = startI * size.width;
    int positionY = startJ * size.height;
    BOOL isReady = NO;
    
    while (positionY < height) {
        
        while (positionX < width) {
            
            CGImageRef sprite = CGImageCreateWithImageInRect(spriteSheet, CGRectMake(positionX, positionY, size.width, size.height));
            [tempArray addObject:[UIImage imageWithCGImage:sprite]];
            
            CGImageRelease(sprite);
            
            length++;
            if (length == range.length) {
                isReady = YES;
                break;
            }
            
            positionX += size.width;
        }
        
        if (isReady) break;
        
        positionX = 0;
        positionY += size.height;
    }
    
    return [NSArray arrayWithArray:tempArray];
}

@end