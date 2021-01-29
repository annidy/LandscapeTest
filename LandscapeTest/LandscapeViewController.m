//
//  LandscapeViewController.m
//  LandscapeTest
//
//  Created by annidy on 2021/1/29.
//

#import "LandscapeViewController.h"
#import "Aspects.h"

@interface LandscapeViewController ()
@property UIStackView *view;
@end

@implementation LandscapeViewController
@dynamic view;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *label = [[UILabel alloc] init];
    label.text = @"This is Landescape";
    [self.view addArrangedSubview:label];

    UIButton *close = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [close setTitle:@"关闭" forState:UIControlStateNormal];
    [close addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addArrangedSubview:close];
}

- (void)didMoveToParentViewController:(UIViewController *)parent {
    [super didMoveToParentViewController:parent];
//    if (parent) {
//        [self setInterfaceOrientation:UIDeviceOrientationLandscapeLeft];
//    }
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)willMoveToParentViewController:(UIViewController *)parent {
    
//    [self setInterfaceOrientation:UIDeviceOrientationLandscapeLeft];

//    if ([parent isKindOfClass:[UINavigationController class]]) {
//        UINavigationController *navi = (UINavigationController *)parent;
//        [navi aspect_hookSelector:@selector(supportedInterfaceOrientations) withOptions:AspectPositionInstead usingBlock:^(id<AspectInfo> info){
//            NSInvocation *invocation = info.originalInvocation;
//            [invocation invoke];
//            UIInterfaceOrientationMask ret = [self supportedInterfaceOrientations];
//            [invocation setReturnValue:&ret];
//        } error:NULL];
//        [navi aspect_hookSelector:@selector(preferredInterfaceOrientationForPresentation) withOptions:AspectPositionInstead usingBlock:^(id<AspectInfo> info){
//            NSInvocation *invocation = info.originalInvocation;
//            [invocation invoke];
//            UIInterfaceOrientation ret = [self preferredInterfaceOrientationForPresentation];
//            [invocation setReturnValue:&ret];
//        } error:NULL];
//        [navi aspect_hookSelector:@selector(shouldAutorotate) withOptions:AspectPositionInstead usingBlock:^(id<AspectInfo> info){
//            NSInvocation *invocation = info.originalInvocation;
//            [invocation invoke];
//            BOOL ret = YES;
//            [invocation setReturnValue:&ret];
//        } error:NULL];
//    }
//    
//    [UIViewController aspect_hookSelector:@selector(preferredInterfaceOrientationForPresentation) withOptions:AspectPositionInstead usingBlock:^(id<AspectInfo> info){
//        NSInvocation *invocation = info.originalInvocation;
//        [invocation invoke];
//        UIInterfaceOrientation ret = [self preferredInterfaceOrientationForPresentation];
//        [invocation setReturnValue:&ret];
//    } error:NULL];
    
//    NSObject *appDelegate = [UIApplication sharedApplication].delegate;
//    [appDelegate aspect_hookSelector:@selector(application:supportedInterfaceOrientationsForWindow:) withOptions:AspectPositionInstead usingBlock:^(id<AspectInfo> info) {
//        NSInvocation *invocation = info.originalInvocation;
//        [invocation invoke];
//        UIInterfaceOrientationMask ret = UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;;
//        [invocation setReturnValue:&ret];
//        
//    } error:NULL];
}

- (void)loadView {
    self.view = [[UIStackView alloc] initWithFrame:CGRectZero];
    self.view.axis = UILayoutConstraintAxisVertical;
    self.view.backgroundColor = [UIColor whiteColor];
}


//- (BOOL)shouldAutorotate {
//      return YES;
//}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
     return UIInterfaceOrientationMaskLandscapeLeft;
}

//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
//     return UIInterfaceOrientationLandscapeLeft;
//}

- (void)setInterfaceOrientation:(UIDeviceOrientation)orientation {
  if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
      [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:orientation]
                                  forKey:@"orientation"];
    }
}

@end
