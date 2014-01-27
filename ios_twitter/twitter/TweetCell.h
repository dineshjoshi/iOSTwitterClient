//
//  TweetCell.h
//  twitter
//
//  Created by Timothy Lee on 8/6/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UIImageView *profile_image_view;
@property (nonatomic, weak) IBOutlet UILabel *handle_label;
@property (nonatomic, weak) IBOutlet UILabel *displayname_label;
@property (weak, nonatomic) IBOutlet UITextView *tweet_text;
@property (weak, nonatomic) IBOutlet UILabel *time_label;

@end
