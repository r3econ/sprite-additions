//
//  MasterViewController.m
//  SpriteAnimationDemo
//
//  Created by Rafal Sroka on 11-11-17.
//  Copyright (c) 2011 Rafal Sroka. All rights reserved.
//
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


#import "MasterViewController.h"
#import "UIImage+Sprite.h"


@implementation MasterViewController


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - View lifecycle


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:NSLocalizedString(@"Sprite Animation", @"")];
    [self switchValueChanged:customRangeSwitch];
}


#pragma mark - Actions


- (IBAction)buttonAction:(id)sender
{
    if ([imageView isAnimating])
    {
        [imageView stopAnimating];
        
        [((UIButton *)sender) setTitle:NSLocalizedString(@"Start animation!", @"")
                              forState:UIControlStateNormal];
        return;
    }
    
    //
    // This cool sprite sheet can be found at http://gushh.net/blog/free-game-sprites-explosion-3/
    // I added numbers to this image to make testing and debuging easier.
    //
    UIImage *spriteSheet = [UIImage imageNamed:@"explosion_4_39_128_debug"];
    
    if ([customRangeSwitch isOn])
    {
        NSRange range = NSMakeRange([locationLabel.text intValue],
                                    [lengthLabel.text intValue]);
        
        NSArray *arrayWithSprites = [spriteSheet spritesWithSpriteSheetImage:spriteSheet
                                                                     inRange:range
                                                                  spriteSize:CGSizeMake(128, 128)];
        [imageView setAnimationImages:arrayWithSprites];
    }
    else
    {
        NSArray *arrayWithSprites = [spriteSheet spritesWithSpriteSheetImage:spriteSheet
                                                                  spriteSize:CGSizeMake(128, 128)];
        [imageView setAnimationImages:arrayWithSprites];
    }
    
    NSLog(@"Sprite images: %i", [imageView.animationImages count]);
    
    float animationDuration = [imageView.animationImages count] * 0.100; // 100ms per frame
    
    [imageView setAnimationRepeatCount:0];
    [imageView setAnimationDuration:animationDuration];
    [imageView startAnimating];
    
    [((UIButton *)sender) setTitle:NSLocalizedString(@"Stop animation!", @"")
                          forState:UIControlStateNormal];
}


- (IBAction)locationValueChanged:(id)sender
{
    locationLabel.text = [NSString stringWithFormat:@"%.0f", ((UIStepper *)sender).value];
}


- (IBAction)lengthValueChanged:(id)sender
{
    lengthLabel.text = [NSString stringWithFormat:@"%.0f", ((UIStepper *)sender).value];
}


- (IBAction)switchValueChanged:(id)sender
{
    UISwitch *sw = (UISwitch *)sender;
    [settingsView setUserInteractionEnabled:[sw isOn]];
    
    [UIView animateWithDuration:1.0f
                     animations:^
     {
         if ([sw isOn])
         {
             [settingsView setAlpha:1.0];
         }
         else
         {
             [settingsView setAlpha:0.2];
         }
     }];
}


@end