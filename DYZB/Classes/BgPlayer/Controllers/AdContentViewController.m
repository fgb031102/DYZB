//
//  AdContentViewController.m
//  DYZB
//
//  Created by guibinfeng on 16/7/25.
//  Copyright © 2016年 guibinfeng. All rights reserved.
//

#import "AdContentViewController.h"
#import "NJKWebViewProgress.h"
#import "UIBarButtonItem+BarButtonItem.h"
#import "ShareView.h"

@interface AdContentViewController () <UIWebViewDelegate, NJKWebViewProgressDelegate, UIScrollViewDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic,strong) UIProgressView * progressView;
@property (nonatomic,strong) NJKWebViewProgress * progress;
@property (nonatomic,assign) BOOL shareViewIsShow;
@property (nonatomic,weak) ShareView *shareView;
@property (weak, nonatomic) IBOutlet UIImageView *loadingImageView;

@end

@implementation AdContentViewController

- (void)viewDidLoad {
    self.view.frame = SCREEN_RECT;
    [super viewDidLoad];
    self.title = @"Google";
    [self initDataAndView];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *urlStr = [user valueForKey:@"url"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
    self.webView.scrollView.delegate = self;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapMethod)];
    [tap setNumberOfTapsRequired:1];
    [tap setDelegate:self];
    [self.webView addGestureRecognizer:tap];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"btn_nav_back_16x16_" highImage:@"btn_nav_back_click_18x18_" target:self action:@selector(leftItemClick)];
    UIBarButtonItem *refreshItem = [UIBarButtonItem itemWithImage:@"btn_task_refresh_22x22_" highImage:@"btn_task_highlight_22x22_" target:self action:@selector(refreshItemClick)];
    refreshItem.width = 50;
    UIBarButtonItem *shareItem = [UIBarButtonItem itemWithImage:@"btn_ad_share_22x22_" highImage:@"btn_ad_share_click_22x22_" target:self action:@selector(shareItemClick)];
    self.navigationItem.rightBarButtonItems = @[shareItem, refreshItem];
    [self initShareViewStyle];
}

- (void)initShareViewStyle {
    ShareView *shareView = [[ShareView alloc] shareView];
    [self.view addSubview:shareView];
    shareView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 250);
    self.shareView = shareView;
    self.shareViewIsShow = NO;
}

- (void)leftItemClick {
    NSLog(@"-----");
}

- (void)refreshItemClick {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *urlStr = [user valueForKey:@"url"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
}

- (void)shareItemClick {
    if (self.shareViewIsShow) {
        [UIView animateWithDuration:1.0f animations:^{
            self.shareView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 250);
        } completion:^(BOOL finishedpo) {
            self.shareViewIsShow = NO;
        }];
    }else {
        [UIView animateWithDuration:1.0f animations:^{
            self.shareView.frame = CGRectMake(0, SCREEN_HEIGHT - 250, SCREEN_WIDTH, 250);
        } completion:^(BOOL finished) {
            self.shareViewIsShow = YES;
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.loadingImageView.frame = SCREEN_RECT;
}
*/
#pragma mark - Pravite
- (void)initDataAndView{
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 62, SCREEN_WIDTH, 1)];
    self.progressView.backgroundColor = [UIColor clearColor];
    self.progressView.trackTintColor = [UIColor clearColor];
    self.progressView.tintColor = [UIColor orangeColor];
    [self.navigationController.view addSubview:self.progressView];
    
    self.progress = [[NJKWebViewProgress alloc] init];
    self.progress.webViewProxyDelegate = self;
    self.progress.progressDelegate = self;
    WEAKSELF;
    self.progress.progressBlock = ^(float progress) {
        STRONGSELF;
        [strongSelf.progressView setProgress:progress animated:YES];
        if(progress >= 1.0) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                strongSelf.progressView.hidden = YES;
            });
        } else {
            strongSelf.progressView.hidden = NO;
        }
    };
    self.webView.delegate = self.progress;
}

- (void)didTapMethod {
    if (self.shareViewIsShow) {
        [UIView animateWithDuration:1.0f animations:^{
            self.shareView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 250);
        } completion:^(BOOL finishedpo) {
            self.shareViewIsShow = NO;
        }];
    }
}

- (void)loadingAnimation {
    NSMutableArray *animateArray = [[NSMutableArray alloc]initWithCapacity:2];
    [animateArray addObject:[UIImage imageNamed:@"dyla_img_loading_1_151x232_"]];
    [animateArray addObject:[UIImage imageNamed:@"dyla_img_loading_2_151x232_"]];
    self.loadingImageView.animationImages = animateArray;
    self.loadingImageView.animationDuration = 0.5f;
    self.loadingImageView.animationRepeatCount = 0;
    self.loadingImageView.contentMode = UIViewContentModeCenter;
    [self.loadingImageView startAnimating];
}

#pragma mark Delegete
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    self.loadingImageView.hidden = NO;
    [self loadingAnimation];
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self loadingAnimation];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self loadingAnimation];
    self.navigationItem.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [self.progressView setProgress:1.0 animated:YES];
    WEAKSELF;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        STRONGSELF;
        strongSelf.progressView.hidden = YES;
    });
    self.loadingImageView.hidden = YES;
}

- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress{
    [self.progressView setProgress:progress animated:NO];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.shareViewIsShow) {
        [UIView animateWithDuration:1.0f animations:^{
            self.shareView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 250);
        } completion:^(BOOL finishedpo) {
            self.shareViewIsShow = NO;
        }];
    }
}

@end
