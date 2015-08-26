//
//  SummonerController.m
//  testing swiping
//
//  Created by Mattthew Bailey on 8/14/15.
//  Copyright (c) 2015 Richard Kim. All rights reserved.
//

#import "SummonerController.h"
#import "Summoner.h"
#import "Stack.h"
#import "NetworkController.h"

@implementation SummonerController

+ (SummonerController *)sharedInstance {
    static SummonerController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [SummonerController new];
 //Instantiate Shared Instance Properties
    });
    return sharedInstance;
}

#pragma mark - Create

- (Summoner *)createSummoner{
   
    Summoner *summoner = [NSEntityDescription insertNewObjectForEntityForName:@"Summoner" inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    
    
    return summoner;
}

#pragma mark - Retrieve

- (Summoner *)summoner {
    //Create request for model Data from CoreData Managed Object Context
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Summoner"];
    
    //Create error for fetch request error tracking.
    NSError *error;
    
    //Execute the fetch request and place it it in returnable instance of summoner.
    Summoner *summoner = [[Stack sharedInstance].managedObjectContext executeFetchRequest:request error:&error][0];
    
    if (error) {
        NSLog(@"Error fetching summoner: %@", error.localizedDescription);
    }
    
    return summoner;
    
}

#pragma mark - Update

//Saves managed object context to persistentStore
- (void)save {
    [[Stack sharedInstance].managedObjectContext save:nil];
}

#pragma mark - Delete

- (void)removeEntry:(Summoner *)summonerToBeDeleted {
    [summonerToBeDeleted.managedObjectContext delete:summonerToBeDeleted];
}

@end
