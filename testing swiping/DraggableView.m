//
//  DraggableView.m
//  testing swiping
//
//  Created by Richard Kim on 5/21/14.
//  Copyright (c) 2014 Richard Kim. All rights reserved.
//
//  @cwRichardKim for updates and requests

#define ACTION_MARGIN 120 //%%% distance from center where the action applies. Higher = swipe further in order for the action to be called
#define SCALE_STRENGTH 4 //%%% how quickly the card shrinks. Higher = slower shrinking
#define SCALE_MAX .93 //%%% upper bar for how much the card shrinks. Higher = shrinks less
#define ROTATION_MAX 1 //%%% the maximum rotation allowed in radians.  Higher = card can keep rotating longer
#define ROTATION_STRENGTH 320 //%%% strength of rotation. Higher = weaker rotation
#define ROTATION_ANGLE M_PI/8 //%%% Higher = stronger rotation angle


#import "DraggableView.h"
#import "SummonerController.h"

@implementation DraggableView {
    CGFloat xFromCenter;
    CGFloat yFromCenter;
}

//delegate is instance of ViewController
@synthesize delegate;

@synthesize panGestureRecognizer;
@synthesize summonerName;
@synthesize summonerLeagueIcon;
@synthesize summonerProfileIcon;
@synthesize winsLossesLabel;
@synthesize lossesLabel;
@synthesize tierDivisionLabel;
@synthesize leaguePointsLabel;
@synthesize overlayView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
        
#warning placeholder stuff, replace with card-specific information {
        summonerName = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2 - 150, 200, 300, 25)];
        [summonerName setTextAlignment:NSTextAlignmentCenter];
        summonerName.textColor = [UIColor whiteColor];
        
        summonerLeagueIcon = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width/2 - 40, 10, 80, 80)];
        
        summonerProfileIcon = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width/2 - 100, 200, 25, 25)];

        
         winsLossesLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 250, 100, 25)];
        [winsLossesLabel setTextAlignment:NSTextAlignmentCenter];
        winsLossesLabel.textColor = [UIColor whiteColor];
        
         lossesLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 250, 100, 25)];
        [lossesLabel setTextAlignment:NSTextAlignmentCenter];
        lossesLabel.textColor = [UIColor whiteColor];
        
         tierDivisionLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2 - 100, 100, 200, 40)];
        [tierDivisionLabel setTextAlignment:NSTextAlignmentCenter];
        tierDivisionLabel.textColor = [UIColor whiteColor];
        
         leaguePointsLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2 - 100, 150, 200, 40)];
        [leaguePointsLabel setTextAlignment:NSTextAlignmentCenter];
        leaguePointsLabel.textColor = [UIColor whiteColor];
        
        self.backgroundColor = [UIColor darkGrayColor];
        
#warning placeholder stuff, replace with card-specific information }
        
        
#pragma mark - autolayout
        

        panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(beingDragged:)];
        
        [self addGestureRecognizer:panGestureRecognizer];
        
        //Add all subviews to card.
        [self addSubview:summonerName];
        [self addSubview:summonerLeagueIcon];
        [self addSubview:summonerProfileIcon];
        [self addSubview:winsLossesLabel];
        [self addSubview:lossesLabel];
        [self addSubview:tierDivisionLabel];
        [self addSubview:leaguePointsLabel];
