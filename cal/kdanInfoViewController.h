//
//  kdanInfoViewController.h
//  cal
//
//  Created by hxx on 14-4-16.
//  Copyright (c) 2014年 hxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface kdanInfoViewController : UIViewController

- (BOOL)rotateValueFromUserDefault;
@property (nonatomic, retain) UILabel *infoLabel;
@property (nonatomic, retain) UISwitch *rotateAvailableButton;
@end
