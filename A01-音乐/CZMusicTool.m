//
//  CZMusicTool.m
//  A01-音乐
//
//  Created by leo on 15/8/18.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import "CZMusicTool.h"
#import <MediaPlayer/MediaPlayer.h>
#import "CZMusic.h"

@interface CZMusicTool()


@end

@implementation CZMusicTool
singleton_implementation(CZMusicTool)

- (void)prepareToPlayWith:(CZMusic *)music{
    //创建一个播放器
    
    NSURL *musicURL = [[NSBundle mainBundle] URLForResource:music.filename withExtension:nil];
    
    self.player = [[AVAudioPlayer alloc]initWithContentsOfURL:musicURL error:nil];
    
    //准备
    [self.player prepareToPlay];
    
    //锁屏信息最好在程序退出到后台的时候再设置
    //这里演示就在初始化音乐播放器后设置
    //设置锁屏音乐信息
    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    
    //设置专辑的名称
    info[MPMediaItemPropertyAlbumTitle] = @"中文十大金曲";
    
    //设置歌曲名
    info[MPMediaItemPropertyTitle] = music.name;
    
    //设置歌手
    info[MPMediaItemPropertyArtist] = music.singer;
    
    //设置专辑图片
    UIImage *img = [UIImage imageNamed:music.icon];
    MPMediaItemArtwork *artwork = [[MPMediaItemArtwork alloc]initWithImage:img];
    info[MPMediaItemPropertyArtist] = artwork;
    
    //设置时间
    info[MPMediaItemPropertyPlaybackDuration] = @(self.player.duration);
    
    [MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo = info;
    
    
}

-(void)play{
    [self.player play];
}

-(void)pause{
    [self.player pause];
}

@end
