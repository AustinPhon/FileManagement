//
//  CellWithCheckbox.h
//  FileManagement
//
//  Created by Mobile C&C on 3/15/14.
//  Copyright (c) 2014 Mobile C&C. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CellWithCheckbox;

@protocol CellWithCheckboxDelegate<NSObject>
@optional
-(void)cell:(CellWithCheckbox *)cell checkboxTappedEvent:(UITouch *)touch;
@end

@interface CellWithCheckbox : UITableViewCell{
    UILabel *_cellNameLabel;
    UIButton *_checkboxButton;
    UIImage *_checkedImage;
    UIImage *_uncheckedImage;
    long rowIndex;
    id<CellWithCheckboxDelegate> _delegates;
}
@property (assign) long rowIndex;

@property(nonatomic, assign) id <CellWithCheckboxDelegate> delegate;
- (void)setCellName:(NSString *)aCellName;
- (void)setCheckboxState:(BOOL)isCheck;
@end
