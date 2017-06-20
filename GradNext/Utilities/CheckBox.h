//
//  CheckBox.h
//  CareCredit
//
//  Created by GECRBCareCredit on 17/02/15.
//  Copyright (c) 2015 GECRBCareCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CheckBoxDelegate;

@interface CheckBox : UIButton {
    //id<CheckBoxDelegate> _delegate;
    BOOL _checked;
    id _userInfo;
}

@property(nonatomic, assign)id <CheckBoxDelegate> delegate;
@property(nonatomic, assign)BOOL checked;
@property(nonatomic, retain)id userInfo;

- (id)initWithDelegate:(id)delegate;

@end

@protocol CheckBoxDelegate <NSObject>

@optional

- (void)didSelectedCheckBox:(CheckBox *)checkbox checked:(BOOL)checked;

@end