//
//        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
//        [summonerLeagueIcon setTranslatesAutoresizingMaskIntoConstraints:NO];
//        [tierDivisionLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
//        [summonerName setTranslatesAutoresizingMaskIntoConstraints:NO];
//        [summonerProfileIcon setTranslatesAutoresizingMaskIntoConstraints:NO];
//
//
//        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:summonerLeagueIcon
//                                                                      attribute:NSLayoutAttributeLeading
//                                                                      relatedBy:NSLayoutRelationEqual
//                                                                         toItem:self
//                                                                      attribute:NSLayoutAttributeLeading
//                                                                     multiplier:1
//                                                                       constant:0];
//        [self addConstraint:constraint];
//        
//        constraint = [NSLayoutConstraint constraintWithItem:summonerLeagueIcon
//                                                  attribute:NSLayoutAttributeTop
//                                                  relatedBy:NSLayoutRelationEqual
//                                                     toItem:self
//                                                  attribute:NSLayoutAttributeTop
//                                                 multiplier:1
//                                                   constant:0];
//        [self addConstraint:constraint];
//        
//        constraint = [NSLayoutConstraint constraintWithItem:summonerLeagueIcon
//                                                  attribute:NSLayoutAttributeTrailing
//                                                  relatedBy:NSLayoutRelationEqual
//                                                     toItem:self
//                                                  attribute:NSLayoutAttributeTrailing
//                                                 multiplier:1
//                                                   constant:0];
//        [self addConstraint:constraint];
        
//       NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:tierDivisionLabel
//                                                                      attribute:NSLayoutAttributeLeading
//                                                                      relatedBy:NSLayoutRelationEqual
//                                                                         toItem:self
//                                                                      attribute:NSLayoutAttributeLeading
//                                                                     multiplier:1
//                                                                       constant:0];
//        [self addConstraint:constraint];
//        
//        constraint = [NSLayoutConstraint constraintWithItem:tierDivisionLabel
//                                                  attribute:NSLayoutAttributeTop
//                                                  relatedBy:NSLayoutRelationEqual
//                                                     toItem:summonerLeagueIcon
//                                                  attribute:NSLayoutAttributeTop
//                                                 multiplier:1
//                                                   constant:0];
//        [self addConstraint:constraint];
//        
//        constraint = [NSLayoutConstraint constraintWithItem:tierDivisionLabel
//                                                  attribute:NSLayoutAttributeTrailing
//                                                  relatedBy:NSLayoutRelationEqual
//                                                     toItem:self
//                                                  attribute:NSLayoutAttributeTrailing
//                                                 multiplier:1
//                                                   constant:0];
//        [self addConstraint:constraint];
//        
//        constraint = [NSLayoutConstraint constraintWithItem:tierDivisionLabel
//                                                  attribute:NSLayoutAttributeBottom
//                                                  relatedBy:NSLayoutRelationEqual
//                                                     toItem:summonerName
//                                                  attribute:NSLayoutAttributeTop
//                                                 multiplier:1
//                                                   constant:0];
//        [self addConstraint:constraint];
//        
//        constraint = [NSLayoutConstraint constraintWithItem:summonerName
//                                                  attribute:NSLayoutAttributeLeading
//                                                  relatedBy:NSLayoutRelationEqual
//                                                     toItem:summonerProfileIcon
//                                                  attribute:NSLayoutAttributeTrailing
//                                                 multiplier:1
//                                                   constant:5];
//        [self addConstraint:constraint];
//        
//        constraint = [NSLayoutConstraint constraintWithItem:summonerName
//                                                  attribute:NSLayoutAttributeTop
//                                                  relatedBy:NSLayoutRelationEqual
//                                                     toItem:tierDivisionLabel
//                                                  attribute:NSLayoutAttributeBottom
//                                                 multiplier:1
//                                                   constant:0];
//        [self addConstraint:constraint];
//        
//        constraint = [NSLayoutConstraint constraintWithItem:summonerName
//                                                  attribute:NSLayoutAttributeTrailing
//                                                  relatedBy:NSLayoutRelationEqual
//                                                     toItem:self
//                                                  attribute:NSLayoutAttributeTrailing
//                                                 multiplier:1
//                                                   constant:10];
//        [self addConstraint:constraint];
//        
//        constraint = [NSLayoutConstraint constraintWithItem:summonerName
//                                                  attribute:NSLayoutAttributeBottom
//                                                  relatedBy:NSLayoutRelationEqual
//                                                     toItem:self
//                                                  attribute:NSLayoutAttributeBottom
//                                                 multiplier:1
//                                                   constant:-10];
//        [self addConstraint:constraint];
//        
//        constraint = [NSLayoutConstraint constraintWithItem:summonerProfileIcon
//                                                  attribute:NSLayoutAttributeLeading
//                                                  relatedBy:NSLayoutRelationEqual
//                                                     toItem:self
//                                                  attribute:NSLayoutAttributeLeading
//                                                 multiplier:1
//                                                   constant:0];
//        [self addConstraint:constraint];
//        
//        constraint = [NSLayoutConstraint constraintWithItem:summonerProfileIcon
//                                                  attribute:NSLayoutAttributeTop
//                                                  relatedBy:NSLayoutRelationEqual
//                                                     toItem:tierDivisionLabel
//                                                  attribute:NSLayoutAttributeBottom
//                                                 multiplier:1
//                                                   constant:0];
//        [self addConstraint:constraint];
//        
//        constraint = [NSLayoutConstraint constraintWithItem:summonerProfileIcon
//                                                  attribute:NSLayoutAttributeCenterY
//                                                  relatedBy:NSLayoutRelationEqual
//                                                     toItem:summonerName
//                                                  attribute:NSLayoutAttributeCenterY
//                                                 multiplier:1
//                                                   constant:0];
//        [self addConstraint:constraint];
//        
//        constraint = [NSLayoutConstraint constraintWithItem:summonerProfileIcon
//                                                  attribute:NSLayoutAttributeBottom
//                                                  relatedBy:NSLayoutRelationEqual
//                                                     toItem:self
//                                                  attribute:NSLayoutAttributeBottom
//                                                 multiplier:1
//                                                   constant:-10];
//        [self addConstraint:constraint];
//
//        constraint = [NSLayoutConstraint constraintWithItem:summonerProfileIcon
//                                                  attribute:NSLayoutAttributeWidth
//                                                  relatedBy:NSLayoutRelationEqual
//                                                     toItem:summonerProfileIcon
//                                                  attribute:NSLayoutAttributeHeight
//                                                 multiplier:1
//                                                   constant:50];
//        [self addConstraint:constraint];
//        
//        constraint = [NSLayoutConstraint constraintWithItem:summonerProfileIcon
//                                                  attribute:NSLayoutAttributeHeight
//                                                  relatedBy:NSLayoutRelationEqual
//                                                     toItem:summonerName
//                                                  attribute:NSLayoutAttributeHeight
//                                                 multiplier:1
//                                                   constant:0];
//        [self addConstraint:constraint];
//        
//
        
        overlayView = [[OverlayView alloc]initWithFrame:CGRectMake(self.frame.size.width/2-100, 0, 100, 100)];
        overlayView.alpha = 0;
    //    [self addSubview:self.information];
        [self addSubview:overlayView];
    }
    return self;
}

