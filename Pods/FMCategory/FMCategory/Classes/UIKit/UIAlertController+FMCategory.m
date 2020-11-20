//
//  UIAlertController+FMCategory.m
//  FMPrivateLib_Example
//
//  Created by dahl.chen on 2020/8/24.
//  Copyright © 2020 lyon_lzy@sina.cn. All rights reserved.
//

#import "UIAlertController+FMCategory.h"

@implementation UIAlertController (FMCategory)
+ (instancetype)fm_createAlertControllerWithmessage:(NSString *)message{
    return [self fm_createAlertControllerWithTitle:@""
                                        message:message
                              cancleActionTitle:@"确定"
                         destructiveActionTitle:nil
                                        actions:nil
                                        handler:nil];
}

+ (instancetype)fm_createAlertControllerWithTitle:(NSString *)title
                                       message:(NSString *)message
                             cancleActionTitle:(NSString *)cancleActionTitle
                        destructiveActionTitle:(NSString *)destructiveActionTitle
                                       actions:(NSArray *)actions
                                       handler:(UIAlertControllerActionBlock)handler{
    return [self fm_createAlertControllerWithTitle:title
                                 message:message
                       cancleActionTitle:cancleActionTitle
                  destructiveActionTitle:destructiveActionTitle
                titleAndMessageAlignment:NSTextAlignmentNatural
                                   style:UIAlertControllerStyleAlert
                             withActions:actions
                             withhandler:handler];
}

+ (instancetype)fm_createAlertControllerWithTitle:(NSString *)title
                                       message:(NSString *)message
                             cancleActionTitle:(NSString *)cancleActionTitle
                        destructiveActionTitle:(NSString *)destructiveActionTitle
                                    textFields:(NSArray *)textFields
                                       actions:(NSArray *)actions
                                       handler:(UIAlertControllerActionBlock)handler{
    
    UIAlertController *alertController = [self fm_createAlertControllerWithTitle:title
                                                                      message:message
                                                            cancleActionTitle:cancleActionTitle
                                                       destructiveActionTitle:destructiveActionTitle
                                                     titleAndMessageAlignment:NSTextAlignmentNatural
                                                                        style:UIAlertControllerStyleAlert
                                                                  withActions:actions
                                                                  withhandler:handler];
    if (textFields.count)
    {
        for (NSString *text in textFields)
        {
            [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
                textField.placeholder = text;
            }];
        }
    }
    return alertController;
}

+ (instancetype)fm_createAlertControllerWithTitle:(NSString *)title
                                       message:(NSString *)message
                             cancleActionTitle:(NSString *)cancleActionTitle
                        destructiveActionTitle:(NSString *)destructiveActionTitle
                      titleAndMessageAlignment:(NSTextAlignment)alignment
                                         style:(UIAlertControllerStyle)style
                                   withActions:(NSArray *)actions
                                   withhandler:(UIAlertControllerActionBlock)handler
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    
    UIPopoverPresentationController *popover = alertController.popoverPresentationController;
    if (popover){
        UIView *popverView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 0)];
        popover.sourceView = popverView;
        popover.sourceRect = popverView.bounds;
        popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
    }
    
    {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.alignment = alignment;
        NSDictionary * attributes = @{NSParagraphStyleAttributeName : paragraphStyle};
        NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc] initWithString:message];
        [attributedTitle addAttributes:attributes range:NSMakeRange(0, message.length)];
        [alertController setValue:attributedTitle forKey:@"attributedMessage"];
    }
    
    {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.alignment = alignment;
        NSDictionary * attributes = @{NSParagraphStyleAttributeName : paragraphStyle};
        NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc] initWithString:title];
        [attributedTitle addAttributes:attributes range:NSMakeRange(0, message.length)];
        [alertController setValue:attributedTitle forKey:@"attributedTitle"];
    }
    if (cancleActionTitle) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancleActionTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (handler) {
                handler(action, alertController);
            }
        }];
        [alertController addAction:cancelAction];
    }
    
    if (destructiveActionTitle) {
        UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:destructiveActionTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            if (handler) {
                handler(action, alertController);
            }
        }];
        [alertController addAction:destructiveAction];
    }
    
    if (actions.count > 0) {
        for (NSString *actionTitle in actions) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:actionTitle
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * _Nonnull action) {
                                                               if (handler) {
                                                                   handler(action, alertController);
                                                               }
                                                           }];
            [alertController addAction:action];
        }
    }
    
#if !__has_feature(objc_arc)
    return [alertController autorelease];
#else
    return alertController;
#endif
}

@end
