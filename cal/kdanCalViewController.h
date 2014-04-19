//
//  kdanCalViewController.h
//  cal
//
//  Created by hxx on 14-4-16.
//  Copyright (c) 2014年 hxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface kdanCalViewController : UIViewController
{
	float _result;
}
@property (nonatomic, retain) UILabel *display;
@property (nonatomic, retain) NSMutableString *num1;
@property (nonatomic, retain) NSMutableString *num2;
@property (nonatomic, retain) NSString *opt;
@property (nonatomic, retain) NSMutableArray *buttons;
@property (nonatomic, retain) UIButton *infoButton;
@end
