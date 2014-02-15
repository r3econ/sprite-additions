//
//  MasterViewController.m
//  SpriteAnimationDemo
//
//  Created by Rafal Sroka on 11-11-17.
//  Copyright (c) 2011 Rafal Sroka. All rights reserved.
//

#import "MasterViewController.h"
#import "UIImage+Sprite.h"


@implementation MasterViewController


- (void)dealloc
{
    [settingsView release];
    [locationLabel release];
    [lengthLabel release];
    [customRangeSwitch release];
    [super dealloc];
}


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


- (void)viewDidUnload
{
    [imageView release];
    imageView = nil;
    [settingsView release];
    settingsView = nil;
    [locationLabel release];
    locationLabel = nil;
    [lengthLabel release];
    lengthLabel = nil;
    [customRangeSwitch release];
    customRangeSwitch = nil;
    [super viewDidUnload];
}


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

    [UIView beginAnimations:nil context:nil];
    
    if ([sw isOn])
    {
        [settingsView setAlpha:1.0];
    }
    else
    {
        [settingsView setAlpha:0.2];
    }
    
    [UIView commitAnimations];
}


@end