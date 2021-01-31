//
//  Router.m
//  LandscapeTest
//
//  Created by annidy on 2021/1/29.
//

#import "Router.h"

@implementation Router

+ (instancetype)shared {
    static Router *router;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        router = [[Router alloc] init];
    });
    return router;
}


- (void)navigateTo:(NSString *)class {
    
    UIViewController *root = [self topMostController];
    if ([root isKindOfClass:[UINavigationController class]]) {
        [self pushSoleController:class inside:(UINavigationController *)root];
    } else {
//        RootNavigationViewController *navi = [[RootNavigationViewController alloc]
//                initWithRootViewController:[self controllerForClass:class]];
//        navi.modalPresentationStyle = UIModalPresentationFullScreen;
//        navi.navigationBar.topItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStyleDone
// target:self action:@selector(dismiss)];
//        [root presentViewController:navi animated:YES completion:nil];
        
        
        UIViewController *con = [self controllerForClass:class];
        con.modalPresentationStyle = UIModalPresentationFullScreen;
        [root presentViewController:con animated:YES completion:nil];
    }
}

- (void)pushSoleController:(NSString *)class inside:(UINavigationController *)navi {
    NSMutableArray *exist = [navi.viewControllers mutableCopy];
    for (UIViewController *controller in navi.viewControllers) {
        if ([controller isKindOfClass:NSClassFromString(class)]) {
            [exist removeObject:controller];
            [exist addObject:controller];
            navi.viewControllers = exist;
            return;
        }
    }
    [navi pushViewController:[self controllerForClass:class] animated:NO];
}

- (UIViewController *)topMostController
{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;

    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }

    return topController;
}

- (UIViewController *)controllerForClass:(NSString *)class {
    UIViewController *con = [[NSClassFromString(class) alloc] initWithNibName:nil bundle:nil];
    return con;
}

- (void)dismiss {
    [[self topMostController] dismissViewControllerAnimated:YES completion:nil];
}

@end
