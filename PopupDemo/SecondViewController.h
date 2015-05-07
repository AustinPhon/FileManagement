//
//  SecondViewController.h
//  FileManagement
//
//  Created by Mobile C&C on 3/15/14.
//  Copyright (c) 2014 Mobile C&C. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "CellWithCheckbox.h"
@class SecondViewController;

@protocol ViewController2Delegate <NSObject>
-(void)passItemBack:(SecondViewController *)controller didFinishWithItem:(NSString *)copyItemDir;
@end

@interface SecondViewController : UIViewController<CellWithCheckboxDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *darkBackground;
@property (strong, nonatomic) IBOutlet UIView *smallOverlayView;

@property (weak, nonatomic) IBOutlet UITableView *secondView;
@property (weak, nonatomic) NSString *pathCopy;
@property (weak, nonatomic) id<ViewController2Delegate>delegate;

- (IBAction)dismicclick:(id)sender;
- (IBAction)copyIteams:(id)sender;

@end
