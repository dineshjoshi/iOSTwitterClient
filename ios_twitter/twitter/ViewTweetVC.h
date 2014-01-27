//
//  ViewTweetVC.h
//  twitter
//
//  Created by Dinesh Joshi on 1/26/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewTweetVC : UIViewController


@property (nonatomic, retain) Tweet *tweet;

- (id) initWithTweet:(Tweet *) tweet;


@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetStatsLabel;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;

@end
