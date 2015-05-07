//
//  SecondViewController.m
//  FileManagement
//
//  Created by Mobile C&C on 3/15/14.
//  Copyright (c) 2014 Mobile C&C. All rights reserved.
//

#import "SecondViewController.h"
#import "CellData.h"
#import "AppDelegate.h"

@interface SecondViewController ()

@end

NSArray *_cellDataArray;
NSMutableArray *secondTmpArr;
static NSString * documentsPath;
@implementation SecondViewController
@synthesize pathCopy;

- (void)viewDidLoad
{
    [_darkBackground setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [_smallOverlayView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [_secondView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    
    [_smallOverlayView.layer setCornerRadius:15];
    [_smallOverlayView.layer setMasksToBounds:YES];
    
    [super viewDidLoad];
    [self.navigationController setModalPresentationStyle:UIModalPresentationCurrentContext];
    [self setModalPresentationStyle:UIModalPresentationCurrentContext];
    
     secondTmpArr = [[NSMutableArray alloc] init];
    
    ///Get Sample File Folder
    NSString * resourcePath = [[NSBundle mainBundle] resourcePath];
    documentsPath = [resourcePath stringByAppendingPathComponent:@"Sample Files"];
    NSError * error;
    NSArray * directoryContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsPath error:&error];

    for(id item in directoryContents)
    {
        CellData *cellData = [[CellData alloc] init];
        cellData.cellName = item;
        cellData.dir=[NSString stringWithFormat:@"%@/%@",documentsPath,item];
        cellData.isChecked = NO;
        [secondTmpArr addObject:cellData];
    }
    
    _cellDataArray = [[NSArray alloc] initWithArray:secondTmpArr];
}

-(void)viewDidAppear:(BOOL)animated
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate setShouldRotate:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)dismicclick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:Nil];
}

- (IBAction)copyIteams:(id)sender {
    CellData *obj;
    for (obj in _cellDataArray) {
        if (obj.isChecked){
            NSFileManager *filemgr;
            filemgr = [NSFileManager defaultManager];
            NSString *copyItem=[NSString stringWithFormat:@"%@/%@",documentsPath,obj.cellName];
            NSString *toDir=[NSString stringWithFormat:@"%@/%@",pathCopy,obj.cellName];

            [filemgr copyItemAtPath:copyItem toPath:toDir error:nil];
            [self dismissViewControllerAnimated:YES completion:Nil];
        }
    }
    [self.delegate passItemBack:self didFinishWithItem:pathCopy];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_cellDataArray count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"Cell";
    CellWithCheckbox *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(cell == nil){
        cell = [[CellWithCheckbox alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    cell.delegate = self;
    [cell setCheckboxState:[(CellData *)[_cellDataArray objectAtIndex:indexPath.row] isChecked]];
    CellData *cellData = [_cellDataArray objectAtIndex:indexPath.row];
    cell.rowIndex=indexPath.row;
    [cell setCellName:cellData.cellName];
    return cell;
}

- (void)cell:(CellWithCheckbox *)cell checkboxTappedEvent:(UITouch *)touch
{
    CellData *cellData = [_cellDataArray objectAtIndex:cell.rowIndex];
    cellData.isChecked = !cellData.isChecked;
    [cell setCheckboxState:cellData.isChecked];
}

@end
