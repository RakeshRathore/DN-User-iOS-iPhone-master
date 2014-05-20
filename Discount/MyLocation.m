//
//  MyLocation.m
//  CrimePlotter
//
//  Created by Ray Wenderlich on 5/21/12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyLocation.h"

@implementation MyLocation
@synthesize name = _name;
@synthesize subName=_subName;
@synthesize coordinate = _coordinate;
@synthesize color=_color;
@synthesize mapimage=_mapimage;
@synthesize Id=_Id;
@synthesize type=_type;;

- (id)initWithName:(NSString*)name :(NSString *)subName :(NSString *)ID  mapImageUrl:(NSURL *)imageUrl :(CLLocationCoordinate2D)coordinates colour:(UIColor *)colour andType:(NSString*) type{
    if ((self = [super init])) {
        _name =[name copy];
        _coordinate = coordinates;
        _color=colour;
        _mapimage=imageUrl;
        _Id=[ID copy];
        _subName=[subName copy];
        _type = [type copy];
    }
    return self;
}

- (id)initWithName:(NSString*)name andID:(NSString *)ID andCoordinate:(CLLocationCoordinate2D)coordinate {
    if ((self = [super init])) {
        _name =[name copy];
        _coordinate = coordinate;
        _color=[UIColor clearColor];
        _mapimage=[NSURL URLWithString:@""];
        _Id=[ID copy];
        _subName=@"";
        _type = @"";
    }
    return self;
}

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate andTag:(NSString*)tag andName:(NSString*)name andSubName:(NSString *)subName {
    if ((self = [super init])) {
         _name =[name copy];
        _coordinate = coordinate;
        _color=[UIColor clearColor];
        _mapimage=[NSURL URLWithString:@""];
        _Id=[tag copy];
       _subName=[subName copy];
        _type = @"";
    }
    
    return self;
}

- (NSString *)title {
    return _name;
}

-(NSString *)subtitle{
    return _subName;
}

-(NSString *)type{
    return _type;
}

-(NSURL *)image{
    return _mapimage;
}

- (void)dealloc
{
    _name = nil;
    _mapimage=nil;
}

@end