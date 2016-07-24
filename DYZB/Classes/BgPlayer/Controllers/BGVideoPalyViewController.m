//
//  BGVideoPalyViewController.m
//  DYZB
//
//  Created by guibinfeng on 16/7/23.
//  Copyright © 2016年 guibinfeng. All rights reserved.
//

#import "BGVideoPalyViewController.h"

@interface BGVideoPalyViewController ()

@property (weak, nonatomic) UIButton *startBtn;

@property (weak, nonatomic) UIView *backView;

@property (strong, nonatomic) AVPlayer *player;

@property (weak, nonatomic) UIImageView *titleView;

@end

@implementation BGVideoPalyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initBackViewStyle];
    [self initStartBtnStyle];
    [self initTitleViewSytle];
    [self initAVplayerView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.player play];
}

- (void)initBackViewStyle {
    UIView *backView = [[UIView alloc] initWithFrame:SCREEN_RECT];
    backView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:backView];
    self.backView = backView;
}

- (void)initStartBtnStyle {
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backView addSubview:startBtn];
    self.startBtn = startBtn;
    [startBtn setTitle:@"立即体验" forState:UIControlStateNormal];
    startBtn.bounds = CGRectMake(0, 0, 0, 60);
    self.startBtn.layer.borderWidth = 0.5f;
    self.startBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.startBtn.layer.cornerRadius = 18.0f;
    UIView *superView = self.backView;
    [startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(superView.mas_bottom).with.offset(-35);
        make.left.equalTo(superView.mas_left).with.offset(50);
        make.right.equalTo(superView.mas_right).with.offset(-50);
        make.centerX.equalTo(superView);
    }];
    [startBtn addTarget:self action:@selector(startBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)startBtnClick {
    NSLog(@"------");
}

- (void)initTitleViewSytle {
    UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dyla_视频引导页_180x140_.png"]];
    [self.backView addSubview:titleView];
    titleView.bounds = CGRectMake(0, 0, 180, 140);
    UIView *superView = self.backView;
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView.mas_top).with.offset(60);
        make.centerX.equalTo(superView);
    }];
}

- (AVPlayer *)player
{
    if (!_player) {
        NSString *filePath = [[NSBundle mainBundle]pathForResource:@"dyla_movie" ofType:@"mp4"];
        NSURL *url = [NSURL fileURLWithPath:filePath];
        AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:url];
        _player = [AVPlayer playerWithPlayerItem:playerItem];
        _player.actionAtItemEnd = AVPlayerActionAtItemEndNone;
        [[NSNotificationCenter defaultCenter]addObserver:self
                                                selector:@selector(playerItemDidPlayToEndTimeNotification:)
                                                    name:AVPlayerItemDidPlayToEndTimeNotification
                                                  object:nil];
    }
    return _player;
}

- (void)playerItemDidPlayToEndTimeNotification:(NSNotification *)sender
{
    [_player seekToTime:kCMTimeZero];
}

- (void)initAVplayerView
{
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    playerLayer.frame = self.backView.bounds;
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.backView.layer insertSublayer:playerLayer atIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
