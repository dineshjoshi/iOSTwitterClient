//
//  TimelineVC.m
//  twitter
//
//  Created by Timothy Lee on 8/4/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "TimelineVC.h"
#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "TTTTimeIntervalFormatter.h"
#import "AddTweetVC.h"
#import "ViewTweetVC.h"


@interface TimelineVC ()

@property (nonatomic, strong) NSMutableArray *tweets;
@property (nonatomic, strong) UINib *cellNib;
@property (nonatomic, strong) TTTTimeIntervalFormatter *_timeIntervalFormatter;
- (void)onSignOutButton;
- (void)reload;
- (NSString *)userVisibleDateTimeStringForRFC3339DateTimeString:(NSString *)rfc3339DateTimeString;

@end

@implementation TimelineVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"Twitter";
        self.cellNib = [UINib nibWithNibName:@"TweetCell" bundle:nil];
        self._timeIntervalFormatter = nil;
        self._timeIntervalFormatter = [[TTTTimeIntervalFormatter alloc] init];
        [self._timeIntervalFormatter setLocale:[NSLocale currentLocale]];
        [self reload];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out" style:UIBarButtonItemStylePlain target:self action:@selector(onSignOutButton)];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Compose" style:UIBarButtonItemStylePlain target:self action:@selector(onComposeButton)];
    
//    [self.tableView registerClass:[TweetCell class]forCellReuseIdentifier:@"TweetCell"];
    [self.tableView registerNib:self.cellNib forCellReuseIdentifier:@"TweetCell"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;


    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TweetCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];

    Tweet *tweet = self.tweets[indexPath.row];
    TweetCell *twCell = (TweetCell *) cell;
    
    twCell.handle_label.text = [NSString stringWithFormat:@"@%@", tweet.screen_name];
    twCell.displayname_label.text = tweet.name;
    twCell.tweet_text.text = tweet.text;
    twCell.time_label.text = [self userVisibleDateTimeStringForRFC3339DateTimeString:tweet.created_at];
    
    [twCell.profile_image_view setImageWithURL:[NSURL URLWithString:tweet.profile_image_url]];

//    [NSString stringWithFormat:@"%@ %@ %@", tweet.name, tweet.screen_name, tweet.text];
    return twCell;
}

- (NSString *)userVisibleDateTimeStringForRFC3339DateTimeString:(NSString *)rfc3339DateTimeString {
    /*
     Returns a user-visible date time string that corresponds to the specified
     RFC 3339 date time string. Note that this does not handle all possible
     RFC 3339 date time strings, just one of the most common styles.
     */
    
    NSDateFormatter *rfc3339DateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    
    [rfc3339DateFormatter setLocale:enUSPOSIXLocale];
    [rfc3339DateFormatter setDateFormat:@"eee MMM dd HH:mm:ss ZZZZ yyyy"];
    [rfc3339DateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    // Convert the RFC 3339 date time string to an NSDate.
    NSDate *date = [rfc3339DateFormatter dateFromString:rfc3339DateTimeString];
    NSDate *tweetTime = date;
    
    NSString *userVisibleDateTimeString;
    NSTimeInterval timeInterval = 0;
    NSDate *curTime = [[NSDate alloc] init];
    timeInterval = [tweetTime timeIntervalSinceDate:curTime];
    NSLog(@"Interval = %f", timeInterval);
    [self._timeIntervalFormatter setUsesIdiomaticDeicticExpressions:YES];
    userVisibleDateTimeString = [self._timeIntervalFormatter stringForTimeInterval:timeInterval]; // TODO: Why does this not display minutes?
    return userVisibleDateTimeString;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Tweet *tweet = self.tweets[indexPath.row];
	NSString *twText = tweet.text;
    
	CGRect labelRect = [twText
                       boundingRectWithSize:CGSizeMake(
                                                       CGRectGetWidth(CGRectIntegral(tableView.bounds)),
                                                       MAXFLOAT)
                       options:NSStringDrawingUsesLineFragmentOrigin
                       attributes:nil
                       context:nil];
	return CGRectGetHeight(CGRectIntegral(labelRect)) + 50;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Tweet *tweet = self.tweets[indexPath.row];
    ViewTweetVC *vc = [[ViewTweetVC alloc] initWithTweet:tweet];
    [self.navigationController pushViewController:vc animated:YES];
}

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

#pragma mark - Private methods

- (void)onSignOutButton {
    [User setCurrentUser:nil];
}

- (void)onComposeButton {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reload)
                                                 name:@"ComposeModalDismissed"
                                               object:nil];
    
    AddTweetVC *addTweetVC = [[AddTweetVC alloc] initWithNibName:@"AddTweetVC" bundle:nil];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:addTweetVC];
    
    [self presentViewController:nvc animated:YES completion:nil];

}

- (void)reload {
    [[TwitterClient instance] homeTimelineWithCount:20 sinceId:0 maxId:0 success:^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"%@", response);
        self.tweets = [Tweet tweetsWithArray:response];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // Do nothing
    }];
}


@end
