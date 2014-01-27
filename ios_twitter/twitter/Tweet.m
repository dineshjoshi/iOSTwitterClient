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


+ (NSMutableArray *)tweetsWithArray:(NSArray *)array {
    NSMutableArray *tweets = [[NSMutableArray alloc] initWithCapacity:array.count];
    for (NSDictionary *params in array) {
        [tweets addObject:[[Tweet alloc] initWithDictionary:params]];
    }
    return tweets;
}

@end
