//
//  MenuViewController.m
//  testing swiping
//
//  Created by Mattthew Bailey on 8/26/15.
//  Copyright (c) 2015 Richard Kim. All rights reserved.
//

#import "UserSettingsViewController.h"
#import "SummonerController.h"
#import "ChampionSkinDictionary.h"
#import "FirebaseNetworkController.h"
@interface UserSettingsViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *championTextField;
@property (weak, nonatomic) IBOutlet UITextField *skinTextField;

@property (strong, nonatomic) UITableView *tableView;
@end

@implementation UserSettingsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.championTextField.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.tableView.frame = CGRectMake(0, 500, self.view.frame.size.width, self.view.frame.size.height - 500);
    textField.inputView = self.tableView;
    [self.view addSubview:self.tableView];
    [textField reloadInputViews];
}

- (void)backButtonPressed{
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.25];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromRight];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.navigationController.view.layer addAnimation:animation forKey:kCATransition];

    [self.navigationController popViewControllerAnimated:NO];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[ChampionSkinDictionary championSkinDictionary] allKeys].count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    cell.textLabel.text = [ChampionSkinDictionary championList][indexPath.row];
    return cell;
    
}

@end
