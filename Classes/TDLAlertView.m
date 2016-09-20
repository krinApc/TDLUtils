//
//  TDLAlertView.m
//  TDLTest
//
//  Created by rin on 2016/09/20.
//  Copyright © 2016年 rin. All rights reserved.
//

#import "TDLAlertView.h"
#import "TDLSystem.h"

static TDLAlertView *sharedManager = nil;

@interface TDLAlertView()<UIAlertViewDelegate>

@property (copy) didClickButtonBlock clickBlock;

@end

@implementation TDLAlertView

+ (TDLAlertView *)sharedManager {
    if (!sharedManager) {
        sharedManager = [[TDLAlertView alloc] init];
    }
    
    return sharedManager;
}

#pragma mark -- Alert with arguments
- (void)showArgumentAlertWithTitle:(NSString *)title message:(NSString *)message cancelButton:(NSString *)cancelButton buttons:(NSArray *)buttons completion:(didClickButtonBlock)completion {
    
    if ([TDLSystem getIosVersion] >= 8.0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:cancelButton style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if (completion) completion(YES, 0);
        }]];
        
        [buttons enumerateObjectsUsingBlock:^(NSString *buttonName, NSUInteger idx, BOOL *stop) {
            [alertController addAction:[UIAlertAction actionWithTitle:buttonName style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                if (completion) completion(YES, idx+1);
            }]];
        }];
        
        [TDLSystem getLastestViewController:^(UIViewController *lastestviewController) {
            [lastestviewController presentViewController:alertController animated:YES completion:nil];
        }];
    } else {
        
        self.clickBlock = completion;
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        NSString *firstObject = buttons.count ? buttons[0] : nil;
        
        UIAlertView *alertView =  [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButton otherButtonTitles:firstObject, nil];
        
        if (buttons.count > 1) {
            for (NSString *buttonTitle in [buttons subarrayWithRange:NSMakeRange(1, buttons.count - 1)]) {
                [alertView addButtonWithTitle:buttonTitle];
            }
        }
        
        [alertView show];
#pragma clang diagnostic pop
    }
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (self.clickBlock) {
        self.clickBlock(YES, buttonIndex);
    }
}
#pragma clang diagnostic pop

@end
