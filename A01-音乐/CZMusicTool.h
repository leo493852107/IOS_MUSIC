//
//  CZMusicTool.h
//  A01-音乐
//
//  Created by leo on 15/8/18.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import <AVFoundation/AVFoundation.h>

@class CZMusic;
@interface CZMusicTool : NSObject
singleton_interface(CZMusicTool)

//播放器
@property (nonatomic,strong)AVAudioPlayer *player;

/**
 *  音乐播放前的准备工作
 */
- (void)prepareToPlayWith:(CZMusic *)music;

/**
 *  播放
 */
- (void)play;

/**
 *  暂停
 */
- (void)pause;
@end
