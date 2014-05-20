//
//  YoutubeParser.m
//  Groopling
//
//  Created by Sajith KG on 28/10/13.
//
//


#import "YoutubeParser.h"

@interface YoutubeParser () {
}

@end

@implementation YoutubeParser

#define YOUTUBE_PATTERN @"(https?://)?(www\\.)?(youtu\\.be/|youtube\\.com)?(/|/embed/|/v/|/watch\\?v=|/watch\\?.+&v=)([\\w_-]{11})(&.+)?"


+(NSRegularExpression *)regex {
    
    static NSRegularExpression * regex = nil;
    
    regex =     [NSRegularExpression regularExpressionWithPattern:YOUTUBE_PATTERN
                                                          options:NSRegularExpressionCaseInsensitive
                                                            error:nil];
    
    return regex;
}
+(NSRegularExpression *)regex1 {
    static NSRegularExpression * regex1 = nil;
    regex1 =     [NSRegularExpression regularExpressionWithPattern:YOUTUBE_PATTERN
                                                           options:NSRegularExpressionCaseInsensitive
                                                             error:nil];
    
    return regex1;
}

+(BOOL) isValidateYoutubeURL:(NSString * )youtubeURL {
    NSInteger cnt = [[YoutubeParser regex] numberOfMatchesInString:youtubeURL options:0 range:NSMakeRange(0, [youtubeURL length])  ];
    return cnt > 0 ? YES : NO;
}

typedef void (^matching_block_t)  (NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop);

+(NSArray *) parseHTML:(NSString *)html {
    NSMutableArray * youtubeURLArray = [[NSMutableArray alloc] init];
    
    matching_block_t parseTask = ^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        NSRange youtubeKey = [result rangeAtIndex:5]; //the youtube key
        NSString * strKey = [html substringWithRange:youtubeKey] ;
        
        [youtubeURLArray addObject:strKey];
    };
    
    [[YoutubeParser regex] enumerateMatchesInString:html   options:0   range:NSMakeRange(0, [html length])   usingBlock:parseTask ];
    
    return youtubeURLArray;
}
+ (NSString*)getYoutubeVideoID:(NSString*)url {
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(?<=v(=|/))([-a-zA-Z0-9_]+)|(?<=youtu.be/)([-a-zA-Z0-9_]+)"
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    NSTextCheckingResult *match = [regex firstMatchInString:url
                                                    options:0
                                                      range:NSMakeRange(0, [url length])];
    NSString *substringForFirstMatch;
    if (match) {
        NSRange videoIDRange = [match rangeAtIndex:0];
        substringForFirstMatch = [url substringWithRange:videoIDRange];
    }
    return substringForFirstMatch;
}
@end