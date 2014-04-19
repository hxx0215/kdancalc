//
//  kdanInfoViewController.m
//  cal
//
//  Created by hxx on 14-4-16.
//  Copyright (c) 2014年 hxx. All rights reserved.
//

#import "kdanInfoViewController.h"


@interface kdanInfoViewController ()

@end

@implementation kdanInfoViewController

@synthesize infoLabel = _infoLabel;
@synthesize rotateAvailableButton = _rotateAvailableButton;

- (id)init {
	self = [super init];
	if (self) {
	}
	return self;
}

- (void)loadView {
	[super loadView];

	[self.view setBackgroundColor:[UIColor whiteColor]];
	self.infoLabel = [[UILabel alloc] init];
	[self.infoLabel setTextAlignment:NSTextAlignmentCenter];
	self.infoLabel.text = @"开启横屏";
	[self.view addSubview:self.infoLabel];

	self.title = @"公司信息";
	self.rotateAvailableButton = [[[UISwitch alloc] initWithFrame:CGRectMake(100, 100, 20, 20)] autorelease];

	[self.rotateAvailableButton setOn:[self rotateValueFromUserDefault]];
	[self.rotateAvailableButton addTarget:self action:@selector(buttonClicked_rotate:) forControlEvents:UIControlEventValueChanged];
	[self.view addSubview:self.rotateAvailableButton];
}

- (void)updateCurInterface:(UIInterfaceOrientation)toInterfaceOrientation {

    self.infoLabel.frame = CGRectMake(20, 90, 70, 50);
	self.rotateAvailableButton.frame = CGRectMake(100, 100, 20, 20);
}

- (void)viewDidLoad {
	[super viewDidLoad];

	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];

	[self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
    
    

	UIInterfaceOrientation tToInterfaceO = [UIApplication sharedApplication].statusBarOrientation;
	[self updateCurInterface:tToInterfaceO];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration {
	[self updateCurInterface:toInterfaceOrientation];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (BOOL)rotateValueFromUserDefault {
    NSUserDefaults *tUserDefault = [NSUserDefaults standardUserDefaults];
    [tUserDefault synchronize];
	if ([tUserDefault objectForKey:@"kCalRotateAvailable"] == nil) {
		[tUserDefault setObject:@"YES" forKey:@"kCalRotateAvailable"];
		[tUserDefault synchronize];
	}
	return [[[NSUserDefaults standardUserDefaults] objectForKey:@"kCalRotateAvailable"] boolValue];
}

- (void)buttonClicked_rotate:(id)sender {
    
    NSUserDefaults *tUserDefault = [NSUserDefaults standardUserDefaults];
    [tUserDefault synchronize];
    NSString *tisOn =self.rotateAvailableButton.isOn ? @"YES":@"NO";
    
    if ([tUserDefault objectForKey:@"kCalRotateAvailable"] == nil) {
		[tUserDefault setObject:@"YES" forKey:@"kCalRotateAvailable"];
		[tUserDefault synchronize];
	}
	[tUserDefault setObject:tisOn forKey:@"kCalRotateAvailable"];
	[tUserDefault synchronize];

	UIInterfaceOrientation tToInterfaceO = [UIApplication sharedApplication].statusBarOrientation;

	[self updateCurInterface:tToInterfaceO];
}




- (void)dealloc {
	[_infoLabel release];
	[_rotateAvailableButton release];
	[super dealloc];
}

@end
