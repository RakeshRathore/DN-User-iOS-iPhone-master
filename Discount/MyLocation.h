//
//  MyLocation.h
//  CrimePlotter
//
//  Created by Ray Wenderlich on 3/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyLocation : NSObject <MKAnnotation> {
    NSString *_name,*_subName,*_type;
    CLLocationCoordinate2D _coordinate;
    UIColor *_color;
    NSString *_Id;
    NSURL *_mapimage;
}

@property (nonatomic,copy) NSString *name,*subName,*Id,*type;
@property (nonatomic, retain) UIColor *color;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property(nonatomic,retain)NSURL *mapimage;

- (id)initWithName:(NSString*)name :(NSString *)subName :(NSString *)ID  mapImageUrl:(NSURL *)imageUrl :(CLLocationCoordinate2D)coordinates colour:(UIColor *)colour andType:(NSString*)type;

- (id)initWithName:(NSString*)name andID:(NSString *)ID andCoordinate:(CLLocationCoordinate2D)coordinate;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate andTag:(NSString*)tag andName:(NSString*)name andSubName:(NSString *)subName;

@end
