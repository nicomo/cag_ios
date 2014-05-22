//
//  AppDelegate.m
//  Cagliostro
//
//  Created by Jean-André Santoni on 24/01/14.
//  Copyright (c) 2014 Jean-André Santoni. All rights reserved.
//

#import "AppDelegate.h"
#import "EpisodeViewController.h"
#import "CustomPageViewController.h"
#import "HomeViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSDate *fld = [prefs objectForKey:@"firstLaunchDate"];
    if (fld) {
        firstLaunchDate = fld;
        NSLog(@"Date de premier lancement trouvée.");
    } else {
        firstLaunchDate = [NSDate date];
        [prefs setObject:firstLaunchDate forKey:@"firstLaunchDate"];
        [prefs setBool:YES forKey:@"delayedEps"];
        NSLog(@"App lancée pour la première fois. Enregistrement de la date de premier lancement.");
    }
    
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    localNotif.fireDate = [fld dateByAddingTimeInterval:30*60];
    localNotif.alertBody = @"Bonjour!";
    localNotif.alertAction = @"View Details";
    localNotif.soundName = UILocalNotificationDefaultSoundName;
    localNotif.applicationIconBadgeNumber = 1;
    [application scheduleLocalNotification:localNotif];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"episodes" ofType:@"plist"];
    epdata = [NSMutableArray arrayWithContentsOfFile:path];
    
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"characters" ofType:@"plist"];
    chardata = [NSMutableArray arrayWithContentsOfFile:path2];
    
    NSString *path3 = [[NSBundle mainBundle] pathForResource:@"places" ofType:@"plist"];
    pldata = [NSMutableArray arrayWithContentsOfFile:path3];
    
    NSString *path4 = [[NSBundle mainBundle] pathForResource:@"messages" ofType:@"plist"];
    messdata = [NSMutableArray arrayWithContentsOfFile:path4];
    
    NSString *path5 = [[NSBundle mainBundle] pathForResource:@"confessions" ofType:@"plist"];
    confdata = [NSMutableArray arrayWithContentsOfFile:path5];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    HomeViewController *homeViewController = [[HomeViewController alloc] init];

    self.window.backgroundColor = [UIColor blackColor];
    [self.window makeKeyAndVisible];

    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:homeViewController];

    self.window.rootViewController = navController;
    
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor colorWithRed:.75 green:.70 blue:.69 alpha:1.0];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:0.24 green:0.20 blue:0.12 alpha:1.0];
    pageControl.backgroundColor = [UIColor clearColor];
    
    return YES;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    int epid = ((EpisodeViewController*)viewController).epid;
    if (epid < 52) {
        return [[EpisodeViewController alloc] initWithEpid:epid+1];
    } else {
        return Nil;
    }
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    int epid = ((EpisodeViewController*)viewController).epid;
    if (epid > 0) {
        return [[EpisodeViewController alloc] initWithEpid:epid-1];
    } else {
        return Nil;
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    UIApplicationState state = [application applicationState];
    if (state == UIApplicationStateActive) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Reminder"
                                                        message:notification.alertBody
                                                       delegate:self cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

@end
