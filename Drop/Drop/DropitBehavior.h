//
//  DropitBehavior.h
//  Drop
//
//  Created by tangbin on 3/19/15.
//  Copyright (c) 2015 tangbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropitBehavior : UIDynamicBehavior

-(void)addItem:(id<UIDynamicItem>)item;
-(void)removeItem:(id<UIDynamicItem>)item;
@end
