//
//  VerifyRegistrationViewController.m
//  testing swiping
//
//  Created by Mattthew Bailey on 8/27/15.
//  Copyright (c) 2015 Richard Kim. All rights reserved.
//

#import "VerifyRegistrationViewController.h"
#import "NetworkController.h"
#import "WelcomeViewController.h"
#import "AppearanceController.h"
#import "LOLLabel.h"
#import "Firebase/Firebase.h"

static NSString *rootURL = @"https://intense-inferno-4374.firebaseio.com";

@interface VerifyRegistrationViewController ()

@property (nonatomic, strong) LOLLabel *codeLabel;
@property (nonatomic, strong) NSString *randomCode;
@property (nonatomic, strong) UIButton *verifyButton;

@end

@implementation VerifyRegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    [self setRandomCode];
    
    self.codeLabel = [[LOLLabel alloc] initWithFrame:CGRectMake(10, 70, 200, 40)];
    self.codeLabel.text = self.randomCode;
    
    self.verifyButton = [[UIButton alloc] initWithFrame:CGRectMake(200, 200, 100, 100)];
    self.verifyButton.backgroundColor = [UIColor purpleColor];
    [self.verifyButton setTitle:@"Verify" forState:UIControlStateNormal];
    [self.verifyButton addTarget:self action:@selector(verifyButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.codeLabel];
    [self.view addSubview:self.verifyButton];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setRandomCode {
    
    NSMutableString *code = [NSMutableString new];
    int numberOfCharacters = 15;
    
    char characters[] = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'};
    
    for (int i = 0; i < numberOfCharacters; i++) {
        
        [code appendString:[NSString stringWithFormat:@"%c", characters[arc4random_uniform(26)]]];
        
    }
    
    self.randomCode = code;
    
}


- (void)verifyButtonPressed {
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURL *url = [NSURL URLWithString:[NetworkController getMasteriesForSummonerURLWithSummoner:self.summoner]];
    
    //NSLog(@"%@", url);
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error) {
            NSLog(@"%@", error.localizedDescription);
        }
        else {
            //  NSLog(@"%@", data); //Uncomment to log data.
            
            NSError *serializationError;
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&serializationError];
            
           // NSLog(@"%@", responseDictionary); //Uncomment to log dictionary
            
            //Do stuff here with dictionary
            [self checkForMatchingMasteryPage:responseDictionary];
            
        }
        //completion();
    }];
    [dataTask resume];
    
    
}

- (void)checkForMatchingMasteryPage:(NSDictionary *)dictionary {
    
    NSDictionary *summonerStuff = dictionary[[self.summoner.summonerID stringValue]];
    NSArray *masteryPages = summonerStuff[@"pages"];
    
    for (int i = 0; i < masteryPages.count; i++) {
        NSDictionary *masteryPage = masteryPages[i];
        NSString *masteryName = masteryPage[@"name"];
        if([masteryName isEqualToString: self.randomCode]) {
            //Create Account?
            NSLog(@"You're Verified!!!");
            
            [self createAccount];
            
            break;
        }
    }
    
}

- (void) createAccount {
//    Firebase *dataReference = [[Firebase alloc] initWithUrl:rootURL];
//    dataReference childByAppendingPath:@"/%@",[dataReference.authData.uid]
//    
//    dataReference.u

    
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
