//
//  MasterViewController.h
//  SpriteAnimationDemo
//
//  Created by Rafal Sroka on 11-11-17.
//  Copyright (c) 2011 Rafal Sroka. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MasterViewController : UIViewController
{
    IBOutlet UIImageView *imageView;
    IBOutlet UILabel *lengthLabel;
    IBOutlet UILabel *locationLabel;
    IBOutlet UIView *settingsView;
    IBOutlet UISwitch *customRangeSwitch;
}

- (IBAction)buttonAction:(id)sender;
- (IBAction)locationValueChanged:(id)sender;
- (IBAction)lengthValueChanged:(id)sender;
- (IBAction)switchValueChanged:(id)sender;

@end