//
//  FirechatViewController.m
//  testing swiping
//
//  Created by Mattthew Bailey on 9/28/15.
//  Copyright (c) 2015 Richard Kim. All rights reserved.
//

#import "FirechatViewController.h"
#import "Firebase/Firebase.h"
#import "SummonerController.h"

static NSString *rootURL = @"https://lolduofinder.firebaseio.com";

@interface FirechatViewController () <UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic, strong) NSMutableArray *chat;
@property (nonatomic) BOOL newMessagesOnTop;

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation FirechatViewController


#pragma mark - Setup

// Initialization.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Initialize array that will store chat messages.
    self.chat = [[NSMutableArray alloc] init];
    
    self.title = self.name;
    
    //Set TableView.
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 50)];
    self.tableView.dataSource = self;
    
    //Set TextField.
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 50)];
    self.textField.delegate = self;
    self.textField.backgroundColor = [UIColor redColor];
    
    // Decide whether or not to reverse the messages
    self.newMessagesOnTop = NO;
    
    // This allows us to check if these were messages already stored on the server
    // when we booted up (YES) or if they are new messages since we've started the app.
    // This is so that we can batch together the initial messages' reloadData for a perf gain.
    __block BOOL initialAdds = YES;
    Firebase *myConvoRef = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"%@/users/%@/matches/%@/chat", rootURL, self.myUID, self.matchUID]];
    [myConvoRef observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        // Add the chat message to the array.
        if (self.newMessagesOnTop) {
            [self.chat insertObject:snapshot.value atIndex:0];
        } else {
            [self.chat addObject:snapshot.value];
        }
        
        // Reload the table view so the new message will show up.
        if (!initialAdds) {
            [self.tableView reloadData];
        }
    }];
//
//     Value event fires right after we get the events already stored in the Firebase repo.
//     We've gotten the initial messages stored on the server, and we want to run reloadData on the batch.
//     Also set initialAdds=NO so that we'll reload after each additional childAdded event.
    [myConvoRef observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        // Reload the table view so that the intial messages show up
        [self.tableView reloadData];
        initialAdds = NO;
    }];

    [self.view addSubview:self.tableView];
    [self.view addSubview:self.textField];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Text field handling

// This method is called when the user enters text in the text field.
// We add the chat message to our Firebase.
- (BOOL)textFieldShouldReturn:(UITextField*)aTextField
{
    [aTextField resignFirstResponder];
    
    // This will also add the message to our local array self.chat because
    // the FEventTypeChildAdded event will be immediately fired.
    
    Firebase *myConvoRef = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"%@/users/%@/matches/%@/chat", rootURL, self.myUID, self.matchUID]];
    [[myConvoRef childByAutoId] setValue:@{@"name" : [SummonerController sharedInstance].summoner.summonerName, @"text": aTextField.text}];
    
    Firebase *matchConvoRef = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"%@/users/%@/matches/%@/chat", rootURL, self.matchUID, self.myUID]];
    [[matchConvoRef childByAutoId] setValue:@{@"name" : [SummonerController sharedInstance].summoner.summonerName, @"text": aTextField.text}];
    
    [aTextField setText:@""];
    return NO;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    // We only have one section in our table view.
    return 1;
}

- (NSInteger)tableView:(UITableView*)table numberOfRowsInSection:(NSInteger)section
{
    // This is the number of chat messages.
    return [self.chat count];
}

// This method changes the height of the text boxes based on how much text there is.
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* chatMessage = [self.chat objectAtIndex:indexPath.row];
    
    NSString *text = chatMessage[@"text"];
    
    // typical textLabel.frame = {{10, 30}, {260, 22}}
    const CGFloat TEXT_LABEL_WIDTH = 260;
    CGSize constraint = CGSizeMake(TEXT_LABEL_WIDTH, 20000);
    
    // typical textLabel.font = font-family: "Helvetica"; font-weight: bold; font-style: normal; font-size: 18px
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:18] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping]; // requires iOS 6+
    const CGFloat CELL_CONTENT_MARGIN = 22;
    CGFloat height = MAX(CELL_CONTENT_MARGIN + size.height, 44);
    
    return height;
}

- (UITableViewCell*)tableView:(UITableView*)table cellForRowAtIndexPath:(NSIndexPath *)index
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [table dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:18];
        cell.textLabel.numberOfLines = 0;
    }
    
    NSDictionary* chatMessage = [self.chat objectAtIndex:index.row];
    
    cell.textLabel.text = chatMessage[@"text"];
    cell.detailTextLabel.text = chatMessage[@"name"];
    
    return cell;
}

#pragma mark - Keyboard handling

// Subscribe to keyboard show/hide notifications.
- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(keyboardWillShow:)
     name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(keyboardWillHide:)
     name:UIKeyboardWillHideNotification object:nil];
}

// Unsubscribe from keyboard show/hide notifications.
- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]
     removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]
     removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

// Setup keyboard handlers to slide the view containing the table view and
// text field upwards when the keyboard shows, and downwards when it hides.
- (void)keyboardWillShow:(NSNotification*)notification
{
    [self moveView:[notification userInfo] up:YES];
}

- (void)keyboardWillHide:(NSNotification*)notification
{
    [self moveView:[notification userInfo] up:NO];
}

- (void)moveView:(NSDictionary*)userInfo up:(BOOL)up
{
    CGRect keyboardEndFrame;
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]
     getValue:&keyboardEndFrame];
    
    UIViewAnimationCurve animationCurve;
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey]
     getValue:&animationCurve];
    
    NSTimeInterval animationDuration;
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey]
     getValue:&animationDuration];
    
    // Get the correct keyboard size to we slide the right amount.
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    
    CGRect keyboardFrame = [self.view convertRect:keyboardEndFrame toView:nil];
    int y = keyboardFrame.size.height * (up ? -1 : 1);
    self.view.frame = CGRectOffset(self.view.frame, 0, y);
    
    [UIView commitAnimations];
}

// This method will be called when the user touches on the tableView, at
// which point we will hide the keyboard (if open). This method is called
// because UITouchTableView.m calls nextResponder in its touch handler.
- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    if ([self.textField isFirstResponder]) {
        [self.textField resignFirstResponder];
    }
}

@end

