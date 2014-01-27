//
//  Tweet.m
//  twitter
//
//  Created by Timothy Lee on 8/5/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

- (NSString *)text {
    return [self.data valueOrNilForKeyPath:@"text"];
}

- (NSString *)profile_image_url {
    return [[self.data valueOrNilForKeyPath:@"user"] valueOrNilForKeyPath:@"profile_image_url"];
}

- (NSString *)name {
    return [[self.data valueOrNilForKeyPath:@"user"] valueOrNilForKeyPath:@"name"];
}

- (NSString *)screen_name {
    return [[self.data valueOrNilForKeyPath:@"user"] valueOrNilForKeyPath:@"screen_name"];
}

- (NSString *)created_at {
    return [self.data valueOrNilForKeyPath:@"created_at"];
}

- (NSString *)favorite_count {
    return [self.data valueOrNilForKeyPath:@"favorite_count"];
}

- (NSString *)retweet_count {
    return [self.data valueOrNilForKeyPath:@"retweet_count"];
}


- (NSString *)status_id {
    return [self.data valueOrNilForKeyPath:@"id"];
}

+ (NSMutableArray *)tweetsWithArray:(NSArray *)array {
    NSMutableArray *tweets = [[NSMutableArray alloc] initWithCapacity:array.count];
    for (NSDictionary *params in array) {
        [tweets addObject:[[Tweet alloc] initWithDictionary:params]];
    }
    return tweets;
}

- (NSDate *)created_at_date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    
    [dateFormatter setLocale:enUSPOSIXLocale];
    [dateFormatter setDateFormat:@"eee MMM dd HH:mm:ss ZZZZ yyyy"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    NSDate *date = [dateFormatter dateFromString:self.created_at];
    return date;
}

@end
