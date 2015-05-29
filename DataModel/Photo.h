//
//  Photo.h
//  
//
//  Created by tangbin on 4/15/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Photographer;

@interface Photo : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * subtitle;
@property (nonatomic, retain) NSString * photoURL;
@property (nonatomic, retain) NSString * thumbnailURL;
@property (nonatomic, retain) NSData * thumbnailData;
@property (nonatomic, retain) Photographer *whoTook;

@end
