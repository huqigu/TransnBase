//
//  UIViewController+TRExtension.m
//  TRKeyboardManager
//
//  Created by 姜政 on 2020/4/18.
//

#import "UIViewController+TRExtension.h"
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "UIView+TRExtension.h"
#import "RCDCommonDefine.h"
@implementation UIViewController (TRExtension)

- (void)privateAvailable:(void (^) (BOOL available))handler{
    __weak typeof(self) weakSelf = self;
       [self checkMicUseable:^(BOOL available) {
           if (available) {
               [weakSelf checkVideoUseable:handler];
           }else{
               if (handler) {
                   handler(false);
               }
           }
       }];
}
- (void)checkMicUseable:(void (^) (BOOL available))handler
{
    AVAudioSession *avSession = [AVAudioSession sharedInstance];
    if ([avSession respondsToSelector:@selector(requestRecordPermission:)]) {
        [avSession requestRecordPermission:^(BOOL available) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (available) {
                    handler(available);
                } else {
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:NSLocalizedString(@"人工口译需要麦克风权限,请在设置中打开麦克风", @"口语培训需要麦克风权限,请在设置中打开麦克风") preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *action1 = [UIAlertAction actionWithTitle:NSLocalizedString(@"知道了",@"知道了") style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
                        handler(NO);
                    }];
                    [alert addAction:action1];
                    [self presentViewController:alert animated:YES completion:nil];
                }
            });
        }];
    }
}

-(void)checkVideoUseable:(void (^) (BOOL available))handler{
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        //这里是在block里面操作UI，因此需要回到主线程里面去才能操作UI
          dispatch_async(dispatch_get_main_queue(), ^{
             //回到主线程里面就不会出现延时几秒之后才执行UI操作
             //do you work
          if (granted) {
              handler(granted);
          } else {
              UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:NSLocalizedString(@"图片翻译需要相机权限,请在设置中打开相机", @"图片翻译需要相机权限,请在设置中打开相机") preferredStyle:UIAlertControllerStyleAlert];
              UIAlertAction *action1 = [UIAlertAction actionWithTitle:NSLocalizedString(@"知道了",@"知道了") style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
                  handler(NO);
              }];
              [alert addAction:action1];
              [self presentViewController:alert animated:YES completion:nil];
          }
      });
    }];
}

-(void)showError:(NSError *)error{
    [self showToast:error.userInfo[NSLocalizedDescriptionKey]];
}

-(void)showToast:(NSString *)toast duration:(float)duration{
    static NSString* toastString = nil;
    if ([toastString isEqualToString:toast]) return;
    toastString = toast;
   __block UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.text  = toast;
    label.textColor = [UIColor whiteColor];
 
    label.font = DEF_FONT(14);
    UIView *maskView = [[UIView alloc] init];
    maskView.backgroundColor =  APP_TextDarkColor;
    [maskView addSubview:label];
    [maskView addEdgeInset:UIEdgeInsetsMake(0, 8, 0, 8) subView:label];
    maskView.layer.cornerRadius = 5.0f;
    maskView.layer.masksToBounds = YES;
    maskView.translatesAutoresizingMaskIntoConstraints = NO;
    UIWindow *keyWindow = [UIApplication sharedApplication].windows.lastObject;
    if (!keyWindow || ![keyWindow isMemberOfClass:[UIWindow class]]) {
        keyWindow = DEF_KeyWindow;
    }
    if (!keyWindow) {
        return;
    }
    [keyWindow  addSubview:maskView];
    [keyWindow bringSubviewToFront:maskView];
    
    [keyWindow addConstraints:@[
    // 左边
    [NSLayoutConstraint constraintWithItem:maskView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:keyWindow attribute:NSLayoutAttributeLeading multiplier:1.0 constant:30],
 
    //中间
    [NSLayoutConstraint constraintWithItem:maskView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:keyWindow attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0],
    
    [NSLayoutConstraint constraintWithItem:maskView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:keyWindow attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0],

    
    // 高度
    [NSLayoutConstraint constraintWithItem:maskView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:0 multiplier:0 constant:40],
     ]];

    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        toastString = nil;
        [maskView removeFromSuperview];
    });
}
-(void)showToast:(NSString *)toast{
    [self showToast:toast duration:0.7];
}
-(void)showToast:(NSString *)toast rightView:(UIView *)view{
    static NSString* toastString = nil;
    if ([toastString isEqualToString:toast]) return;
    toastString = toast;
   __block UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.text  = toast;
    label.textColor = [UIColor whiteColor];
 
    label.font = DEF_FONT(14);
    UIView *maskView = [[UIView alloc] init];
    maskView.backgroundColor =  APP_TextDarkColor;
    [maskView addSubview:label];
    [maskView addEdgeInset:UIEdgeInsetsMake(0, 8, 0, 8) subView:label];
    maskView.layer.cornerRadius = 5.0f;
    maskView.layer.masksToBounds = YES;
    maskView.translatesAutoresizingMaskIntoConstraints = NO;
    UIWindow *keyWindow = DEF_KeyWindow;
    if (!keyWindow) {
        return;
    }
    [keyWindow  addSubview:maskView];
    [keyWindow bringSubviewToFront:maskView];
    
    [keyWindow addConstraints:@[
    // 右边
    [NSLayoutConstraint constraintWithItem:maskView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:-5],
 
    //中间
    [NSLayoutConstraint constraintWithItem:maskView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0],
    
    // 高度
    [NSLayoutConstraint constraintWithItem:maskView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:0 multiplier:0 constant:40],
     ]];

    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        toastString = nil;
        [maskView removeFromSuperview];
    });
}

#pragma mark camera utility
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}
- (CGFloat)getSystemVoiceValue{
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    CGFloat currentVol = audioSession.outputVolume;
    return currentVol;
}



@end
