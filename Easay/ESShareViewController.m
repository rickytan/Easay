//
//  ESShareViewController.m
//  Easay
//
//  Created by ricky on 14-4-18.
//  Copyright (c) 2014年 ricky. All rights reserved.
//

#import "ESShareViewController.h"
#import "UIFont+ES.h"

@interface ESShareViewController () <UITextViewDelegate, UIDynamicItem>
@property (nonatomic, assign) IBOutlet UITextView * textView;
@property (nonatomic, assign) IBOutlet UIButton * editButton;

@property (nonatomic, strong) UIDynamicAnimator * animator;
@property (nonatomic, strong) UICollisionBehavior * collision;
@property (nonatomic, strong) UIGravityBehavior * gravity;
- (IBAction)onEdit:(id)sender;
- (IBAction)onCamera:(id)sender;
@end

@implementation ESShareViewController

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.textView.font = [UIFont lightFontWithSize:12];

    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.collision = [[UICollisionBehavior alloc] init];
    self.gravity = [[UIGravityBehavior alloc] init];

    CGFloat w = self.view.bounds.size.width;
    CGFloat h = self.view.bounds.size.height;
    [self.collision addBoundaryWithIdentifier:@"Top"
                               fromPoint:CGPointMake(0, 0)
                                 toPoint:CGPointMake(w, 0)];
    [self.collision addBoundaryWithIdentifier:@"Left"
                               fromPoint:CGPointMake(0, 0)
                                 toPoint:CGPointMake(0, h)];
    [self.collision addBoundaryWithIdentifier:@"Right"
                               fromPoint:CGPointMake(w, 0)
                                 toPoint:CGPointMake(w, h)];
    [self.collision addBoundaryWithIdentifier:@"Bottom"
                               fromPoint:CGPointMake(0, h)
                                 toPoint:CGPointMake(w, h)];
    self.collision.collisionMode = UICollisionBehaviorModeEverything;

    [self.animator addBehavior:self.collision];
    [self.animator addBehavior:self.gravity];
    
    [self makeBalloon];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)makeBalloon
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 96, 96)];
    view.layer.borderColor = [UIColor whiteColor].CGColor;
    view.layer.borderWidth = 3.0;
    view.layer.cornerRadius = 48.0;
    view.backgroundColor = [UIColor yellowColor];
    view.clipsToBounds = YES;
    [self.view addSubview:view];

    [self.gravity addItem:view];
    [self.collision addItem:view];
}

#pragma mark - Action

- (IBAction)onEdit:(id)sender
{
    if (self.textView.isEditable) {
        self.textView.editable = NO;
        [self.editButton setTitle:@"Edit"
                         forState:UIControlStateNormal];
    }
    else {
        self.textView.editable = YES;
        [self.textView becomeFirstResponder];
        [self.editButton setTitle:@"OK"
                         forState:UIControlStateNormal];
    }
}

- (IBAction)onCamera:(id)sender
{
    [self makeBalloon];
}

#pragma mark - UITextView

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.textView.layer.borderWidth = 1.0;
    self.textView.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    self.textView.layer.borderWidth = 0.0;
}

@end
