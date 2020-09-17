//
//  AppDelegate.m
//  Eventi
//
//  Created by Davide Alzeti on 11/09/20.
//  Copyright © 2020 Davide Alzeti. All rights reserved.
//

#import "AppDelegate.h"
#import "MDFileManager.h"
#define DEBUGLOG(a) NSLog(@"%s: %@", __FUNCTION__, a)

@interface AppDelegate ()

@property (strong, nonatomic) NSMutableArray *programmedArray;
@property (strong, nonatomic) NSMutableArray *pastArray;

@property (strong, nonatomic) MDFileManager *fm;

- (void)updateProgrammedArray:(NSNotification *)notification;
- (void)updatePastArray:(NSNotification *)notification;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateProgrammedArray:) name:@"updateProgrammed" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePastArray:) name:@"updatePast" object:nil];
    
    self.fm = [[MDFileManager alloc] init];
    
    return YES;
}

- (void)updateProgrammedArray:(NSNotification *)notification{
    DEBUGLOG(@"Message: updateProgrammed");
    if ([notification.object isKindOfClass:[NSMutableArray class]]) {
        self.programmedArray = [[NSMutableArray alloc] initWithArray:notification.object];
    }
    
}

- (void)updatePastArray:(NSNotification *)notification{
    DEBUGLOG(@"Message: updatePast");
    if ([notification.object isKindOfClass:[NSMutableArray class]]) {
        self.pastArray = [[NSMutableArray alloc] initWithArray:notification.object];
    }
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    ;;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [self.fm saveProgrammedEventsToFile:self.programmedArray];
    [self.fm savePastEventsToFile:self.pastArray];
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

@end