-(void)setupView
{
    self.layer.cornerRadius = 4;
    self.layer.shadowRadius = 3;
    self.layer.shadowOpacity = 0.2;
    self.layer.shadowOffset = CGSizeMake(1, 1);
}
//
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

//%%% called when you move your finger across the screen.
// called many times a second
-(void)beingDragged:(UIPanGestureRecognizer *)gestureRecognizer
{
    //%%% this extracts the coordinate data from your swipe movement. (i.e. How much did you move?)
    xFromCenter = [gestureRecognizer translationInView:self].x; //%%% positive for right swipe, negative for left
    yFromCenter = [gestureRecognizer translationInView:self].y; //%%% positive for up, negative for down
    
    //%%% checks what state the gesture is in. (are you just starting, letting go, or in the middle of a swipe?)
    switch (gestureRecognizer.state) {
            //%%% just started swiping
        case UIGestureRecognizerStateBegan:{
            self.originalPoint = self.center;
            break;
        };
            //%%% in the middle of a swipe
        case UIGestureRecognizerStateChanged:{
            //%%% dictates rotation (see ROTATION_MAX and ROTATION_STRENGTH for details)
            CGFloat rotationStrength = MIN(xFromCenter / ROTATION_STRENGTH, ROTATION_MAX);
            
            //%%% degree change in radians
            CGFloat rotationAngel = (CGFloat) (ROTATION_ANGLE * rotationStrength);
            
            //%%% amount the height changes when you move the card up to a certain point
            CGFloat scale = MAX(1 - fabsf(rotationStrength) / SCALE_STRENGTH, SCALE_MAX);
            
            //%%% move the object's center by center + gesture coordinate
            self.center = CGPointMake(self.originalPoint.x + xFromCenter, self.originalPoint.y + yFromCenter);
            
            //%%% rotate by certain amount
            CGAffineTransform transform = CGAffineTransformMakeRotation(rotationAngel);
            
            //%%% scale by certain amount
            CGAffineTransform scaleTransform = CGAffineTransformScale(transform, scale, scale);
            
            //%%% apply transformations
            self.transform = scaleTransform;
            [self updateOverlay:xFromCenter];
            
            break;
        };
            //%%% let go of the card
        case UIGestureRecognizerStateEnded: {
            [self afterSwipeAction];
            break;
        };
        case UIGestureRecognizerStatePossible:break;
        case UIGestureRecognizerStateCancelled:break;
        case UIGestureRecognizerStateFailed:break;
    }
}

