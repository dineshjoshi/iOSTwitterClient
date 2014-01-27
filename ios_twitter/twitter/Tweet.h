//
//  Tweet.h
//  twitter
//
//  Created by Timothy Lee on 8/5/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tweet : RestObject

// profile_image_url, name, screen_name, retweeted_status
@property (nonatomic, strong, readonly) NSString *text;
@property (nonatomic, strong, readonly) NSString *profile_image_url;
@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSString *screen_name;
@property (nonatomic, strong, readonly) NSString *created_at;
@property (nonatomic, strong, readonly) NSDate *created_at_date;
@property (nonatomic, assign, readonly) NSString *status_id;
@property (nonatomic, assign, readonly) NSString *favorite_count;
@property (nonatomic, assign, readonly) NSString *retweet_count;


+ (NSMutableArray *)tweetsWithArray:(NSArray *)array;

@end
