//
//  DropitBehavior.m
//  Drop
//
//  Created by tangbin on 3/19/15.
//  Copyright (c) 2015 tangbin. All rights reserved.
//

#import "DropitBehavior.h"
@interface DropitBehavior()
@property (strong, nonatomic) UIGravityBehavior *gravity;
@property (strong, nonatomic) UICollisionBehavior *collosion;
@property (strong, nonatomic) UIDynamicItemBehavior *animationOptions;
@end

@implementation DropitBehavior

-(UICollisionBehavior *)collosion
{
    if(!_collosion)
    {
        _collosion =[[UICollisionBehavior alloc]init];
        _collosion.translatesReferenceBoundsIntoBoundary=YES;
        
    }
    return _collosion;
}

-(UIGravityBehavior *)gravity
{
    if(!_gravity)
    {
        _gravity = [[UIGravityBehavior alloc]init];
        _gravity.magnitude=1.0;
       
    }
    return _gravity;
    
}

-(UIDynamicItemBehavior *)animationOptions
{
    if(!_animationOptions){
        _animationOptions=[[UIDynamicItemBehavior alloc]init];
        _animationOptions.allowsRotation=NO;
    }
    return _animationOptions;
}

-(void)addItem:(id<UIDynamicItem>)item;
{
    [self.gravity addItem:item];
     [self.collosion addItem:item];
    [self.animationOptions addItem:item];
}
-(void)removeItem:(id<UIDynamicItem>)item;
{
    [self.gravity removeItem:item];
    [self.collosion removeItem:item];
    [self.animationOptions removeItem:item];

}
-(instancetype)init
{
    self = [super init];
    [self addChildBehavior:self.gravity];
    [self addChildBehavior:self.collosion];
    [self addChildBehavior:self.animationOptions];
    return self;
}
@end
