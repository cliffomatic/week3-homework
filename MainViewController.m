//
//  MainViewController.m
//  week3-homework
//
//  Created by Clifford Curry on 7/2/14.
//  Copyright (c) 2014 Google.com. All rights reserved.
//

#import "MainViewController.h"
#import "TubeViewController.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *headlinesView;
- (void)onCustomPan:(UIPanGestureRecognizer *)panGestureRecognizer;
@property (weak, nonatomic) IBOutlet UIScrollView *newsScroll;
@property (weak, nonatomic) IBOutlet UIView *headlinesContainerView;
- (IBAction)onMenuPress:(id)sender;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onCustomPan:)];

    // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
    [self.headlinesContainerView addGestureRecognizer:panGestureRecognizer];
    
    self.newsScroll.contentSize = CGSizeMake(1444,227);
    
    
    
}





- (void)onCustomPan:(UIPanGestureRecognizer *)panGestureRecognizer {
    CGPoint velocity = [panGestureRecognizer velocityInView:self.view];
    CGPoint translation = [panGestureRecognizer translationInView:self.view];
    
    [panGestureRecognizer setTranslation:CGPointZero inView:panGestureRecognizer.view];
    
    //move the view the same amount as the pandgesture recognizer
    if (panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        if (velocity.y<=0) {
            self.headlinesContainerView.center = CGPointMake(self.headlinesContainerView.center.x, self.headlinesContainerView.center.y + (translation.y * 0.1));
        } else {
                    self.headlinesContainerView.center = CGPointMake(self.headlinesContainerView.center.x, self.headlinesContainerView.center.y + (translation.y * 0.5));
        }
        
    }
    
    //once the pan has stopped determine the direction of the pan and complete the view movement

    if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        if (velocity.y >= 0) {
            [UIView animateWithDuration:.5 animations:^{
            self.headlinesContainerView.frame = CGRectMake(0, 520, 320, 568);
            }];
            
        }else {
            [UIView animateWithDuration:.5 animations:^{
            self.headlinesContainerView.frame = CGRectMake(0, 0, 320, 568);
            }];
        }
    }
}

    
//    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
//        NSLog(@"Gesture began at: %@", NSStringFromCGPoint(point));
//    } else if (panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
//        NSLog(@"Gesture changed: %@", NSStringFromCGPoint(point));
//    } else if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
//        NSLog(@"Gesture ended: %@", NSStringFromCGPoint(point));
//    }




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onMenuPress:(id)sender {
    TubeViewController *tubeViewController = [[TubeViewController alloc] init];
    [self presentViewController:tubeViewController animated:YES completion:nil];
}
@end
