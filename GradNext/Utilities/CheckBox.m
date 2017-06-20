//
//  CheckBox.m
//  CareCredit
//
//  Created by GECRBCareCredit on 17/02/15.
//  Copyright (c) 2015 GECRBCareCredit. All rights reserved.
//

#import "CheckBox.h"

#define CHECK_ICON_WH                    (20.0)
#define ICON_TITLE_MARGIN                (10.0)

@implementation CheckBox

@synthesize delegate = _delegate;
@synthesize checked = _checked;
@synthesize userInfo = _userInfo;

- (id)initWithDelegate:(id)delegate {
    self = [super init];
    if (self) {
        _delegate = delegate;
        
        self.exclusiveTouch = YES;
        [self setImage:[UIImage imageNamed:@"circle"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"chkd"] forState:UIControlStateSelected];
        [self addTarget:self action:@selector(checkboxBtnChecked) forControlEvents:UIControlEventTouchUpInside];
        [self setTitleColor:[UIColor grayColor]  forState:UIControlStateNormal];
        [self.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:16]];
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.contentVerticalAlignment  = UIControlContentVerticalAlignmentTop;
        self.titleEdgeInsets = UIEdgeInsetsMake(4, 18, 0, 0);
        self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);

    }
    return self;
}

- (void)setChecked:(BOOL)checked {
    if (_checked == checked) {
        return;
    }
    
    _checked = checked;
    self.selected = checked;
    
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectedCheckBox:checked:)]) {
        [_delegate didSelectedCheckBox:self checked:self.selected];
    }
}

- (void)checkboxBtnChecked {
    self.selected = !self.selected;
    _checked = self.selected;
    
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectedCheckBox:checked:)]) {
        [_delegate didSelectedCheckBox:self checked:self.selected];
    }
}

//- (CGRect)imageRectForContentRect:(CGRect)contentRect {
//    NSLog(@"Line : %i",[self lineCountForLabel:self.titleLabel]);
//    if([self lineCountForLabel:self.titleLabel] == 1)
//        return CGRectMake(0, self.frame.size.height, 15.0, 15.0);
//    else
//        return CGRectMake(0, 0, 15, 15);
//}


//- (int)lineCountForLabel:(UILabel *)label
//{
//    CGFloat labelWidth = label.frame.size.width;
//    int lineCount = 0;
//    CGSize textSize = CGSizeMake(labelWidth, MAXFLOAT);
//    long rHeight = lroundf([label sizeThatFits:textSize].height);
//    long charSize = lroundf(label.font.leading);
//    lineCount = (int)( rHeight / charSize );
//    return lineCount;
//}


@end
