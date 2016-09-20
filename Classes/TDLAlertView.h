//
//  TDLAlertView.h
//  TDLTest
//
//  Created by rin on 2016/09/20.
//  Copyright © 2016年 rin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^didClickButtonBlock)(BOOL completed, NSInteger buttonIndex);

@interface TDLAlertView : NSObject

+ (TDLAlertView *)sharedManager;

- (void)showArgumentAlertWithTitle:(NSString *)title message:(NSString *)message cancelButton:(NSString *)cancelButton buttons:(NSArray *)buttons completion:(didClickButtonBlock)completion;

@end
