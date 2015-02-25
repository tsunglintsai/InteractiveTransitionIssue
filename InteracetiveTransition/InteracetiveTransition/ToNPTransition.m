//
//  ToNPTransition.m
//  InteracetiveTransition
//
//  Created by Henry Tsai on 2/23/15.
//  Copyright (c) 2015 Henry Tsai. All rights reserved.
//

#import "ToNPTransition.h"

#define kPMTransitionDuration 0.3

@implementation ToNPTransition

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return kPMTransitionDuration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    ViewController *fromController = (ViewController*) [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *container = [transitionContext containerView];

    //add our destination view
    [container addSubview:toController.view];

    UIView *fakeView = [[UIView alloc]initWithFrame:[fromController.miniContainer.superview convertRect:fromController.miniContainer.frame toView:nil]];
    fakeView.backgroundColor = fromController.miniContainer.backgroundColor;
    [container addSubview:fakeView];
    toController.view.hidden = YES;
    [UIView animateWithDuration:kPMTransitionDuration delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        fakeView.frame = [toController.view.superview convertRect:toController.view.frame toView:nil];
    } completion:^(BOOL finished) {
        [fakeView removeFromSuperview];
        [fromController.view removeFromSuperview];
        toController.view.hidden = NO;
        //put the original stuff back in place if the user cancelled
        if(transitionContext.transitionWasCancelled)
        {
            [toController.view removeFromSuperview];
            [container addSubview:fromController.view];
        }
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}
@end
