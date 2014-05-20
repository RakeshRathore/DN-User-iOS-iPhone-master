//
//  YoutubeParser.h
//  Groopling
//
//  Created by Sajith KG on 28/10/13.
//
//

#import <Foundation/Foundation.h>
@interface YoutubeParser : NSObject

+(BOOL) isValidateYoutubeURL:(NSString * )youtubeURL;

+(NSArray *) parseHTML:(NSString *)html ;
+ (NSString*)getYoutubeVideoID:(NSString*)url;
@end