//%%% checks to see if you are moving right or left and applies the correct overlay image
-(void)updateOverlay:(CGFloat)distance
{
    if (distance > 0) {
        overlayView.mode = GGOverlayViewModeRight;
    } else {
        overlayView.mode = GGOverlayViewModeLeft;
    }
    
    overlayView.alpha = MIN(fabsf(distance)/100, 0.4);
}

//%%% called when the card is let go
- (void)afterSwipeAction
{
    if (xFromCenter > ACTION_MARGIN) {
        [self rightAction];
    } else if (xFromCenter < -ACTION_MARGIN) {
        [self leftAction];
    } else { //%%% resets the card
        [UIView animateWithDuration:0.3
                         animations:^{
                             self.center = self.originalPoint;
                             self.transform = CGAffineTransformMakeRotation(0);
                             overlayView.alpha = 0;
                         }];
    }
}

//%%% called when a swipe exceeds the ACTION_MARGIN to the right
-(void)rightAction
{
    CGPoint finishPoint = CGPointMake(500, 2*yFromCenter +self.originalPoint.y);
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.center = finishPoint;
                     }completion:^(BOOL complete){
                         [self removeFromSuperview];
                     }];
    
    [delegate cardSwipedRight:self];
    
    NSLog(@"YES");
}

//%%% called when a swip exceeds the ACTION_MARGIN to the left
-(void)leftAction
{
    CGPoint finishPoint = CGPointMake(-500, 2*yFromCenter +self.originalPoint.y);
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.center = finishPoint;
                     }completion:^(BOOL complete){
                         [self removeFromSuperview];
                     }];
    
    [delegate cardSwipedLeft:self];
    
    NSLog(@"NO");
}

-(void)rightClickAction
{
    CGPoint finishPoint = CGPointMake(600, self.center.y);
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.center = finishPoint;
                         self.transform = CGAffineTransformMakeRotation(1);
                     }completion:^(BOOL complete){
                         [self removeFromSuperview];
                     }];
    
    [delegate cardSwipedRight:self];
    
    NSLog(@"YES");
}

-(void)leftClickAction
{
    CGPoint finishPoint = CGPointMake(-600, self.center.y);
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.center = finishPoint;
                         self.transform = CGAffineTransformMakeRotation(-1);
                     }completion:^(BOOL complete){
                         [self removeFromSuperview];
                     }];
    
    [delegate cardSwipedLeft:self];
    
    NSLog(@"NO");
}



@end
