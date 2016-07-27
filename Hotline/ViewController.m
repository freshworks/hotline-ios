//
//  ViewController.m
//  Hotline
//
//  Copyright (c) 2015 Freshdesk. All rights reserved.
//

#import "ViewController.h"
#import "Hotline.h"
#import "FDSettingsController.h"
#import "AppDelegate.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *chatButton;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {

    self.imageView = [[UIImageView alloc]initWithFrame:self.view.frame];
    [self.view insertSubview:self.imageView atIndex:0];
    
    self.view.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0.95 alpha:1];
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDelegate.pickedImage) {
        self.imageView.image = appDelegate.pickedImage;
    }else{
        self.imageView.image = [UIImage imageNamed:@"background"];
    }
    
}
- (IBAction)chatButtonPressed:(id)sender {
    [[Hotline sharedInstance]showConversations:self];
}

- (IBAction)FAQButton:(id)sender {
    [[Hotline sharedInstance]showFAQs:self];
}
@end