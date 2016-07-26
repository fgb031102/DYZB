//
//  LoadingAdViewController.m
//  DYZB
//
//  Created by guibinfeng on 16/7/24.
//  Copyright © 2016年 guibinfeng. All rights reserved.
//

#import "LoadingAdViewController.h"
#import "AdContentViewController.h"
#import "AppDelegate.h"


@interface LoadingAdViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *adImageView;

@property (weak, nonatomic) IBOutlet UIView *markView;

- (IBAction)enterBtnClick;

@end

@implementation LoadingAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initAdImageViewStyle];
}

- (void)initAdImageViewStyle {
    UIImage *adImage = [UIImage imageWithContentsOfFile:[self getADImageFilePath]];
    self.adImageView.image = adImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)enterBtnClick {
    NSLog(@"------------");
}

- (NSString *)getADImageFilePath {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *filePath = [user valueForKey:@"filePath"];
    return filePath;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch * touch = [touches anyObject];
    CGPoint current=[touch locationInView:self.adImageView];
    CGPoint markViewPoint = [touch locationInView:self.markView];
    if (CGRectContainsPoint(self.adImageView.frame, current) && !CGRectContainsPoint(self.adImageView.frame, markViewPoint)) {
        AdContentViewController *adVC = [[AdContentViewController alloc] init];
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:adVC];
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        delegate.window.rootViewController = navi;
    }
}
@end
