//
//  MessagesViewController.m
//  testing swiping
//
//  Created by Mattthew Bailey on 8/26/15.
//  Copyright (c) 2015 Richard Kim. All rights reserved.
//

#import "MessagesViewController.h"
#import "SummonerController.h"
#import "SummonerTableViewCell.h"
#import "FirechatViewController.h"
#import "Firebase/Firebase.h"

static NSString *rootURL = @"https://lolduofinder.firebaseio.com";


@interface MessagesViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic)UITableView *tableView;

@end

@implementation MessagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"Matches"];
    self.view.backgroundColor = [UIColor yellowColor];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.tableView registerClass:[SummonerTableViewCell class] forCellReuseIdentifier:@"cellID"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [SummonerController sharedInstance].matches.count;
    
}

- (SummonerTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SummonerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    
    Summoner *summoner = [SummonerController sharedInstance].matchesSummoners[indexPath.row];
    
    cell.textLabel.text = summoner.summonerName;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    __block FirechatViewController *firechatViewController = [FirechatViewController new];
    Summoner *summoner = [SummonerController sharedInstance].matchesSummoners[indexPath.row];
    
    firechatViewController.name = summoner.summonerName;
    
    Firebase *ref = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"%@/users", rootURL]];
    
    firechatViewController.myUID = [NSString stringWithString:ref.authData.uid];
    
    [[[ref childByAppendingPath:ref.authData.uid] childByAppendingPath:@"matches"] observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSLog(@"%@", snapshot.value);
        NSArray *matches = [NSArray arrayWithArray: [snapshot.value allKeys]];
        firechatViewController.matchUID = matches[indexPath.row];
        [self.navigationController pushViewController:firechatViewController animated:YES];
    }];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
