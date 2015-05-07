//
//  CellWithCheckbox.m
//  FileManagement
//
//  Created by Mobile C&C on 3/15/14.
//  Copyright (c) 2014 Mobile C&C. All rights reserved.
//

#import "CellWithCheckbox.h"

@interface CellWithCheckbox()
- (void)checkboxTapped:(id)sender event:(id)event;
@end

@implementation CellWithCheckbox
@synthesize rowIndex;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    //Essays that worked for law schools, 35 Eassays for sucessful applications to the nations's top law school.
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _checkboxButton = [UIButton buttonWithType:UIButtonTypeCustom];
        NSString *checkedImgPath = [[NSBundle mainBundle] pathForResource:@"checkedmark" ofType:@"png"];
        NSString *uncheckedImgPath = [[NSBundle mainBundle] pathForResource:@"uncheckmark" ofType:@"png"];
        _checkedImage = [[UIImage alloc] initWithContentsOfFile:checkedImgPath];
        _uncheckedImage = [[UIImage alloc] initWithContentsOfFile:uncheckedImgPath];
        [_checkboxButton setImage:_uncheckedImage forState:UIControlStateNormal];
        _checkboxButton.frame = CGRectMake(0, 0, 44, 44);
        [_checkboxButton addTarget:self
                            action:@selector(checkboxTapped:event:)
                  forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_checkboxButton];

        _cellNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 12, 220, 20)];
        _cellNameLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
     
        [self addSubview:_cellNameLabel];
    }
    return self;
}

- (void)setCellName:(NSString *)aCellName
{
    [_cellNameLabel setTintColor:  [UIColor redColor]];
    _cellNameLabel.text = aCellName;

}

- (void)checkboxTapped:(id)sender event:(id)event
{
    NSSet *set = [event allTouches];
    UITouch *touch = [set anyObject];
    if (touch && [_delegate respondsToSelector:@selector(cell:checkboxTappedEvent:)]){
        [_delegate cell:self checkboxTappedEvent:touch];
    }
}
-(NSString *)StringName
{
    return _cellNameLabel.text;
}
- (void)setCheckboxState:(BOOL)isCheck
{
    if(isCheck){
        [_checkboxButton setImage:_checkedImage forState:UIControlStateNormal];
    }else{
        [_checkboxButton setImage:_uncheckedImage forState:UIControlStateNormal];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if (selected){
        _cellNameLabel.textColor = [UIColor whiteColor];
    }else{
        _cellNameLabel.textColor = [UIColor blackColor];
    }
}

@end
