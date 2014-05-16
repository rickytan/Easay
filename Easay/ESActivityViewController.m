//
//  ESActivityViewController.m
//  Easay
//
//  Created by ricky on 14-5-9.
//  Copyright (c) 2014年 ricky. All rights reserved.
//

#import "ESActivityViewController.h"
#import "UIColor+RExtension.h"
#import "ESSegmentView.h"

@interface ESActivityViewController ()
@property (nonatomic, assign) IBOutlet ESSegmentView *segmentView;
@end

@implementation ESActivityViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.segmentView.segments = @[@2, @3, @8];
    self.segmentView.titles = @[@"BUS", @"SUBWAY", @"OIL"];
    
    [self.segmentView performSelector:@selector(setSegments:)
               withObject:@[@4, @1, @5]
               afterDelay:2];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
