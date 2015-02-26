//
//  ViewController.m
//  InteracetiveTransition
//
//  Created by Henry Tsai on 2/23/15.
//  Copyright (c) 2015 Henry Tsai. All rights reserved.
//

#import "ViewController.h"
#import "ToNPTransition.h"
#import "NPViewController.h"

@interface ViewController () <UINavigationControllerDelegate,UIViewControllerTransitioningDelegate>
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapGuesture;
@property (strong, nonatomic) UIPercentDrivenInteractiveTransition *transition;
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *panGestureRecoginizer;
@property (nonatomic) BOOL isTappedTransition;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.transition = [[UIPercentDrivenInteractiveTransition alloc] init];
    [self.tapGuesture addTarget:self action:@selector(didTap:)];
    [self.panGestureRecoginizer addTarget:self action:@selector(pan:)];
    self.navigationController.delegate = self;

}

- (void)didTap:(UITapGestureRecognizer*)tapGuesture{
    self.isTappedTransition = YES;
    UIViewController *controller = [[UIViewController alloc]init];
    controller.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)pan:(UIPanGestureRecognizer*)panGuesture{
    CGPoint touchLocation = [panGuesture locationInView:self.view];
    NSLog(@"==========pan touch location:%f,%f",touchLocation.x,touchLocation.y);
    UIViewController *controller = [[UIViewController alloc]init];
    controller.view.backgroundColor = [UIColor whiteColor];
    switch (panGuesture.state)
    {
        case UIGestureRecognizerStateBegan:
            NSLog(@"======================UIGestureRecognizerStateBegan");
            [self.navigationController pushViewController:controller animated:YES];
            break;
        case UIGestureRecognizerStateChanged:
            NSLog(@"======================UIGestureRecognizerStateChanged");
            float percentageOfPan = [self percentageOfPan:touchLocation];
            [self.transition updateInteractiveTransition:percentageOfPan];
            break;
        case UIGestureRecognizerStateCancelled:
            NSLog(@"======================UIGestureRecognizerStateCancelled");
            break;
        case UIGestureRecognizerStateEnded:
            NSLog(@"======================UIGestureRecognizerStateEnded");
            if(touchLocation.y < 600){
                [self.transition finishInteractiveTransition];
            } else {
                [self.transition cancelInteractiveTransition];
            }
            break;
        default:
            break;
    }
}

- (float)percentageOfPan:(CGPoint)touchLocation{
    return (self.view.frame.size.height - touchLocation.y) / self.view.frame.size.height;
}

- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
    if([animationController isKindOfClass:[ToNPTransition class]]){
        if (self.isTappedTransition){
            return nil;
        }
        return self.transition;
    }
    return nil;
}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC {
    if ([toVC isKindOfClass:[UIViewController class]]) {
        ToNPTransition *transition = [[ToNPTransition alloc]init];
        return transition;
    }
    return nil;
}

@end
