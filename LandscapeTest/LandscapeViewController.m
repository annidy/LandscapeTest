//
//  LandscapeViewController.m
//  LandscapeTest
//
//  Created by annidy on 2021/1/29.
//

#import "LandscapeViewController.h"
#import "Aspects.h"
#import <objc/runtime.h>
#import "Router.h"

static char *isLandscapeKey;
@implementation UIResponder (Landesacpe)

- (BOOL)isLandscape {
    NSNumber *isLandscape = objc_getAssociatedObject(self, &isLandscapeKey);
    return [isLandscape boolValue];
}

- (void)setIsLandscape:(BOOL)isLandscape {
    objc_setAssociatedObject(self, &isLandscapeKey, @(isLandscape), OBJC_ASSOCIATION_COPY);
}

- (UIInterfaceOrientationMask)landscape_application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    if (self.isLandscape) {
        return  UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft;
    } else {
        if ([self respondsToSelector:@selector(landscape_application:supportedInterfaceOrientationsForWindow:)]) {
            return [self landscape_application:application supportedInterfaceOrientationsForWindow:window];
        } else {
            return [self orientationMaskFromInfo];
        }
    }
}

- (UIInterfaceOrientationMask)orientationMaskFromInfo {
    NSBundle *bundle = [NSBundle mainBundle];
    NSURL *infoPath = [bundle URLForResource:@"Info" withExtension:@"plist"];
    NSDictionary *infoDic = [NSDictionary dictionaryWithContentsOfURL:infoPath];
    NSArray *orientations = infoDic[@"UISupportedInterfaceOrientations"];
    if ([orientations isKindOfClass:[NSArray class]]) {
        UIInterfaceOrientationMask mask = 0;
        if ([orientations containsObject:@"UIInterfaceOrientationPortrait"]) {
            mask |= UIInterfaceOrientationMaskPortrait;
        }
        if ([orientations containsObject:@"UIInterfaceOrientationLandscapeLeft"]) {
            mask |= UIInterfaceOrientationLandscapeLeft;
        }
        
        return mask;
    }
    return UIInterfaceOrientationMaskPortrait;
}

@end

@interface LandscapeViewController ()
@property UIStackView *view;
@property BOOL isShow;
@property id<AspectToken> naviToken;

@end

@implementation LandscapeViewController
@dynamic view;

+ (void)load {
    Class class = NSClassFromString(@"AppDelegate");
    
    SEL originalSelector = @selector(application:supportedInterfaceOrientationsForWindow:);
    SEL swizzledSelector = @selector(landscape_application:supportedInterfaceOrientationsForWindow:);
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (success) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *label = [[UILabel alloc] init];
    label.text = @"This is Landescape";
    [self.view addArrangedSubview:label];
    
    UIButton *portraitBtn = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [portraitBtn setTitle:@"打开竖屏" forState:UIControlStateNormal];
    [portraitBtn addTarget:self action:@selector(navToPortrait) forControlEvents:UIControlEventTouchUpInside];
    [self.view addArrangedSubview:portraitBtn];

    UIButton *close = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [close setTitle:@"关闭" forState:UIControlStateNormal];
    [close addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addArrangedSubview:close];
}

- (void)viewDidAppear:(BOOL)animated {
    [[UIDevice currentDevice] setValue:@(UIDeviceOrientationLandscapeLeft) forKey:@"orientation"];
}

- (void)viewDidDisappear:(BOOL)animated {
    [[UIDevice currentDevice] setValue:@(UIDeviceOrientationPortrait) forKey:@"orientation"];
}

- (void)viewWillAppear:(BOOL)animated {
    
    NSObject *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate setValue:@1 forKey:@"isLandscape"];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    NSObject *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate setValue:@0 forKey:@"isLandscape"];

}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)navToPortrait {
    [[Router shared] navigateTo:@"ViewController"];
}

- (void)willMoveToParentViewController:(UIViewController *)parent {
    if (parent) {
        // push in
        if ([parent isKindOfClass:[UINavigationController class]]) {
            UINavigationController *navi = (UINavigationController *)parent;
            self.naviToken = [navi aspect_hookSelector:@selector(supportedInterfaceOrientations) withOptions:AspectPositionInstead usingBlock:^(id<AspectInfo> info){
                NSInvocation *invocation = info.originalInvocation;
                [invocation invoke];
                UIInterfaceOrientationMask ret = navi.topViewController.supportedInterfaceOrientations;
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
     return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeLeft;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
     return UIInterfaceOrientationLandscapeLeft;
}

@end





