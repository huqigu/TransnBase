//
//  TransnCommonDefine.h
//  Pods
//
//  Created by 姜冲 on 2022/7/6.
//
#import "TRKeyWindow.h"
#import "TPCommonFoundation.h"

#ifndef RCDCommonDefine_h
#define RCDCommonDefine_h

#define DEFAULTS [NSUserDefaults standardUserDefaults]

#define APP_VERSION                     [NSString stringWithString:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]]
#define APP_BUILD_VERSION               [NSString stringWithString:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]]


#define HEXCOLOR(rgbValue)                                                                                             \
    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0                                               \
                    green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0                                                  \
                     blue:((float)(rgbValue & 0xFF)) / 255.0                                                           \
                    alpha:1.0]

#define RCDDebugTestFunction 0

#define WDDebugLogFunction 0

#define RCDPrivateCloudManualMode 0

#define RCDscreenWidth [UIScreen mainScreen].bounds.size.width
#define RCDscreenHeight [UIScreen mainScreen].bounds.size.height

#define RCDIsIPad [[UIDevice currentDevice].model containsString:@"iPad"]

#define rcd_dispatch_main_async_safe(block)                                                                            \
if ([NSThread isMainThread]) {                                                                                     \
    block();                                                                                                       \
} else {                                                                                                           \
    dispatch_async(dispatch_get_main_queue(), block);                                                              \
}

#define TESTUSERIDPUSH 0


#pragma mark xib&storyboard
///nib文件，cell复用时使用
#define BundleNib(className)   tr_nibWithClass([className class])

///即时加载，解析nib对象数组中的view对象
#define NibViewClass(className) tr_loadNibClass([className class])

#define Story(storyName)    tr_storyboardWithName(storyName)

#define InstantiateViewController(storyName,className) className*vc = tr_instantiateViewControllerWithClass(storyName,[className class]);


#define InstantiateViewControllerFormString(storyName,identifier) UIViewController*vc = tr_instantiateViewControllerWithIdentifier(storyName,identifier);

#define NibViewController(className) className *vc = tr_initWithNibClass([className class]);



#pragma mark string&class

#define StringFromClass(className) NSStringFromClass([className class])
#define ClassFromContent(className) [className class]


#pragma mark cell
#define RegisterTableCell(tableView,cellClassName)  tr_registerTableCell(tableView,[cellClassName class]);

#define RegisterCell(cellClassName)   tr_registerTableCell(self.tableV,[cellClassName class]);

#define ReusableTableCell(tableView,cellClassName) tr_reusableTableCell(tableView,[cellClassName class]);

#define ReusableCell(cellClassName) tr_reusableTableCell(tableView,[cellClassName class]);

#define CollectionVRegisterCell(collectionV,cellClassName) tr_collectionVRegisterCell(collectionV,[cellClassName class]);

#define CollectionRegisterCell(cellClassName)  tr_collectionVRegisterCell(self.collectionV,[cellClassName class]);

#define CollectionVReusableCell(collectionV,cellClassName,indexPath)  tr_collectionVReusableCell(collectionV,[cellClassName class],indexPath);

#define CollectionReusableCell(cellClassName) tr_collectionVReusableCell(collectionView,[cellClassName class],indexPath);

#define DEF_KeyWindow        [TRKeyWindow keyWindow]


#define DEVICE_IS_IPAD                  ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)

#pragma mark Dert
#define DEF_DERT    MIN(1.25,([UIScreen mainScreen].bounds.size.width/375.0f))
#define DEF_SCREEN_HEIGHT                   [[UIScreen mainScreen] bounds].size.height
#define DEF_SCREEN_WIDTH                    [[UIScreen mainScreen] bounds].size.width
#define OMString(str)                    NSLocalizedString(str,str)
#define TRString(str)                    NSLocalizedString(str,str)


#define DEF_BFONT(x)  [UIFont fontWithName:@"PingFangSC-Semibold" size:x]
#define DEF_MFONT(x)  [UIFont fontWithName:@"PingFangSC-Medium" size:x]
#define DEF_FONT(x) [UIFont fontWithName:@"PingFangSC-Regular" size:DEF_DERT>1?MAX(x+1, x*DEF_DERT):x]
#define DEF_NoneAutoFONT(x) [UIFont fontWithName:@"PingFangSC-Regular" size:x]
#define DEF_AUTOFONT(x) [UIFont fontWithName:@"PingFangSC-Regular" size:x*DEF_DERT]

