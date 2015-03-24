//
//  ViewController.m
//  Drop
//
//  Created by tangbin on 3/19/15.
//  Copyright (c) 2015 tangbin. All rights reserved.
//

#import "ViewController.h"
#import "DropitBehavior.h"
#import "BezierPathView.h"

@interface ViewController () <UIDynamicAnimatorDelegate>
@property (weak, nonatomic) IBOutlet BezierPathView *gameView;
@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic) DropitBehavior *dropitBehavior;
@property (strong, nonatomic) UIAttachmentBehavior *attachBehavior;
@property (strong, nonatomic) UIView* dropview;
@end

@implementation ViewController
static const CGSize DROP_SIZE={40,40};
- (IBAction)tap:(id)sender {
    [self drop];
}

- (IBAction)panCatch:(UIPanGestureRecognizer *)sender {
    CGPoint gesturePoint =[sender locationInView:self.gameView];
    if(sender.state == UIGestureRecognizerStateBegan)
    {
        [self attachDroppingViewToPoint:gesturePoint];
    }else if(sender.state == UIGestureRecognizerStateChanged)
    {
        self.attachBehavior.anchorPoint=gesturePoint;
    }else if(sender.state == UIGestureRecognizerStateEnded)
    {
        [self.animator removeBehavior:self.attachBehavior];
        self.gameView.path=nil;
    }
        
}

-(void)attachDroppingViewToPoint:(CGPoint)anchorPoint
{
    if(self.dropview)
    {
        self.attachBehavior=[[UIAttachmentBehavior alloc] initWithItem:self.dropview attachedToAnchor:anchorPoint];
        __weak ViewController *weakSelf=self;
        self.attachBehavior.action=^{
            UIView *droppingView=weakSelf.dropview;
            UIBezierPath *path =[[UIBezierPath alloc]init];
            [path moveToPoint:weakSelf.attachBehavior.anchorPoint];
            [path addLineToPoint:droppingView.center];
            weakSelf.gameView.path=path;
        };
        
        [self.animator addBehavior:self.attachBehavior];
    }
}

-(UIDynamicAnimator *)animator
{
    if(!_animator)
    {
        _animator =[[UIDynamicAnimator alloc] initWithReferenceView:self.gameView];
        _animator.delegate = self;
        [self.animator addBehavior:self.dropitBehavior];
    }
    return _animator;
}

-(DropitBehavior *)dropitBehavior{
    if(!_dropitBehavior)
    {
        _dropitBehavior=[[DropitBehavior alloc]init];
        [self.animator addBehavior:_dropitBehavior];
    }
    return _dropitBehavior;
}
-(void)drop
{
    CGRect frame;
    frame.origin=CGPointZero;
    frame.size = DROP_SIZE;
    int x = (arc4random()%(int)self.gameView.bounds.size.width)/DROP_SIZE.width;
    frame.origin.x=x*DROP_SIZE.width;
    
    UIView *dropView = [[UIView alloc] initWithFrame:frame];
    self.dropview=dropView;
    dropView.backgroundColor = [self randomColor];
    
    [self.gameView addSubview:dropView];
    [self.dropitBehavior addItem:dropView];//the order is important,addSubview first
}

-(UIColor *)randomColor
{
    switch (arc4random()%5) {
        case 0:
            return [UIColor greenColor];
            break;
        case 1:
            return [UIColor blueColor];
        case 2:
            return [UIColor orangeColor];
        case 3:
            return [UIColor redColor];
        case 4:
            return [UIColor purpleColor];
        default:
            break;
    }
    return [UIColor blackColor];
}
-(void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator
{
    [self removeCompleteRows];
}

-(BOOL)removeCompleteRows
{
    NSMutableArray *dropsToRemove =[[NSMutableArray alloc]init];
    for(CGFloat y=self.gameView.bounds.size.height-DROP_SIZE.height/2;y>0;y-=DROP_SIZE.height)
    {
        BOOL rowIsComplete=YES;
        NSMutableArray *dropsFound=[[NSMutableArray alloc] init];
        for(CGFloat x=DROP_SIZE.width/2;x<=self.gameView.bounds.size.width-DROP_SIZE.width/2;x+=DROP_SIZE.width)
        {
            UIView *hitView =[self.gameView hitTest:CGPointMake(x, y) withEvent:NULL];
            if([hitView superview]==self.gameView)
            {
                [dropsFound addObject:hitView];
            }else{
                rowIsComplete=NO;
                break;
            }
        }
        if(![dropsFound count])break;
        if(rowIsComplete)[dropsToRemove addObjectsFromArray:dropsFound];
        
        if([dropsToRemove count])
        {
            for(UIView *drop in dropsToRemove)
                {
                    [self.dropitBehavior removeItem:drop];
                }
                [self animateRemovingDrops:dropsToRemove];
        }
        
    }
    return NO;
}

-(void)animateRemovingDrops:(NSArray *)dropstoRemove
{
    [UIView animateWithDuration:1.0
                      animations:^{
                          for(UIView *drop in dropstoRemove)
                          {
                              int x = (arc4random()%(int)(self.gameView.bounds.size.width*5))-(int)self.gameView.bounds.size.width*2;
                              int y=self.gameView.bounds.size.height;
                              drop.center = CGPointMake(x, -y);
                          }
                      }
                      completion:^(BOOL finished){
                          [dropstoRemove makeObjectsPerformSelector:@selector(removeFromSuperview)];}];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
