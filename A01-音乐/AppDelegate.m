//
//  AppDelegate.m
//  A01-音乐
//
//  Created by leo on 15/8/18.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //设置音乐后台播放的会话类型
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [session setActive:YES error:nil];
    
    //开启接收远程事件
    [application beginReceivingRemoteControlEvents];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    //开启后台
    [application beginBackgroundTaskWithExpirationHandler:nil];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark 接收远程事件
- (void)remoteControlReceivedWithEvent:(UIEvent *)event{
    //判断是否为远程事件
    if (event.type == UIEventTypeRemoteControl) {
        NSLog(@"xx");
        
//        UIEventSubtypeRemoteControlPlay                 = 100,
//        UIEventSubtypeRemoteControlPause                = 101,
//        UIEventSubtypeRemoteControlStop                 = 102,
//        UIEventSubtypeRemoteControlNextTrack            = 104,
//        UIEventSubtypeRemoteControlPreviousTrack        = 105,

        
        self.mRemoteEventBlock(event);
    }
}

@end
