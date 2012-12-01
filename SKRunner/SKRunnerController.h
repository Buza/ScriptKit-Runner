//
//  SKRunnerController.h
//  ScriptKit
//
//  Created by buza on 11/8/12.
//
//

#import <UIKit/UIKit.h>

typedef void (^SKBlockVoid)(void);

@interface SKRunnerController : UIViewController

@property(nonatomic, weak) IBOutlet UIView *mContentContainer;
@property(nonatomic, copy) SKBlockVoid completionBlock;
@property(nonatomic, weak) UIImageView *mainScriptLoadSpinner;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil initialScriptType:(NSString*)initialScriptType code:(NSString*)code;

-(void) setup;

@end
