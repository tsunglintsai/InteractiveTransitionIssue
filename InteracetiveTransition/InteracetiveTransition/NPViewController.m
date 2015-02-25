//
//  NPViewController.m
//  InteracetiveTransition
//
//  Created by Henry Tsai on 2/23/15.
//  Copyright (c) 2015 Henry Tsai. All rights reserved.
//

#import "NPViewController.h"

@interface NPViewController ()

@end

@implementation NPViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    id <UIViewControllerTransitionCoordinator>coordinator = [self transitionCoordinator];
    [coordinator animateAlongsideTransition: ^(id <UIViewControllerTransitionCoordinatorContext> c) {
        NSLog(@"test");
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
    }];
}
@end
