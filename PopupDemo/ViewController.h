//
//  ViewController.h
//  FileManagement
//
//  Created by Mobile C&C on 3/15/14.
//  Copyright (c) 2014 Mobile C&C. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondViewController.h"
#import "CellWithCheckbox.h"
#import "DisplayDocView.h"

@interface ViewController : UITableViewController<CellWithCheckboxDelegate,ViewController2Delegate>
{
    NSArray *_cellDataArray;
    NSMutableArray *tmpArr;
    NSFileManager *defaultManager;
}

- (IBAction)addItems:(id)sender;
- (IBAction)removeItems:(id)sender;

@property (nonatomic,weak) NSString *urlForDisplay;

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnRemove;

@end
