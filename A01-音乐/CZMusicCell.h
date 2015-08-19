//
//  CZMusicCell.h
//  A01-音乐
//
//  Created by leo on 15/8/18.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CZMusic;
@interface CZMusicCell : UITableViewCell

+ (instancetype)musicCellWithTableView:(UITableView *)tableView;

@property(nonatomic,strong)CZMusic *music;

@end
