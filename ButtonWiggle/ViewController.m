//
//  ViewController.m
//  ButtonWiggle
//
//  Created by Duncan Champney on 3/14/14.
//  Copyright (c) 2014 WareTo. All rights reserved.
//

#import "ViewController.h"



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
  if (_randomSwitch.isOn)
  {
    random = [self randomFloat: .5];
    _jellybeanButton.layer.speed = 1 + random;
  }
  
  
  //randomize the duration of both steps slightly
  CGFloat duration;
  if (_randomSwitch.isOn)
  {
    duration = .18;
    duration += [self randomFloatPlusOrMinus: .02];
  }
  else
    duration = .4;
  
  [UIView animateWithDuration: duration
                        delay: 0
                      options:  UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState
                   animations: ^
   {
     //Pick an amount to change the height & width of the iamge
     CGFloat delta = .1;
     if (_randomSwitch.isOn)
     {
       delta= .05 + [self randomFloat: .05];
     }
     if (arc4random_uniform(2) == 0)
       delta *= -1;
     //Create a transform that scales the image
     CGAffineTransform transform = CGAffineTransformMakeScale(1 + delta, 1 -delta); //Make the image wider and shorter or narrower and taller.
     
     if (_randomSwitch.isOn)
     {
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
     }
     _jellybeanButton.transform = transform;
   }
                   completion: ^(BOOL finished)
   //When the animation is done, animate the view back to normal
   {
     CGFloat random = 0;
     if (_randomSwitch.isOn)
     {
       random = [self randomFloat: .5];
       _jellybeanButton.layer.speed = 1 + random;
     }
     
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
#pragma mark - IBAction methods
//-----------------------------------------------------------------------------------------------------------

- (IBAction)handleWiggleSwitch:(UISwitch *)sender
{
  if (_wiggleSwitch.isOn)
    [self handleWiggle];
}

//-----------------------------------------------------------------------------------------------------------
- (IBAction)handleJellybeanButton:(UIButton *)sender
{
#define full_rotation M_PI*2
#define rotation_count 1
  
  
  static float change =-full_rotation* rotation_count;
  
  change *= -1;  //Have our rotation alternate between clockwise and counter-clockwise.
  
  //Create a CABasicAnimation object to manage our rotation.
  CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform"];
  
  //Make sure the begin time on the animation is 0,
  //in case we left at a different value on the last animation.
  
  _jellybeanButton.enabled = NO;
  rotation.duration =  1;
  
  rotation.fromValue = @(0);
  
  
  //Set the ending value of the rotation to the new angle.
  rotation.toValue = @(change);
  
  //Have the rotation use linear timing.
  rotation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
  
  /*
   
   This is the magic bit. We add a CAValueFunction that tells the CAAnimation we are modifying
   the transform's rotation around the Z axis.
   Without this, we would supply a transform as the fromValue and toValue, and for rotations
   > a half-turn, we could not control the rotation direction.
   
   By using a value function, we can specify arbitrary rotation amounts and directions, and even
   Rotations greater than 360 degrees.
   */
  
  rotation.valueFunction = [CAValueFunction functionWithName: kCAValueFunctionRotateZ];
  
  //Make ourselves the animation's delegate, so we get called when it's finished.
  rotation.delegate = self;
  
  
  
  /*
   Attach the completion block to the animation using the key kAnimationCompletionBlock.
   Our animationDidStop:finished: delegate method will execute this block when the animation completes.
   
   Unlike most objects, CAAnimation and CALayer objects allow you
   to attach any arbitrary key/value pair to them.
   */
  
  
  /*
   Set the layer's transform to it's final state before submitting the animation, so it is in it's
   final state once the animation completes.
   */
  _waretoIcon.layer.transform = CATransform3DRotate(_waretoIcon.layer.transform, change, 0, 0, 1.0);
  
  [_waretoIcon.layer addAnimation:rotation forKey:@"transform.rotation.z"];

}

//-----------------------------------------------------------------------------------------------------------

//This is the delegate method for a CAAnimation.

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag
{
  _jellybeanButton.enabled = YES;
}

//-----------------------------------------------------------------------------------------------------------

@end
