//
//  RootNavigationViewController.m
//  LandscapeTest
//
//  Created by annidy on 2021/1/29.
//

#import "RootNavigationViewController.h"

@interface RootNavigationViewController ()

@end

@implementation RootNavigationViewController

-(BOOL)shouldAutorotate {
    return self.topViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.topViewController supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return [self.topViewController preferredInterfaceOrientationForPresentation];
}

@end
