//
//  Router.h
//  LandscapeTest
//
//  Created by annidy on 2021/1/29.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Router : NSObject

+ (instancetype)shared;
- (void)navigateTo:(NSString *)class;
- (void)presentTo:(NSString *)class;

@end

NS_ASSUME_NONNULL_END
