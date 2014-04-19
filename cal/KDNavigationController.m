//
//  KDNavigationController.m
//  cal
//
//  Created by hxx on 14-4-18.
//  Copyright (c) 2014年 hxx. All rights reserved.
//

#import "KDNavigationController.h"
#import "kdanInfoViewController.h"

@interface KDNavigationController ()

@end

@implementation KDNavigationController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	if ([self rotateValueFromUserDefault])
		return (interfaceOrientation == UIInterfaceOrientationPortrait);
	else
		return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (BOOL)shouldAutorotate {
	return [self rotateValueFromUserDefault];
    //return self.topViewController.shouldAutorotate; 需要让viewcontroller自己控制能否旋转
}

- (NSUInteger)supportedInterfaceOrientations {
	if ([self rotateValueFromUserDefault])
		return UIInterfaceOrientationMaskAllButUpsideDown;
	else
		return UIInterfaceOrientationMaskPortrait;
    //return self.topViewController.supportedInterfaceOrientations; 需要让viewcontroller自己控制能否旋转
}
- (BOOL)rotateValueFromUserDefault
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"kCalRotateAvailable"] == nil) {
		[[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"kCalRotateAvailable"];
		[[NSUserDefaults standardUserDefaults] synchronize];
	}
	return [[[NSUserDefaults standardUserDefaults] objectForKey:@"kCalRotateAvailable"] boolValue];
}

@end
