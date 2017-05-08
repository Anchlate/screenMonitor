//
//  AppDelegate.m
//  锁屏开屏监听
//
//  Created by Qianrun on 16/7/7.
//  Copyright © 2016年 qianrun. All rights reserved.
//

#import "AppDelegate.h"

#import <notify.h>

#define NotificationLock CFSTR("com.apple.springboard.lockcomplete")

#define NotificationChange CFSTR("com.apple.springboard.lockstate")

#define NotificationPwdUI CFSTR("com.apple.springboard.hasBlankedScreen")

//#define NotificationUnLock CFSTR("com.apple.iokit.hid.displayStatus")

static BOOL _isLock;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
  /*
    _isLock = NO;
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, screenLockStateChanged, NotificationChange, NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, screenLockStateChanged, NotificationLock, NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
*/
    
    //setScreenStateCb();
    
    
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];    // Override point for customization after application launch.
//    NSError *setCategoryErr = nil;
//    NSError *activationErr  = nil;
//    [[AVAudioSession sharedInstance]
//     setCategory: AVAudioSessionCategoryPlayback
//     error: &setCategoryErr];
//    [[AVAudioSession sharedInstance]
//     setActive: YES
//     error: &activationErr];
//    self.window.backgroundColor = [UIColor whiteColor];
//    [self.window makeKeyAndVisible];
    
    
    
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(time) userInfo:nil repeats:YES];
    
    return YES;
}

- (void)time {
    NSLog(@"......");
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    
    
    
    /*
    while (YES) {
        
        setScreenStateCb();
        
        sleep(1);
        
    }
     */
    
    
    /*
    UIApplication*   app = [UIApplication sharedApplication];
    __block    UIBackgroundTaskIdentifier bgTask;
    bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (bgTask != UIBackgroundTaskInvalid) {
                bgTask = UIBackgroundTaskInvalid;
            }
        });
    }];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (bgTask != UIBackgroundTaskInvalid) {
                bgTask = UIBackgroundTaskInvalid;
            }
            
        });
    });
    */
    
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

#pragma mark -Private
static void screenLockStateChanged(CFNotificationCenterRef center,void* observer,CFStringRef name,const void* object,CFDictionaryRef userInfo)
{
    
    NSString* lockstate = (__bridge NSString*)name;
    
    if ([lockstate isEqualToString:(__bridge  NSString*)NotificationLock]) {
        
        _isLock = YES;
        
        NSLog(@"locked.");
        
    } else {
        
        if (_isLock) { // 如果在锁屏状态下屏幕状态改变了，说明是解屏
            NSLog(@"......:解屏");
        }
        
    }
    
}

static void setScreenStateCb()
{
    uint64_t locked;
    
    __block int token = 0;
    
    notify_register_dispatch("com.apple.springboard.lockstate",&token,dispatch_get_main_queue(),^(int t){
        NSLog(@"..:%d", (int)token);
    });
    
    notify_get_state(token, &locked);
    
    NSLog(@"%d",(int)locked);
    
}


@end