//
//  ViewController.m
//  BugzBook
//
//  Created by SaTHYa on 11/04/17.
//  Copyright © 2017 SaTHYa. All rights reserved.
//

#import "ViewController.h"
#import "CustomTableCell.h"
#import "Issues.h"
#import "Comments.h"
#import "Reachability.h"
#import "SyncEngine.h"
#import "NSDate+Date.h"
#import "UILabel+Label.h"
#import "ProgressHUD.h"
#import "UIButton+Button.h"


typedef enum{
    IssueType=0,
    CommentType
}TabelCellType;

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *sycnButton;
@property (weak, nonatomic) IBOutlet UILabel *totalCountLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *tableArray;
@property(nonatomic,assign) TabelCellType tableType;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getIssuesFromServer];
    self.backButton.hidden = true;
    [self.totalCountLabel setTitleTheme];
    self.tableView.estimatedRowHeight = 500.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.bounds.size.width, 0.01f)];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.bounds.size.width, 0.01f)];
    [self.sycnButton setDefaultTheme];
}

- (IBAction)backPressed:(id)sender {
    self.backButton.hidden = true;
    self.sycnButton.hidden = false;
    [self getIssuesFromServer];
}

- (IBAction)syncPressed:(id)sender {
    [self getIssuesFromServer];
}

//tableview delegate methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    [self.totalCountLabel attributedText:[NSString stringWithFormat:@"%lu\n",(unsigned long)[self.tableArray count]] firstTextFont: [UIFont fontWithName:@"Helvetica-BoldOblique" size:14] firstTextColor: [UIColor colorWithRed:(float)171/255 green:(float)171/255 blue:(float)171/255 alpha:.8] secondText: @"Total Counts"secondTextFont: [UIFont fontWithName:@"HelveticaNeue" size:12] secondTextColor: [UIColor whiteColor]];
    return [self.tableArray count] ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.estimatedRowHeight = 500.0;
    tableView.rowHeight = UITableViewAutomaticDimension;
    static NSString *simpleTableIdentifier = @"CustomTableCell";
    CustomTableCell *cell = (CustomTableCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        [cell.topLabel setTitleCellTheme];
        [cell.bottomLabel setBodyCellTheme];
    }
    if (self.tableType == IssueType) {
        Issues *issue = self.tableArray[indexPath.row];
        cell.topLabel.text = issue.title;
        NSString *body = issue.body;
        if ([body length]>140) {
            body = [NSString stringWithFormat:@"%@..",[body substringToIndex:138]];
        }
        cell.bottomLabel.text = body;
        return cell;
    } else {
        Comments *comment = self.tableArray[indexPath.row];
        cell.topLabel.text = comment.login;
        cell.bottomLabel.text = comment.body;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tableType == IssueType) {
        Issues *issue = self.tableArray[indexPath.row];
        [self getCommentsFromServer:issue.comments_url];
    }
    
}

//private methods
- (BOOL)isConnected {
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}

- (void)getIssuesFromServer {
    self.tableType = IssueType;
    [ProgressHUD showHUD];
    NSFetchRequest *fetchRequest;
    fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Issues"];
    [fetchRequest setSortDescriptors:@[[[NSSortDescriptor alloc] initWithKey: @"updated_at" ascending: NO]]];
    [fetchRequest setPredicate:nil];
    if ([self isConnected]) {
        NSString *url = [NSString stringWithFormat:@"https://api.github.com/repos/crashlytics/secureudid/issues?sincee=%@",[[[NSDate date] dateByAddingTimeInterval:-24 * 60 * 60] getGITDateString]];
        [[SyncEngine sharedInstance] fetchFilesAsynchronouslyWithURL:url withSuccess:^(id responseObjects) {
            self.tableType = IssueType;
            [[SyncEngine sharedInstance]saveIssues:responseObjects withSuccess:^(id responseObjects) {
                [self fetchAndReloadTabelView:fetchRequest];
            }];
        }];
    } else {
        [self displayAlertWithTitle:@"Network Error" message:@"Kindly check your network connection" donePress:^(id responseObjects) {
            [self fetchAndReloadTabelView:fetchRequest];
        }];
    }
}

- (void)fetchAndReloadTabelView:(NSFetchRequest*)fetchRequest {
    [[MOC sharedInstance]readDataInContext:[[MOC sharedInstance] childManagedObjectContext] fetchRequest:fetchRequest withSuccess:^(id responseObjects) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.tableArray = responseObjects;
            [self.tableView reloadData];
            [ProgressHUD closeHUD];
        });
    } failure:^(NSString *failureReason) {
        [ProgressHUD closeHUD];
    }];
}

- (void)getCommentsFromServer:(NSString*)url {
    self.tableType = CommentType;
    [ProgressHUD showHUD];
    NSFetchRequest *fetchRequest;
    fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Comments"];
    [fetchRequest setSortDescriptors:@[]];
    [fetchRequest setPredicate:nil];
    if ([self isConnected]) {
    [[SyncEngine sharedInstance] fetchFilesAsynchronouslyWithURL:url withSuccess:^(id responseObjects) {
        [[SyncEngine sharedInstance]saveComments:responseObjects withSuccess:^(id responseObjects) {
            [self fetchAndReloadTabelView:fetchRequest];
            self.backButton.hidden = false;
            self.sycnButton.hidden = true;
            [self.backButton setDefaultTheme];
        }];
    }];
    } else {
        [self displayAlertWithTitle:@"Network Error" message:@"Kindly check your network connection and retry" donePress:^(id responseObjects) {
            [self getIssuesFromServer];
        }];
    }
}

- (void)displayAlertWithTitle:(NSString*)title message:(NSString*)message donePress:(SuccessBlock)donePress {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* doneButton = [UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        donePress(@"Success");
    }];
    [alert addAction:doneButton];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end