#define Font_SCALE                      (DEVICE_IS_IPHONE4?.5:(DEVICE_IS_IPHONE5?.5:(DEVICE_IS_IPHONE6?1:(DEVICE_IS_IPHONE6PAFTER?2:1))))
#define SystemFontOfSize(s)             [UIFont systemFontOfSize:s+Font_SCALE]

#define MIN_FONT                       SystemFontOfSize(10)//[UIFont systemFontOfSize:12]
#define MID_FONT                       SystemFontOfSize(12)//[UIFont systemFontOfSize:14]
#define MAX_FONT                       SystemFontOfSize(15)//[UIFont systemFontOfSize:17]
#define MAXM_FONT                      SystemFontOfSize(18)//[UIFont systemFontOfSize:22]
#define MMAX_FONT                      SystemFontOfSize(20)//[UIFont systemFontOfSize:22]
#define MMMAX_FONT                     SystemFontOfSize(24)//[UIFont systemFontOfSize:24]

#define RGB(r,g,b)                      [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBA(r,g,b,a)                   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]
#define rgba(r,g,b,a)                   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromHexString(hexString) UIColorFromRGB(strtoul([hexString UTF8String],0,16))
#define COLOR_T3        UIColorFromRGB(0x333333)//黑色
#define COLOR_T6        UIColorFromRGB(0x666666)//灰色
#define COLOR_T9        UIColorFromRGB(0x999999)
#define COLOR_TB        UIColorFromRGB(0xBBBBBB)
#define COLOR_TC        UIColorFromRGB(0xCCCCCC)
#define COLOR_TE        UIColorFromRGB(0xEEEEEE)
#define COLOR_TBLUE     UIColorFromRGB(0X00B8EE)//淡蓝色
#define COLOR_TEC       UIColorFromRGB(0xECECEC)
#define COLOR_BLUE      UIColorFromRGB(0x5abedc)

#define APP_LineColor                  rgba(226, 223, 226, 1)
#define APP_Color                      rgba(20, 187, 140, 1)
#define APP_NAV_Color                  rgba(20, 187, 140, 1)
//rgba(0, 85, 44, 1)

#define APP_TextLightColor                  rgba(170, 170, 170, 1)
#define APP_TextDarkColor                   rgba(51, 51, 51, 1)
#define APP_MAIN_COLOR  UIColorFromRGB(0x216E3E)

#define APP_BLACK_COLOR UIColorFromRGB(0x868686)

#pragma mark CELL Edges
#define CELL_TOP_PADDING 16
#define CELL_BOTTOM_PADDING 16
#define CELL_LEFT_PADDING 16
#define CELL_RIGHT_PADDING 16
#pragma mark Image
#define AssetImage(path)                (path).length > 0 ? [UIImage imageNamed:(path)] : nil
#define FLDicWithOAndK(firstObject, ...) [NSDictionary dictionaryWithObjectsAndKeys:firstObject, ##__VA_ARGS__, nil]












//------------------------------------------------------------
// 单例
#define DEFINE_SINGLETON_FOR_CLASS(className) \
\
+ (className *)shareInstance;

#define IMPLEMENTE_SINGLETON_FOR_CLASS(className) \
\
+ (className *)shareInstance { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[[self class] alloc] init]; \
}); \
return shared##className; \
}


#define rcd_dispatch_main_async_safe(block)                                                                            \
    if ([NSThread isMainThread]) {                                                                                     \
        block();                                                                                                       \
    } else {                                                                                                           \
        dispatch_async(dispatch_get_main_queue(), block);                                                              \
    }
#endif

#ifdef DEBUG

//#define NSLog(...) NSLog(__VA_ARGS__)
//
#define debugMethod() NSLog(@"%s", __func__)

#else

#define NSLog(...)

#define debugMethod()

#endif /* TransnCommonDefine_h */
