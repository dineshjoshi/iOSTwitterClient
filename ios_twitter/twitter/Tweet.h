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


+ (NSMutableArray *)tweetsWithArray:(NSArray *)array;

@end
