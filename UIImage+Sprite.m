//
//  UIImage+Sprite.m
//
//  Created by Rafal Sroka on 11-11-17.
//  Copyright (c) 2011 Rafal Sroka. All rights reserved.
//
//  This code is distributed under the terms and conditions of the MIT license.
//
//  Permission is hereby granted, free of charge, to any person obtaining
//  a copy of this software and associated documentation files (the
//  "Software"), to deal in the Software without restriction, including
//  without limitation the rights to use, copy, modify, merge, publish,
//  distribute, sublicense, and/or sell copies of the Software, and to
//  permit persons to whom the Software is furnished to do so, subject to
//  the following conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
//  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
//  OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
//  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "UIImage+Sprite.h"


@implementation UIImage (Sprite)


- (NSArray *)spritesWithSpriteSheetImage:(UIImage *)image
                              spriteSize:(CGSize)size
{
    
    return [self spritesWithSpriteSheetImage:self
                                     inRange:NSMakeRange(0, lroundf(MAXFLOAT))
                                  spriteSize:size];
}


- (NSArray *)spritesWithSpriteSheetImage:(UIImage *)image
                                 inRange:(NSRange)range
                              spriteSize:(CGSize)size
{
    if (!image || CGSizeEqualToSize(size, CGSizeZero) || range.length == 0)
        return nil;
    
    CGImageRef spriteSheet = [image CGImage];
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    
    int width = CGImageGetWidth(spriteSheet);
    int height = CGImageGetHeight(spriteSheet);
    
    int maxI = width / size.width;
    
    int startI = 0;
    int startJ = 0;
    int length = 0;
    
    int startPosition = range.location;
    
    // Extracting initial I & J values from range info
    if (startPosition != 0)
    {
        for (int k=1; k<=maxI; k++)
        {
            int d = k * maxI;
            
            if (d/startPosition == 1)
            {
                startI = maxI - (d % startPosition);
                break;
            }
            else if (d/startPosition > 1)
            {
                startI = startPosition;
                break;
            }
            
            startJ++;
        }
    }
    
    int positionX = startI * size.width;
    int positionY = startJ * size.height;
    BOOL isReady = NO;
    
    while (positionY < height)
    {
        while (positionX < width)
        {
            CGImageRef sprite = CGImageCreateWithImageInRect(spriteSheet,
                                                             CGRectMake(positionX,
                                                                        positionY,
                                                                        size.width,
                                                                        size.height));
            [tempArray addObject:[UIImage imageWithCGImage:sprite]];
            
            CGImageRelease(sprite);
            
            length++;
            
            if (length == range.length)
            {
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