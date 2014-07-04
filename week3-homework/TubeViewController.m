//
//  TubeViewController.m
//  week3-homework
//
//  Created by Clifford Curry on 7/3/14.
//  Copyright (c) 2014 Google.com. All rights reserved.
//

#import "TubeViewController.h"

@interface TubeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *vidstillView;
@property (weak, nonatomic) IBOutlet UIImageView *infopanelView;
@property (weak, nonatomic) IBOutlet UIView *shadowView;

- (void)onCustomPan:(UIPanGestureRecognizer *)panGestureRecognizer;
- (void)onLongPress:(UILongPressGestureRecognizer *)longPressGestureRecognizer;

@end

@implementation TubeViewController

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
    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onLongPress:)];
    
    // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
    [self.vidstillView addGestureRecognizer:panGestureRecognizer];
    [self.vidstillView addGestureRecognizer:longPressGestureRecognizer];
    self.shadowView.alpha = .5;
  
    
}


-(void)onLongPress:(UILongPressGestureRecognizer *)longPressGestureRecognizer{
    
}


- (void)onCustomPan:(UIPanGestureRecognizer *)panGestureRecognizer {
    CGPoint velocity = [panGestureRecognizer velocityInView:self.view];
    CGPoint translation = [panGestureRecognizer translationInView:self.view];
    CGPoint location = [panGestureRecognizer locationInView:self.view];
    
    [panGestureRecognizer setTranslation:CGPointZero inView:panGestureRecognizer.view];
    
    
    
    
    //panstarted shrink the video just a bit
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        
        [UIView animateWithDuration:.4 animations:^{
            self.vidstillView.transform = CGAffineTransformMakeScale(.6,.6);
            
        }];
        
        [UIView animateWithDuration:1 animations:^{
            self.shadowView.alpha = 0;
        }];
        
        [self moveOutInfo];
    }

    
    
    //move the view the same amount as the pan gesture recognizer
    if (panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        
        self.vidstillView.center = location;
        
        
        
    }
    
    //once the pan has stopped determine the direction of the pan and complete the view movement
    
    if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        
        
        if ((location.y >=420)||(velocity.y >= 0)) {
            [self shrinkyDinkVideo];
            [self moveOutInfo];
        } else if ((location.y >=420) ||(velocity.y <= 0)){
            [self growVideo];
            [self moveInInfo];
        }
        
        
    
    }
}

-(void)shrinkyDinkVideo{
    [UIView animateWithDuration:.4 animations:^{
        self.vidstillView.transform = CGAffineTransformMakeScale(.5,.5);
        self.vidstillView.center = CGPointMake(235, 520);
        self.shadowView.alpha = 0;
    }];

}

-(void)growVideo{
    [UIView animateWithDuration:.4 animations:^{
        self.vidstillView.transform = CGAffineTransformMakeScale(1,1);
        self.vidstillView.center = CGPointMake(160, 90);
        self.shadowView.alpha = .5;
    }];
}

-(void)moveOutInfo{
    [UIView animateWithDuration:.5 animations:^{
        self.infopanelView.frame = CGRectMake(0,570,self.infopanelView.frame.size.width,self.infopanelView.frame.size.height);
    }];
}

-(void)moveInInfo{
    [UIView animateWithDuration:.5 animations:^{
        self.infopanelView.frame = CGRectMake(0,180,self.infopanelView.frame.size.width,self.infopanelView.frame.size.height);
    }];
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
