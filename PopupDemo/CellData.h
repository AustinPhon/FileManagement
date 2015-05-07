//
//  CellData.h
//  FileManagement
//
//  Created by Mobile C&C on 4/17/14.
//  Copyright (c) 2014 MCNC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CellData : NSObject
{
    NSString *_cellName;
    NSString *_dir;
    NSString *_dataType;
    BOOL _isChecked;
}
@property(nonatomic, retain) NSString *cellName;
@property(nonatomic, retain) NSString *dataType;
@property(nonatomic, assign) BOOL isChecked;
@property(nonatomic, retain) NSString *dir;

@end
