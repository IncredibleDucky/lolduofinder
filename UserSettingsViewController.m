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
@interface UserSettingsViewController () <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *championTextField;
@property (strong, nonatomic) UIPickerView *pickerView;

@end

@implementation UserSettingsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.pickerView = [[UIPickerView alloc] init];
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setBarStyle:UIBarStyleDefault];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(resignPickerView:)];
    doneButton.tintColor = [UIColor blackColor];
    toolbar.items = @[doneButton];
    
    self.championTextField.delegate = self;
    self.championTextField.inputView = self.pickerView;
    self.championTextField.inputAccessoryView = toolbar;
    self.championTextField.text = [SummonerController sharedInstance].summoner.favoriteChampion;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
-   (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [ChampionSkinDictionary championList].count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [ChampionSkinDictionary championList][row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [SummonerController sharedInstance].summoner.favoriteChampion = [ChampionSkinDictionary championList][row];
    self.championTextField.text = [ChampionSkinDictionary championList][row];
}

- (void)resignPickerView:(id)sender{

    [self.championTextField	resignFirstResponder];
}
                                   
@end
