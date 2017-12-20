//
//  ViewController.m
//  ImageToTrash
//
//  Created by Laura Guo on 8/31/17.
//  Copyright © 2017 Laura Guo. All rights reserved.
//

@import UIKit;

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UIImageView *trash;
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *dragGestureRecognizer;

@end

@implementation ViewController

static CGRect originalState;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)handleDrag:(UIPanGestureRecognizer *)sender {
    switch(sender.state){
        case UIGestureRecognizerStateBegan:
            originalState = _picture.frame;
            [self move:sender];
            break;
        case UIGestureRecognizerStateChanged:
            [self move:sender];
            break;
        case UIGestureRecognizerStateCancelled:
            break;
        case UIGestureRecognizerStateEnded:
            [self deleteImageIfNecessary];
        case UIGestureRecognizerStateFailed:
            break;
        case UIGestureRecognizerStatePossible:
            break;
        default:
            break;
    }
}

- (void)move:(UIPanGestureRecognizer *)sender{
    [sender.view.superview bringSubviewToFront:sender.view];
    
    CGPoint translatedPoint = [self.dragGestureRecognizer translationInView:self.dragGestureRecognizer.view];
    translatedPoint = CGPointMake(sender.view.center.x+translatedPoint.x, sender.view.center.y+translatedPoint.y);
    
    [sender.view setCenter:translatedPoint];
    [sender setTranslation:CGPointZero inView:sender.view];
}

- (void)deleteImageIfNecessary{
    // if images touch: delete; else: snap back
    if (CGRectIntersectsRect(_picture.frame, _trash.frame)) {
        _picture.frame = CGRectZero;
    } else{
        _picture.frame = originalState;
    }
}


@end
