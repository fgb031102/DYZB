//
//  ShareView.m
//  DYZB
//
//  Created by guibinfeng on 16/7/25.
//  Copyright © 2016年 guibinfeng. All rights reserved.
//

#import "ShareView.h"

@interface ShareView ()

@property (weak, nonatomic) IBOutlet UIButton *friendBtn;
@property (weak, nonatomic) IBOutlet UIButton *wechatBtn;
@property (weak, nonatomic) IBOutlet UIButton *qqBtn;
@property (weak, nonatomic) IBOutlet UIButton *zoneBtn;
@property (weak, nonatomic) IBOutlet UIButton *sinaBtn;
@property (weak, nonatomic) UIButton *shareBtnSelected;

@end

@implementation ShareView

- (instancetype)shareView {
    NSBundle *bundle=[NSBundle mainBundle];
    NSArray *objs=[bundle loadNibNamed:@"ShareView" owner:nil options:nil];
    return [objs lastObject];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.shareBtnSelected == nil) {
        [self ShareBtnClick:self.friendBtn];
    }else {
        [self ShareBtnClick:self.shareBtnSelected];
    }
}

- (IBAction)ShareBtnClick:(UIButton *)sender {
     if (sender != self.shareBtnSelected) {
         self.shareBtnSelected.selected = NO;
         self.shareBtnSelected = sender;
     }
    self.shareBtnSelected.selected = YES;
}

@end
