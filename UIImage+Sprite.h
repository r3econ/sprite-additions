//
//  UIImage+Sprite.h
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

#import <Foundation/Foundation.h>

/**
 Useful UIImage category for handling sprite sheets. This add-on smoothes the way of extracting images from a sprite sheet (texture atlas). 
 Note that for performance reasons you should not fire these methods every time you want to get the array of animation frames. 
 You should rather fire it once and store the output array somewhere. This is because the Core Graphics image manipulation operations  (especially on large images) are not so fast and your application may slow down.
 */
@interface UIImage (Sprite)

/**
 The method returns an array with UIImages. Original sprite sheet is sliced into smaller chunks, each of the specified size.
 @param image the image with sprite sheet (texture atlas)
 @param size the size of the single chunk
 @returns the array of UIImages, each representing a single animation frame
 */
-(NSArray *)spritesWithSpriteSheetImage:(UIImage *)image spriteSize:(CGSize)size;

/**
 The method returns an array with UIImages. Original sprite sheet is sliced into smaller chunks, each of the specified size.
 @param image the image with sprite sheet (texture atlas)
 @param range the range of the chunks
 @param size the size of the single chunk
 @returns the array of UIImages, each representing a single animation frame
 */
-(NSArray *)spritesWithSpriteSheetImage:(UIImage *)image inRange:(NSRange)range spriteSize:(CGSize)size;
@end