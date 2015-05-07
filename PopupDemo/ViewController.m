//
//  ViewController.m
//  FileManagement
//
//  Created by Mobile C&C on 3/15/14.
//  Copyright (c) 2014 Mobile C&C. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "CellData.h"
#import "AppDelegate.h"

@implementation ViewController

static NSString *oriPath;
NSString *path;

- (void)viewDidLoad
{
    @try
    {
        
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        [appDelegate setShouldRotate:NO];
        [_mainTableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        
        [super viewDidLoad];
        [self.navigationController setModalPresentationStyle:UIModalPresentationCurrentContext];
        [self setModalPresentationStyle:UIModalPresentationCurrentContext];
        [self.btnRemove setEnabled:FALSE];
        
        tmpArr = [[NSMutableArray alloc] init];
        defaultManager = [NSFileManager defaultManager];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        oriPath = path = [paths objectAtIndex:0];
        NSString *titleView = [path lastPathComponent];
        [self.navigationItem setTitle:titleView];
        
        NSError *error;
        NSArray * directoryContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:&error ];
        _cellDataArray = [[NSArray alloc] initWithArray:[self dataForCell:directoryContents
                                                                 withPath:path]];
    }
    @catch (NSException *exception)
    {
        NSLog(@"Exception %@",exception);
    }
}
-(void)viewDidAppear:(BOOL)animated
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate setShouldRotate:NO];
}


#pragma mark -  action and event with TableView
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
    NSString *CellIdentifier = @"fileCell";
    CellWithCheckbox *cell = [tableView dequeueReusableCellWithIdentifier:@"fileCell"];
    if(cell == nil)
    {
        cell = [[CellWithCheckbox alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    cell.delegate = self;
    [cell setCheckboxState:[(CellData *)[_cellDataArray objectAtIndex:indexPath.row] isChecked]];
    CellData *cellData = [_cellDataArray objectAtIndex:indexPath.row];
    [cell setTintColor:[UIColor blueColor]];
    [cell setCellName:cellData.cellName];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CellData *cellData = [_cellDataArray objectAtIndex:indexPath.row];
    
    //if it is file open, but if not reload data to tableview on directory path:
    if([cellData.dataType isEqualToString:@"file"])
    {
        self.urlForDisplay = cellData.dir;
        [self performSegueWithIdentifier:@"DisplayDoc" sender:self];
    
        //        [self.navigationController setNavigationBarHidden:TRUE];
        //        [self.navigationController setToolbarHidden:TRUE];
        //        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 500, 700)];
        //        webView.contentMode=UIViewContentModeScaleAspectFill;
        //        NSURL *targetURL = [NSURL fileURLWithPath:cellData.dir];
        //
        //        NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
        //        [self.navigationController setTitle:cellData.cellName];
        //        [webView loadRequest:request];
        //        [self.view addSubview:webView];
    }
    else
    {
        [tmpArr removeAllObjects];
        NSError *error;
        path=[NSString stringWithFormat:@"%@/%@",path,cellData.cellName];
        NSArray * directoryContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:&error ];
        
        UIImage *backImg = [[UIImage imageNamed:@"Arrows-Back-icon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
        [back addTarget:self action:@selector(BackMenuEvent) forControlEvents:UIControlEventTouchUpInside];
        back.bounds = CGRectMake( 0, 0, 23, 23 );
        [back setImage:backImg forState:UIControlStateNormal];
        [back setTintColor:[UIColor colorWithRed:(68/255.0) green:(120/255.0) blue:(248.0/255.0) alpha:1.0]];

        UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithCustomView:back];
        [backButton setTintColor:[UIColor blueColor]];
        
        
        [self.navigationController.navigationItem setTitle:cellData.cellName];
        [self.navigationItem setTitle:cellData.cellName];
        [self.navigationItem setLeftBarButtonItem:backButton animated:YES];
        _cellDataArray = [[NSArray alloc] initWithArray:[self dataForCell:directoryContents withPath:path]];
        [self tableViewReloadData];
    }
    
}

- (void)cell:(CellWithCheckbox *)cell checkboxTappedEvent:(UITouch *)touch
{
    CGPoint touchPt = [touch locationInView:self.view];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:touchPt];
    CellData *cellData = [_cellDataArray objectAtIndex:indexPath.row];
    cellData.isChecked = !cellData.isChecked;
    [cell setCheckboxState:cellData.isChecked];
    
    for(CellData *obj in _cellDataArray)
        if(obj.isChecked)
        {
            [self.btnRemove setEnabled:TRUE];   return;
        }
        else
        {
            [self.btnRemove setEnabled:FALSE];
        }
}

#pragma mark - Add and Remove Button action
- (IBAction)addItems:(id)sender
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Input Directory Name" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: @"Create", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

- (IBAction)removeItems:(id)sender
{
    for(int i=0;i<_cellDataArray.count;i++)
    {
        CellData *cellData = [_cellDataArray objectAtIndex:i];
        if(cellData.isChecked)
        {
            [[NSFileManager defaultManager] removeItemAtPath:cellData.dir error:nil];
        }
    }
    [tmpArr removeAllObjects];
    NSError *error;
    NSArray * directoryContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:&error ];
    _cellDataArray = [[NSArray alloc] initWithArray:[self dataForCell:directoryContents withPath:path]];
    [self tableViewReloadData];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *buttonTitle=[alertView buttonTitleAtIndex:buttonIndex];
    
    if([buttonTitle isEqualToString:@"Create"]) {
        NSString *cellName = [[alertView textFieldAtIndex:0 ]text];
        if ([cellName length]!=0)
        {
            NSString *filePathAndDirectory = [path stringByAppendingPathComponent:cellName];
            NSError *error;
            [[NSFileManager defaultManager] createDirectoryAtPath:filePathAndDirectory
                                      withIntermediateDirectories:NO  attributes:nil  error:&error];
            
            CellData *cellData = [[CellData alloc] init];
            cellData.dir=filePathAndDirectory;
            cellData.cellName = cellName;
            cellData.isChecked = NO;
            [tmpArr addObject:cellData];
            
            _cellDataArray = [[NSArray alloc] initWithArray:tmpArr];
            [self tableViewReloadData];
        }
        else
            return;
    }
    else if([buttonTitle isEqualToString:@"Cancel"])
    {
        return;
    }
}

