//
//  UIViewController+TRExtension.h
//  TRKeyboardManager
//
//  Created by 姜政 on 2020/4/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (TRExtension)

- (void)privateAvailable:(void (^) (BOOL available))handler;


- (void)checkMicUseable:(void (^) (BOOL available))handler;

-(void)checkVideoUseable:(void (^) (BOOL available))handler;

-(void)showError:(NSError *)error;

-(void)showToast:(NSString *)toast;
-(void)showToast:(NSString *)toast duration:(float)duration;

-(void)showToast:(NSString *)toast rightView:(UIView *)view;
#pragma mark camera utility
- (BOOL) isCameraAvailable;
- (BOOL) isRearCameraAvailable;

- (BOOL) isFrontCameraAvailable;
- (BOOL) doesCameraSupportTakingPhotos;

- (BOOL) isPhotoLibraryAvailable;
- (BOOL) canUserPickVideosFromPhotoLibrary;
- (BOOL) canUserPickPhotosFromPhotoLibrary;

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType;

- (CGFloat)getSystemVoiceValue;


@end

NS_ASSUME_NONNULL_END
