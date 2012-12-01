//
//  AppDelegate.m
//  ScriptKit Runner
//
//  Created by buza on 11/8/12.
//  Copyright (c) 2012 buzamoto. All rights reserved.
//

#import "AppDelegate.h"
#import "SKRunnerController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    NSString *bundledScriptPath = [[NSBundle mainBundle] pathForResource:@"script" ofType:@"lua"];

    NSData *scriptData = [NSData dataWithContentsOfFile:bundledScriptPath];
    NSString *scriptString = [[NSString alloc] initWithData:scriptData encoding:NSUTF8StringEncoding];

    _viewController = [[SKRunnerController alloc] initWithNibName:@"SKRunnerController" bundle:nil initialScriptType:@"lua" code:scriptString];
        
	_window.rootViewController = _viewController;
	[_window makeKeyAndVisible];
    
    [_viewController setup];
    
	return YES;
}

- (void)dealloc
{
}

@end