#pragma mark - button Back event
- (void)BackMenuEvent
{
    NSError *error;
    
    NSString *newPath=[path lastPathComponent];
    path=[path stringByDeletingLastPathComponent];
    
    NSArray * directoryContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:&error ];
    tmpArr=[[NSMutableArray alloc]init];
    
    if ([oriPath isEqualToString:path]) {
        // HIde back button
        [self.navigationController.navigationBar.topItem setLeftBarButtonItem:nil animated:NO];
    }
    
    [self.navigationItem setTitle:[path lastPathComponent]];
    _cellDataArray = [[NSArray alloc] initWithArray:[self dataForCell:directoryContents withPath:newPath]];
    [self tableViewReloadData];
}

#pragma mark - Send and Get data back from SecondViewController
-(void)passItemBack:(SecondViewController *)controller didFinishWithItem:(NSString *)copyItemDir
{
    NSError *error;
    NSArray * directoryContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:copyItemDir error:&error];
    tmpArr=[[NSMutableArray alloc]init];
    _cellDataArray = [[NSArray alloc] initWithArray:[self dataForCell:directoryContents withPath:copyItemDir]];
    [self tableViewReloadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"PopMenu"]){
        SecondViewController *vc=[segue destinationViewController];
        vc.delegate=self;
        vc.pathCopy=path;
    }
    else if([segue.identifier isEqualToString:@"DisplayDoc"]){
        DisplayDocView *displayDoc = segue.destinationViewController;
        [displayDoc setUrl:self.urlForDisplay];
    }
}

#pragma mark - tableView Reload data
-(NSArray *)dataForCell:(NSArray *)dirContent withPath:(NSString *)path
{
    for(id item in dirContent)
    {
        CellData *cellData = [[CellData alloc] init];
        cellData.cellName = item;
        cellData.dir=[NSString stringWithFormat:@"%@/%@",path,item];
        cellData.isChecked = NO;
        
        if([[item pathExtension] isEqualToString:@""])
        {
            cellData.dataType=@"dir";
        }
        else
        {
            cellData.dataType=@"file";
        }
        [tmpArr addObject:cellData];
    }
    return tmpArr;
}

-(void)tableViewReloadData
{
    [self.mainTableView reloadData];
}

@end
