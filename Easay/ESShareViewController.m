//
//  ESShareViewController.m
//  Easay
//
//  Created by ricky on 14-4-18.
//  Copyright (c) 2014年 ricky. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#import "ESShareViewController.h"
#import "UIFont+ES.h"
#import "UIColor+RExtension.h"
#import "MRRope.h"

@interface ESScene : SKScene
@property (nonatomic, assign) SKNode * touchNode;
@property (nonatomic, strong) NSMutableArray * balloons;
- (SKNode *)makeBalloon;
@end

@implementation ESScene

- (instancetype)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    if (self) {
        self.scaleMode = SKSceneScaleModeAspectFit;
        self.backgroundColor = [UIColor themeColor];
        self.anchorPoint = CGPointMake(0, 0);
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        self.physicsBody.dynamic = NO;
    }
    return self;
}

- (NSMutableArray *)balloons
{
    if (!_balloons) {
        _balloons = [[NSMutableArray alloc] initWithCapacity:3];
    }
    return _balloons;
}

- (SKNode *)makeBalloon
{
    SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"balloon"];
    sprite.position = CGPointMake(160, 150);
    sprite.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:sprite.size.width / 2];
    sprite.physicsBody.affectedByGravity = NO;
    sprite.physicsBody.restitution = 0.0;
    [self.scene addChild:sprite];


    SKSpriteNode *node = [SKSpriteNode spriteNodeWithImageNamed:@"rope"];
    node.position = CGPointMake(sprite.position.x, CGRectGetMinY(sprite.frame) - node.size.height / 2);
    node.centerRect = CGRectMake(0, 0, 1, 1);
    node.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:node.size];
    [self.scene addChild:node];

    SKPhysicsJointPin *pin = [SKPhysicsJointPin jointWithBodyA:node.physicsBody
                                                         bodyB:sprite.physicsBody
                                                        anchor:CGPointMake(sprite.position.x, CGRectGetMaxY(node.frame))];
    [self.scene.physicsWorld addJoint:pin];

    for (int i=0; i < 20; ++i) {
        SKSpriteNode *rope = [SKSpriteNode spriteNodeWithImageNamed:@"rope"];
        rope.position = CGPointMake(node.position.x, node.position.y - node.size.height);
        rope.centerRect = CGRectMake(0, 0, 1, 1);
        rope.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:rope.size];
        [self.scene addChild:rope];

        SKPhysicsJointPin *pin = [SKPhysicsJointPin jointWithBodyA:rope.physicsBody
                                                             bodyB:node.physicsBody
                                                            anchor:CGPointMake(node.position.x, CGRectGetMinY(node.frame))];
        [self.scene.physicsWorld addJoint:pin];
        node = rope;
    }

    pin = [SKPhysicsJointPin jointWithBodyA:self.scene.physicsBody
                                      bodyB:node.physicsBody
                                     anchor:CGPointMake(node.position.x, CGRectGetMinY(node.frame))];
    [self.scene.physicsWorld addJoint:pin];

    [self.balloons addObject:sprite];
    if (self.balloons.count >= 3) {

    }
    return sprite;
}

- (void)update:(NSTimeInterval)currentTime
{
    for (SKNode *node in self.balloons) {
        [node.physicsBody applyForce:CGVectorMake(0, 1.0)];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    self.touchNode = [self nodeAtPoint:[touch locationInNode:self]];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.touchNode.position = [[touches anyObject] locationInNode:self];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{

}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{

}

@end

@interface ESShareViewController () <UITextViewDelegate>
@property (nonatomic, assign) IBOutlet UITextView * textView;
@property (nonatomic, assign) IBOutlet UIButton * editButton;
@property (nonatomic, assign) IBOutlet UIButton * addButton;
@property (nonatomic, assign) IBOutlet UIButton * weibo, * wechat, * path;
@property (nonatomic, strong) IBOutlet SKView * balloonView;

@property (nonatomic, strong) UIDynamicAnimator * animator;
@property (nonatomic, strong) UICollisionBehavior * collision;
@property (nonatomic, strong) UIGravityBehavior * gravity;
@property (nonatomic, assign) SKNode * mainBalloon;
@property (nonatomic, strong) ESScene * scene;
@property (nonatomic, strong) NSMutableArray * balloons;
- (IBAction)onEdit:(id)sender;
- (IBAction)onCamera:(id)sender;
- (IBAction)onAdd:(id)sender;
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

    self.scene = [ESScene sceneWithSize:self.balloonView.bounds.size];
    [self.balloonView presentScene:self.scene];
    self.balloonView.showsFPS = YES;
    self.balloonView.showsNodeCount = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action

- (IBAction)onAdd:(id)sender
{
    [self.scene makeBalloon];
    if (self.scene.balloons.count >= 3) {
        self.addButton.hidden = YES;
    }
}

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

}

#pragma mark - UIGesture

- (IBAction)onPan:(UIPanGestureRecognizer *)pan
{
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            
        }
            break;
        case UIGestureRecognizerStateChanged:
            pan.view.center = [pan locationInView:self.view];
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:

            break;
        default:
            break;
    }
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
