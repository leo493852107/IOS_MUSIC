//
//  CZMusicPlayerViewController.m
//  A01-音乐
//
//  Created by leo on 15/8/18.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import "CZMusicPlayerViewController.h"
#import "CZPlayerToolBar.h"
#import "MJExtension.h"
#import "CZMusic.h"
#import "CZMusicCell.h"
#import "CZMusicTool.h"
#import "AppDelegate.h"

@interface CZMusicPlayerViewController () <UITableViewDataSource,UITableViewDelegate,CZPlayerToolBarDelegate,AVAudioPlayerDelegate>
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

//当前播放音乐的索引
@property(assign, nonatomic) NSInteger musicIndex;

//音乐数据
@property (strong, nonatomic) NSArray *musics;

//播放工具条
@property (weak ,nonatomic)CZPlayerToolBar *playerToolBar;

@end

@implementation CZMusicPlayerViewController

#pragma mark 懒加载音乐
- (NSArray *)musics{
    if (! _musics) {
        _musics = [CZMusic objectArrayWithFilename:@"songs.plist"];
    }
    return _musics;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1 添加"播放工具条"
    CZPlayerToolBar *toolBar = [CZPlayerToolBar playerToolBar];
    //设置toolBar尺寸
    toolBar.bounds = self.bottomView.bounds;
    //设置代理
    toolBar.delegate = self;
    
    [self.bottomView addSubview:toolBar];
    self.playerToolBar = toolBar;
    
    //2 设置表格的背景颜色为透明
    self.tableView.backgroundColor = [UIColor clearColor];
    
//    //3 初始化 “音乐工具类” 里播放器
//    [[CZMusicTool sharedCZMusicTool] prepareToPlayWith:self.musics[self.musicIndex]];
//    [CZMusicTool sharedCZMusicTool].player.delegate = self;
//    
//    //4 初始化播放的音乐
//    toolBar.playingMusic = self.musics[self.musicIndex];
    
    [self playMusic];
    
    //设置appdelegate的block
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.mRemoteEventBlock = ^(UIEvent *event){
      
        
        //        UIEventSubtypeRemoteControlPlay                 = 100,
        //        UIEventSubtypeRemoteControlPause                = 101,
        //        UIEventSubtypeRemoteControlStop                 = 102,
        //        UIEventSubtypeRemoteControlNextTrack            = 104,
        //        UIEventSubtypeRemoteControlPreviousTrack        = 105,
        switch (event.subtype) {
            case UIEventSubtypeRemoteControlPlay:
                NSLog(@"Play");
                [[CZMusicTool sharedCZMusicTool] play];
                break;
            case UIEventSubtypeRemoteControlPause:
                NSLog(@"pause");
                [[CZMusicTool sharedCZMusicTool] pause];
                break;
            case UIEventSubtypeRemoteControlPreviousTrack:
                NSLog(@"previous");
                [self previous];
                break;
            case UIEventSubtypeRemoteControlNextTrack:
                NSLog(@"next");
                [self next];
                break;
                
            default:
                break;
        }
    };
    
}

#pragma mark 表格数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.musics.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CZMusicCell *cell = [CZMusicCell musicCellWithTableView:tableView];
    
    //设置数据
    CZMusic *music = self.musics[indexPath.row];
    cell.music = music;
    return cell;
}

#pragma mark 播放工具条的代理
- (void)playToolBar:(CZPlayerToolBar *)toolbar btnClickWithType:(BtnType)btnType{
    //把播放的操作放在一个工具类里
    switch (btnType) {
        case BtnTypePlay:
            NSLog(@"play");
            [[CZMusicTool sharedCZMusicTool] play];
            break;
        case BtnTypePause:
            NSLog(@"pause");
            [[CZMusicTool sharedCZMusicTool] pause];
            break;
        case BtnTypePrevious:
            NSLog(@"previous");
            [self previous];
            break;
        case BtnTypeNext:
            NSLog(@"next");
            [self next];
            break;
            
        default:
            break;
    }
}

#pragma mark 播放上一首
- (void)previous{
    if (self.musicIndex == 0) {//第一首
        self.musicIndex = self.musics.count - 1;
    }else{
        self.musicIndex--;
    }
    [self playMusic];
}

#pragma mark 播放下一首
- (void)next{
    //1 更改播放的索引
    if (self.musicIndex == self.musics.count - 1) {
        self.musicIndex = 0;
    }else{
        self.musicIndex++;
    }
    [self playMusic];
}

- (void)playMusic{
    
    //2 重新初始化一个 "播放器"
    [[CZMusicTool sharedCZMusicTool] prepareToPlayWith:self.musics[self.musicIndex]];
    
    //设置player的代理
    [CZMusicTool sharedCZMusicTool].player.delegate = self;
    
    //3 更改 "播放工具条" 的数据
    self.playerToolBar.playingMusic = self.musics[self.musicIndex];
    
    
    //4 播放
    if (self.playerToolBar.isPlaying) {
        [[CZMusicTool sharedCZMusicTool]play];
    }
}

#pragma mark 表格的选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //更改索引
    self.musicIndex = indexPath.row;
    //播放音乐
    [self playMusic];
}

#pragma mark 播放器的代理
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    //自动播放下一首
    [self next];
}

@end
