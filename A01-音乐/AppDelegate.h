//
//  AppDelegate.h
//  A01-音乐
//
//  Created by leo on 15/8/18.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^PlayerRemoteEventBlock)(UIEvent *event);
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (copy, nonatomic)PlayerRemoteEventBlock mRemoteEventBlock;
@end

