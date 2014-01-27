//
//  AddTweetVC.m
//  twitter
//
//  Created by Dinesh Joshi on 1/26/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "AddTweetVC.h"
#import "UIImageView+AFNetworking.h"
#import "TwitterClient.h"


@interface AddTweetVC ()

@property (assign, nonatomic) NSString *replyStatusId;
@property (retain, nonatomic) NSString *tweetText;

@end

@implementation AddTweetVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Compose Tweet";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"<" style:UIBarButtonItemStylePlain target:self action:@selector(onBackButton)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStylePlain target:self action:@selector(onTweetButton)];
    
    // Set the user's name, avatar etc.
    User *user = [User currentUser];
    
    self.userNameLabel.text = user.name;
    self.userTwitterHandleLabel.text = user.screenName;
    [self.userImageView setImageWithURL:user.profileImageURL];
    
    if (self.tweetText) {
        self.tweetTextView.text = [NSString stringWithFormat:@"@%@ ",self.tweetText];
    }
    
    [self.tweetTextView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onBackButton
{
    NSLog(@"Back");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ComposeModalDismissed"
                                                        object:nil
                                                      userInfo:nil];
    [self.navigationController dismissViewControllerAnimated:YES completion:^(void){}];
}

- (void)onTweetButton
{
    NSLog(@"Tweet");
    NSString *replyStatusId = @"";
    
    [[TwitterClient instance] doTweetStatus:self.tweetTextView.text inReplyToStatusId:replyStatusId success:^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"%@", response);
        [self onBackButton];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        [self onBackButton];
    }];

}


- (id)initWithTweetOrReply:(NSString *)_tweetText replyStatusId:(NSString *) _replyStatusId
{
    self = [super initWithNibName:@"AddTweetVC" bundle:nil];
    if (self) {
        self.tweetText = _tweetText;
        self.replyStatusId = _replyStatusId;
    }
    return self;
}

@end
