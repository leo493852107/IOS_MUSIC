//
//  CZPlayerToolBar.h
//  A01-音乐
//
//  Created by leo on 15/8/18.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    BtnTypePlay,//播放
    BtnTypePause,//暂停
    BtnTypePrevious,
    BtnTypeNext
}BtnType;

@class CZMusic,CZPlayerToolBar;

@protocol CZPlayerToolBarDelegate <NSObject>

- (void)playToolBar:(CZPlayerToolBar *)toolbar btnClickWithType:(BtnType) btnType;

@end

@interface CZPlayerToolBar : UIView

+ (instancetype)playerToolBar;
//当前播放的音乐
@property(nonatomic,strong)CZMusic *playingMusic;


/**
 *  播放状态 默认暂停
 */
@property (nonatomic,assign, getter=isPlaying)BOOL playing;

@property(nonatomic,weak)id<CZPlayerToolBarDelegate> delegate;

@end
