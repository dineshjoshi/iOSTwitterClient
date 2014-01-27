//
//  ViewTweetVC.m
//  twitter
//
//  Created by Dinesh Joshi on 1/26/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "ViewTweetVC.h"
#import "UIImageView+AFNetworking.h"
#import "TwitterClient.h"
#import "AddTweetVC.h"

@interface ViewTweetVC ()

@end

@implementation ViewTweetVC


- (id) initWithTweet:(Tweet *) tweet
{
    self = [super initWithNibName:@"ViewTweetVC" bundle:nil];
    if (self) {
        self.title = @"Tweet";
        self.tweet = tweet;
    }
    return self;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)onFavouriteClick:(id)sender {
}

- (void)viewDidLoad
{
    [super viewDidLoad];

//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancelButton)];
//
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Compose" style:UIBarButtonItemStylePlain target:self action:@selector(onComposeButton)];
    
    self.nameLabel.text = self.tweet.name;
    
    // profile image
    [self.profileImageView setImageWithURL: [[NSURL alloc] initWithString:self.tweet.profile_image_url]];
    
    
    self.nameLabel.text = self.tweet.name;
    self.screenNameLabel.text = self.tweet.screen_name;
    self.tweetTextLabel.text = self.tweet.text;
    
    // TODO: cache for efficiency
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    
    NSString *formattedDateString = [dateFormatter stringFromDate:self.tweet.created_at_date];

    self.tweetTimeLabel.text = formattedDateString; // TODO: Format this
    self.tweetStatsLabel.text = [NSString stringWithFormat:@"%@ RETWEETS %@ FAVORITE", self.tweet.retweet_count, self.tweet.favorite_count] ; // TODO
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onReplyButtonClick:(id)sender
{
    AddTweetVC *addTweetVC = [[AddTweetVC alloc] initWithTweetOrReply:self.tweet.screen_name replyStatusId:self.tweet.status_id];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:addTweetVC];
    [self presentViewController:nvc animated:YES completion:nil];
}


- (IBAction)onRetweetButtonClick:(id)sender
{
    [[TwitterClient instance] doRetweet:self.tweet.status_id success:^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"%@", response);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Retweet"
                                                        message:@"Retweeted!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Could not retweet!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }];
}

- (IBAction)onFavoriteButtonClick:(id)sender {
    NSLog(@"%@", @"favorite");

    [[TwitterClient instance] makeFavorite:self.tweet.status_id success:^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"%@", response);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Favorited"
                                                        message:@"Your tweet was successfully favorited!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Your tweet was not favorited!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }];

}





@end
