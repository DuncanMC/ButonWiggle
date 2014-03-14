//
//  ViewController.h
//  ButtonWiggle
//
//  Created by Duncan Champney on 3/14/14.
//  Copyright (c) 2014 WareTo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *jellybeanButton;
@property (weak, nonatomic) IBOutlet UISwitch *wiggleSwitch;

- (IBAction)handleWiggleSwitch:(UISwitch *)sender;

@end
