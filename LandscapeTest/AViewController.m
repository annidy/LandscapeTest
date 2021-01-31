//
//  AViewController.m
//  LandscapeTest
//
//  Created by annidy on 2021/1/29.
//

#import "AViewController.h"
#import "Router.h"

@interface AViewController ()

@end

@implementation AViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)openLandescapeSence {
    [[Router shared] navigateTo:@"LandscapeViewController"];
}

- (IBAction)presentLandescapeSence {
    [[Router shared] presentTo:@"LandscapeViewController"];
}

//-(BOOL)shouldAutorotate{
//    return YES;
//}
//
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//     return UIInterfaceOrientationMaskAll;
//}
//


@end
