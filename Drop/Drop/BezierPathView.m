//
//  BeziwePathView.m
//  Drop
//
//  Created by tangbin on 3/23/15.
//  Copyright (c) 2015 tangbin. All rights reserved.
//

#import "BezierPathView.h"

@implementation BezierPathView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setPath:(UIBezierPath *)path
{
    _path=path;
    [self setNeedsDisplay];
}
-(void)drawRect:(CGRect)rectP
{
    [self.path stroke];
}
@end
