//
//  NSString+TRExtension.h
//  CallTaxi
//
//  Created by Fan Lv on 13-2-11.
//  Copyright (c) 2013年 OTech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (TRExtension)

- (NSData*) hexToBytes;

- (NSString *) stringByPaddingTheLeftToLength:(NSUInteger) newLength withString:(NSString *) padString startingAtIndex:(NSUInteger) padIndex;



//举例子此方法只对 "aa11字字aa22字字" 修改aa和22的字体为font1  颜色为color1，这种需求有用
/**
 *   修改字符串中的数字的颜色和字体大小
 *
 *  @param string         整个字符串
 *  @param color          原始字符串的颜色
 *  @param font           原始字符串的字体
 *  @param changecolor    要修改的数字的颜色
 *  @param changefont     要修改的数字的字体大小
 *
 *  @return 一个带有属性的字符串
 */
+(NSMutableAttributedString *)addAttributeString:(NSString *)string color:(UIColor *)color font:(UIFont *)font changeString:(NSArray *)changeStrings changeColor:(UIColor *)changecolor changgefont:(UIFont *)changefont;


//举例子 此方法只对 "aa11字字bb22..."  修改"aa"、"11"、"字字"的 字体分别为 font1 font2 font3  颜色为 color1 color2 color3，这种需求有用
//不支持举例 此方法只对 aa11aa字字  修改"aa"、"11"、"字字"的 字体分别为 font1 font2 font3  颜色为 color1 color2 color3，这种需求，第2个"aa"为无效
+(NSMutableAttributedString *)addAttributeString:(NSString *)string color:(UIColor *)color font:(UIFont *)font changeString:(NSArray *)changeStrings changeColors:(NSArray *)changecolors changgefonts:(NSArray *)changefonts;

- (CGSize)sizeWithFont:(UIFont*)font maxWidth:(CGFloat)width maxNumberLines:(int)num;
//字节数
-(int)calcStrCharsCount;

///字数统计
-(int)calcStrWordCount;

+ (NSString *)displayTimeStringFromSeconds:(NSTimeInterval)seconds;
-(BOOL) isEmpty;
-(NSString *)trimValue;

-(BOOL)isValidEmail;
-(BOOL)isValidQQ;
-(BOOL)isValidPhoneNum;
-(BOOL)isValidIDCard;
- (NSString *)encrypt32MD5;
- (NSString*)HloveyRC4:(NSString*)aInput key:(NSString*)aKey;
+ (NSString*)URLencode:(NSString *)originalString
        stringEncoding:(NSStringEncoding)stringEncoding;

-(NSString *)distinguishStr;

- (NSTextCheckingResult *)tr_firstMatch:(NSString *)word;
// 字符串转码
- (NSString*)urlEncodeString;

// 反URL编码
- (NSString *)decodeFromPercentEscapeString;

-(NSString *)moneyValue;

- (NSString *)md5Value;

-(NSArray <NSTextCheckingResult *> *)getSentences:(NSString *)sentences;

@end
