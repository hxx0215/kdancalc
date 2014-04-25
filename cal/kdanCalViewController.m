//
//  kdanCalViewController.m
//  cal
//
//  Created by hxx on 14-4-16.
//  Copyright (c) 2014年 hxx. All rights reserved.
//

#import "kdanCalViewController.h"
#import "kdanInfoViewController.h"


@interface kdanCalViewController ()
{
}
@end

@implementation kdanCalViewController
@synthesize display = _display;
@synthesize num1 = _num1;
@synthesize num2 = _num2;
@synthesize opt = _opt;
@synthesize buttons = _buttons;
@synthesize infoButton = _infoButton;


#pragma mark - initialize


- (id)init {
	self = [super init];
	if (self) {
		self.num1 = [[[NSMutableString alloc] init] autorelease];
		self.num2 = [[[NSMutableString alloc] init] autorelease];
		self.opt = [[[NSString alloc] init] autorelease];
		self.buttons = [[[NSMutableArray alloc] init] autorelease];
	}
	return self;
}

- (void)loadView {
	[super loadView];

	[self initInfoButton];

	[self initDisplay];

	[self initButtons];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];

	self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];

	UIInterfaceOrientation tToInterfaceO = [UIApplication sharedApplication].statusBarOrientation;
	[self updateCurInterface:tToInterfaceO];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - updateInterface

- (void)updateCurInterface:(UIInterfaceOrientation)toInterfaceOrientation {
	CGRect tScreenR = [UIScreen mainScreen].bounds;      //ScreenRect
	CGRect tInfoR = CGRectMake(25, 50, 20, 20);       //InfoButtonRect
	CGRect tDisplayR;
	CGRect tButtonsR;
	CGFloat offsetX;
	CGFloat offsetY;
	CGFloat tWidth;
	if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
		if ([self isiPhone]) {
			tDisplayR = CGRectMake(0, 50, 260, 40);
			tButtonsR = CGRectMake(0, 200, 60, 40);
		}
		else {
			tDisplayR = CGRectMake(0, 100, 650, 80);
			tButtonsR = CGRectMake(0, 500, 120, 80);
		}
	}
	else {
		CGFloat exchange = tScreenR.size.width;
		tScreenR.size.width = tScreenR.size.height;
		tScreenR.size.height = exchange;
		if ([self isiPhone]) {
			tDisplayR = CGRectMake(0, 20, 390, 40);
			tButtonsR = CGRectMake(0, 100, 100, 35);
		}
		else {
			tDisplayR = CGRectMake(0, 100, 800, 80);
			tButtonsR = CGRectMake(0, 350, 200, 80);
		}
	}
	tInfoR.origin.x = tScreenR.size.width - tInfoR.origin.x;
	tInfoR.origin.y = tScreenR.size.height - tInfoR.origin.y;
	self.infoButton.frame = tInfoR;

	tDisplayR.origin.x = (tScreenR.size.width - tDisplayR.size.width) / 2;
	self.display.frame = tDisplayR;

	offsetX = tButtonsR.size.width + 10;
	offsetY = tButtonsR.size.height + 10;
	tWidth = offsetX * 4 - 10;
	for (int i = 0; i < 4; i++) {
		for (int j = 0; j < 4; j++) {
			UIButton *btn = (UIButton *)self.buttons[i * 4 + j];
			tButtonsR.origin.x = (tScreenR.size.width - tWidth) / 2 + j * offsetX;
			btn.frame = tButtonsR;
		}
		tButtonsR.origin.y = tButtonsR.origin.y + offsetY;
	}
	self.display.font = [UIFont systemFontOfSize:self.display.frame.size.height];
}

#pragma mark - infoButton method
- (void)initInfoButton {
	self.infoButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
	[self.infoButton setTitle:@"i" forState:UIControlStateNormal];
	[self.infoButton addTarget:self action:@selector(buttonClicked_Infomation:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:self.infoButton];
}

- (void)buttonClicked_Infomation:(id)sender {
	kdanInfoViewController *infovc = [[kdanInfoViewController alloc] init];
	/*infovc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	   [self presentViewController:infovc animated:YES completion:nil];*/
	[self.navigationController pushViewController:infovc animated:YES];
	[infovc release];
}

#pragma mark - display method
- (void)initDisplay {
	self.display = [[[UILabel alloc] init] autorelease];
	[self.display setTextAlignment:NSTextAlignmentRight];
	self.display.text = @"0";
	[self.view addSubview:self.display];
}

#pragma mark - buttons method
- (void)initButtons {
	NSArray *tTitles = [[NSArray alloc] initWithObjects:@"7", @"8", @"9", @"+",
	                    @"4", @"5", @"6", @"-",
	                    @"1", @"2", @"3", @"*",
	                    @"0", @"C", @"=", @"/", nil];
	for (int i = 0; i < 4; i++)
		for (int j = 0; j < 4; j++) {
			UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
			[btn setTitle:tTitles[i * 4 + j] forState:UIControlStateNormal];
			[btn addTarget:self action:@selector(buttonClicked_Numopt:) forControlEvents:UIControlEventTouchUpInside];
			[btn.layer setCornerRadius:10];
			[btn.layer setBorderWidth:1.5f];
			[btn.layer setBorderColor:[UIColor grayColor].CGColor];
			[btn setBackgroundColor:[UIColor whiteColor]];
			[self.buttons addObject:btn];
			[self.view addSubview:btn];
		}
	[tTitles release];
}

- (void)buttonClicked_Numopt:(id)sender {
	//NSLog(@"%@",[sender currentTitle]);
	NSString *input = [sender currentTitle];
	NSString *numSet = @"0123456789";
	NSString *optSet = @"+-*/";
	NSRange numRange = [numSet rangeOfString:input];
	NSRange optRange = [optSet rangeOfString:input];
	if (numRange.length > 0) {
		if ([self.display.text isEqualToString:@"0"]) {
			[self.num1 setString:input];
		}
		else {
			[self.num1 appendString:input];
		}
		self.display.text = [NSString stringWithString:self.num1];
		return;
	}
	if (optRange.length > 0) {
		self.opt = [NSString stringWithString:input];
		if (self.num1 && [self.num1 length] != 0) {
			[self.num2 setString:self.num1];
		}
		[self.num1 setString:@""];
		return;
	}
	if ([input isEqualToString:@"C"]) {
		self.display.text = @"0";
		_result = 0.0f;
		[self.num1 setString:@""];
		[self.num2 setString:@""];
		return;
	}
	if ([input isEqualToString:@"="]) {
		if ([self.opt isEqualToString:@"+"]) {
			_result = [self.num2 floatValue] + [self.num1 floatValue];
		}
		if ([self.opt isEqualToString:@"-"]) {
			_result = [self.num2 floatValue] - [self.num1 floatValue];
		}
		if ([self.opt isEqualToString:@"*"]) {
			_result = [self.num2 floatValue] * [self.num1 floatValue];
		}
		if ([self.opt isEqualToString:@"/"]) {
			_result = [self.num2 floatValue] / [self.num1 floatValue];
		}
		[self.num1 setString:@""];
		self.opt = @"";
		[self.num2 setString:[NSMutableString stringWithFormat:@"%.f", _result]];
		self.display.text = [NSString stringWithString:self.num2];
	}
}

#pragma mark - rotate method
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration {
	[self updateCurInterface:toInterfaceOrientation];
}


#pragma mark - other method

- (BOOL)isiPhone {
	return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone;
}

- (void)dealloc {
	[_display release];
	[_num1 release];
	[_num2 release];
	[_opt release];
	[_infoButton release];
	[_buttons release];
	[super dealloc];
}

@end
