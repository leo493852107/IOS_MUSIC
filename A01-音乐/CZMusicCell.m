//
//  CZMusicCell.m
//  A01-音乐
//
//  Created by leo on 15/8/18.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import "CZMusicCell.h"
#import "CZMusic.h"

@implementation CZMusicCell

+ (instancetype)musicCellWithTableView:(UITableView *)tableView{
    
    static NSString *ID = @"MusicCell";
    return [tableView dequeueReusableCellWithIdentifier:ID];
}

//显示cell
-(void)setMusic:(CZMusic *)music{
    _music = music;
    
    self.textLabel.text = music.name;
    self.detailTextLabel.text = music.singer;
    
}

@end
