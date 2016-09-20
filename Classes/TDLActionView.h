//
//  TDLActionView.h
//  TDLVersionMonitor
//
//  Created by 林浩智 on 2015/11/17.
//  Copyright © 2015年 林浩智. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^didClickActionButtonBlock)(BOOL completed, NSInteger buttonIndex);

@interface TDLActionView : NSObject

+ (TDLActionView *)sharedManager;

- (void)showArgumentActionSheetWithTitle:(NSString *)title message:(NSString *)message cancelButton:(NSString *)cancelButton buttons:(NSArray *)buttons completion:(void (^)(BOOL completed, NSInteger buttonIndex)) completion;

@end
