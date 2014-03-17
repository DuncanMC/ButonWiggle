//
//  ViewController.h
//  ButtonWiggle
//
//  Created by Duncan Champney on 3/14/14.
//  Copyright (c) 2014 WareTo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton     *jellybeanButton;
@property (weak, nonatomic) IBOutlet UISwitch     *wiggleSwitch;
@property (weak, nonatomic) IBOutlet UISwitch     *randomSwitch;
@property (weak, nonatomic) IBOutlet UIImageView  *waretoIcon;

- (IBAction)handleWiggleSwitch:(UISwitch *)sender;
- (IBAction)handleJellybeanButton:(UIButton *)sender;

@end
