//
//  kdanAppDelegate.h
//  cal
//
//  Created by hxx on 14-4-16.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>

@class kdanCalViewController;
@class KDNavigationController;

@interface kdanAppDelegate : UIResponder <UIApplicationDelegate>
{
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) kdanCalViewController *viewController;
@property (strong, nonatomic) KDNavigationController *navController;
@end
