//
//  ViewController.m
//  ButtonWiggle
//
//  Created by Duncan Champney on 3/14/14.
//  Copyright (c) 2014 WareTo. All rights reserved.
//

#import "ViewController.h"


#define randomize 1

@interface ViewController ()

@end

@implementation ViewController

//-----------------------------------------------------------------------------------------------------------
- (CGFloat) randomFloat: (CGFloat) max_value;
{
	CGFloat aRandom = (arc4random() % 1000000001);
	aRandom = (aRandom * max_value) / 1000000000;
	return aRandom;
}

//-----------------------------------------------------------------------------------------------------------

- (CGFloat) randomFloatPlusOrMinus: (CGFloat) max_value;
{
	CGFloat aRandom = [self randomFloat: max_value*2] - max_value;
	return aRandom;
}

//-----------------------------------------------------------------------------------------------------------

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

//-----------------------------------------------------------------------------------------------------------

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-----------------------------------------------------------------------------------------------------------

//UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat
- (void) handleWiggle;
{
  //Randomize the animation speed for each repeat
  CGFloat random = 0;
#if randomize
  random = [self randomFloat: .5];
#endif
  _jellybeanButton.layer.speed = 1 + random;
  
  
  //randomize the duration of both steps slightly
  CGFloat duration;
#if randomize
  duration = .18;
#else
  duration = .4;
#endif
  duration += [self randomFloatPlusOrMinus: .02];
  
  [UIView animateWithDuration: duration
                        delay: 0
                      options:  UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState
                   animations: ^
   {
     //Pick an amount to change the height & width of the iamge
     CGFloat delta = .1;
#if randomize
     delta= .05 + [self randomFloat: .05];
     if (arc4random_uniform(2) == 0)
       delta *= -1;
#endif
     
     //Create a transform that scales the image
     CGAffineTransform transform = CGAffineTransformMakeScale(1 + delta, 1 -delta); //Make the image wider and shorter or narrower and taller.
     
     //-----
#if randomize
     //Rotate it by a random amount around a slightly randomized center-point
     CGFloat x,y;
     x = .5 + [self randomFloatPlusOrMinus: 20];
     y = .5 + [self randomFloatPlusOrMinus: 20];
     
     CGFloat rotation;
     rotation = [self randomFloatPlusOrMinus: .2];
     
     //To rotate around a random point,
     //Shift the enter point, rotate, and shift the center point back
     transform = CGAffineTransformTranslate(transform, x, y);
     transform = CGAffineTransformRotate(transform, rotation * M_2_PI);
     transform = CGAffineTransformTranslate(transform, -x, -y);
#endif
     //-----
     _jellybeanButton.transform = transform;
   }
                   completion: ^(BOOL finished)
   //When the animation is done, animate the view back to normal
   {
     CGFloat random = 0;
#if randomize
     random = [self randomFloat: .5];
#endif
     _jellybeanButton.layer.speed = 1 + random;
     
     [UIView animateWithDuration: duration
                           delay: 0
                         options:  UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState
                      animations: ^
      {
        //Set the view's trnaform back to the identity transform.
        CGAffineTransform transform = CGAffineTransformIdentity;
        _jellybeanButton.transform = transform;
      }
                      completion: ^(BOOL finished)
      {
        //Now start the process over agaon.
        
        if (_wiggleSwitch.isOn)
          [self handleWiggle];
      }
      ];
   }
   ];
}

//-----------------------------------------------------------------------------------------------------------

- (IBAction)handleWiggleSwitch:(UISwitch *)sender
{
  if (_wiggleSwitch.isOn)
    [self handleWiggle];
}
@end
