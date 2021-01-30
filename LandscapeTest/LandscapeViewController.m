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
@property BOOL isShow;
@property id<AspectToken> naviToken;

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



- (void)viewWillAppear:(BOOL)animated {
    [[UIDevice currentDevice] setValue:@(UIDeviceOrientationLandscapeLeft) forKey:@"orientation"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[UIDevice currentDevice] setValue:@(UIDeviceOrientationPortrait) forKey:@"orientation"];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)willMoveToParentViewController:(UIViewController *)parent {
    if (parent) {
        // push in
        if ([parent isKindOfClass:[UINavigationController class]]) {
            UINavigationController *navi = (UINavigationController *)parent;
            self.naviToken = [navi aspect_hookSelector:@selector(supportedInterfaceOrientations) withOptions:AspectPositionInstead usingBlock:^(id<AspectInfo> info){
                NSInvocation *invocation = info.originalInvocation;
                [invocation invoke];
                UIInterfaceOrientationMask ret = UIInterfaceOrientationMaskLandscapeLeft;
                [invocation setReturnValue:&ret];
            } error:NULL];
        }
    } else {
        // pop out
        [self.naviToken remove];
    }
}

- (void)loadView {
    self.view = [[UIStackView alloc] initWithFrame:CGRectZero];
    self.view.axis = UILayoutConstraintAxisVertical;
    self.view.backgroundColor = [UIColor whiteColor];
}


- (BOOL)shouldAutorotate {
      return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
     return UIInterfaceOrientationMaskLandscapeLeft;
}



@end
