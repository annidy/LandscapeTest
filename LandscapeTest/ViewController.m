//
//  ViewController.m
//  LandscapeTest
//
//  Created by annidy on 2021/1/29.
//

#import "ViewController.h"
#import "Router.h"

@interface ViewController ()
@property UIStackView *view;
@end

@implementation ViewController
@dynamic view;

- (void)viewDidLoad {
    [super viewDidLoad];

    UILabel *label = [[UILabel alloc] init];
    label.text = @"This is Portrait";
    [self.view addArrangedSubview:label];
    
    UIButton *landscapeBtn = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [landscapeBtn setTitle:@"打开横屏" forState:UIControlStateNormal];
    [landscapeBtn addTarget:self action:@selector(navToLandscape) forControlEvents:UIControlEventTouchUpInside];
    [self.view addArrangedSubview:landscapeBtn];

    UIButton *close = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [close setTitle:@"关闭" forState:UIControlStateNormal];
    [close addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addArrangedSubview:close];
}

- (void)navToLandscape {
    [[Router shared] navigateTo:@"LandscapeViewController"];
}

- (void)loadView {
    self.view = [[UIStackView alloc] initWithFrame:CGRectZero];
    self.view.axis = UILayoutConstraintAxisVertical;
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
