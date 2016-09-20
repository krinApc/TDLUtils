//
//  TDLActionView.m
//  TDLVersionMonitor
//
//  Created by 林浩智 on 2015/11/17.
//  Copyright © 2015年 林浩智. All rights reserved.
//

#import "TDLActionView.h"
#import "TDLSystem.h"

static TDLActionView *sharedManager = nil;

@interface TDLActionView()<UIActionSheetDelegate>

@property (copy) didClickActionButtonBlock clickBlock;

@end

@implementation TDLActionView

+ (TDLActionView *)sharedManager {
    if (!sharedManager) {
        sharedManager = [[TDLActionView alloc] init];
    }
    
    return sharedManager;
}

- (void)showArgumentActionSheetWithTitle:(NSString *)title message:(NSString *)message cancelButton:(NSString *)cancelButton buttons:(NSArray *)buttons completion:(didClickActionButtonBlock)completion {
    
    [TDLSystem getLastestViewController:^(UIViewController *lastestviewController) {
        if ([TDLSystem getIosVersion] >= 8.0) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
            
            [buttons enumerateObjectsUsingBlock:^(NSString *buttonName, NSUInteger idx, BOOL *stop) {
                [alertController addAction:[UIAlertAction actionWithTitle:buttonName style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    if (completion) completion(YES, idx+1);
                }]];
            }];
            
            [alertController addAction:[UIAlertAction actionWithTitle:cancelButton style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                if (completion) completion(YES, 0);
            }]];
            
            [lastestviewController presentViewController:alertController animated:YES completion:nil];
        } else {
            self.clickBlock = completion;
            
            UIActionSheet *actionSheet = [[UIActionSheet alloc] init];
            actionSheet.delegate = self;
            actionSheet.title = title;
            [actionSheet addButtonWithTitle:cancelButton];
            
            [buttons enumerateObjectsUsingBlock:^(NSString *button, NSUInteger idx, BOOL * stop) {
                [actionSheet addButtonWithTitle:button];
            }];
            actionSheet.cancelButtonIndex = 0;
            [actionSheet showInView:lastestviewController.view];
        }
    }];
}

- (void)actionSheet:(UIActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (self.clickBlock) {
        self.clickBlock(YES, buttonIndex);
    }
}

@end
