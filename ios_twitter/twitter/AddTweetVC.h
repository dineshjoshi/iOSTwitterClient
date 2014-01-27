//
//  AddTweetVC.h
//  twitter
//
//  Created by Dinesh Joshi on 1/26/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddTweetVC : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userTwitterHandleLabel;
@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;

- (id)initWithTweetOrReply:(NSString *)_tweetText replyStatusId:(NSString *) _replyStatusId;

@end
