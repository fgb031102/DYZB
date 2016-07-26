//
//  UIBarButtonItem+BarButtonItem.h
//  DYZB
//
//  Created by guibinfeng on 16/7/25.
//  Copyright © 2016年 guibinfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (BarButtonItem)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;

@end
