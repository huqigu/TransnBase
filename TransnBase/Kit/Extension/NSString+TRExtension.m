//
//  NSString+TRExtension.m
//  CallTaxi
//
//  Created by Fan Lv on 13-2-11.
//  Copyright (c) 2013年 OTech. All rights reserved.
//

#import "NSString+TRExtension.h"
#import <CommonCrypto/CommonDigest.h>


@implementation NSString (TRExtension)

-(NSData*) hexToBytes
{
    NSMutableData* data = [NSMutableData data];
    int idx;
    for (idx = 0; idx+2 <= self.length; idx+=2)
    {
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [self substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    return data;
}

- (NSString *) stringByPaddingTheLeftToLength:(NSUInteger) newLength withString:(NSString *) padString startingAtIndex:(NSUInteger) padIndex
{
    if ([self length] <= newLength)
        return [[@"" stringByPaddingToLength:newLength - [self length] withString:padString startingAtIndex:padIndex] stringByAppendingString:self];
    else
        return [self copy] ;
}

+(NSMutableAttributedString *)addAttributeString:(NSString *)string color:(UIColor *)color font:(UIFont *)font changeString:(NSArray *)changeStrings changeColor:(UIColor *)changecolor changgefont:(UIFont *)changefont{
    if(string == nil){
        string = @"";
    }
    //初始化NSRegularExpression
    NSString *match = [NSString stringWithFormat:@"%@",[changeStrings componentsJoinedByString:@"|"]];
    
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:match options:NSRegularExpressionIgnoreMetacharacters  error:nil];
    NSMutableAttributedString *attributeString=[[NSMutableAttributedString alloc]initWithString:string];
    
    [attributeString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, string.length)];
    if (font) {
        [attributeString addAttribute:NSFontAttributeName value:font   range:NSMakeRange(0, string.length)];
    }
    [regularExpression enumerateMatchesInString:string options:0 range:NSMakeRange(0, string.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        for(int i=0;i<changeStrings.count;i++){
            NSRange range= result.range;
            [attributeString addAttribute:NSForegroundColorAttributeName value:changecolor range:range];
            if (changefont) {
                [attributeString addAttribute:NSFontAttributeName value:changefont  range:range];
            }
            if (changecolor) {
                [attributeString addAttribute:NSForegroundColorAttributeName value:changecolor range:range];
            }
        }
    }];
    return attributeString;
}

+(NSMutableAttributedString *)addAttributeString:(NSString *)string color:(UIColor *)color font:(UIFont *)font changeString:(NSArray *)changeStrings changeColors:(NSArray *)changecolors changgefonts:(NSArray *)changefonts{
    
    NSMutableAttributedString *attributeString=[[NSMutableAttributedString alloc]initWithString:string];
    [attributeString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, string.length)];
    [attributeString addAttribute:NSFontAttributeName value:font   range:NSMakeRange(0, string.length)];
    
    for(int i=0;i<changeStrings.count;i++){
        NSRange range= [string rangeOfString:changeStrings[i]];
        if (changecolors.count>i) {
            [attributeString addAttribute:NSForegroundColorAttributeName value:changecolors[i] range:range];
        }
        [attributeString addAttribute:NSFontAttributeName value:changefonts[i]  range:range];
    }
    return attributeString;
}

- (CGSize)sizeWithFont:(UIFont *)font maxWidth:(CGFloat)width maxNumberLines:(int)num {
    CGSize size = CGSizeZero;
    if (num > 0) {
        CGFloat tmpHeight = ceilf(font.lineHeight * num);
        // 多行必需使用NSStringDrawingUsesLineFragmentOrigin，网上有人说不是用NSStringDrawingUsesFontLeading计算结果不对
        NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin |
        NSStringDrawingUsesFontLeading;
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineBreakMode:NSLineBreakByCharWrapping];
        
        NSDictionary *attributes = @{ NSFontAttributeName : font, NSParagraphStyleAttributeName : style };
        CGSize maxSize = CGSizeMake(width, tmpHeight);
        CGRect rect = [self boundingRectWithSize:maxSize
                                         options:opts
                                      attributes:attributes
                                         context:nil];
        return rect.size;
    } else if (num == 0) {
        size = [self sizeWithFont:font maxWidth:width maxNumberLines:-10];
    } else if (num < 0) {
        num = num*-1;
        int i = 1;
        CGFloat h1, h2;
        do {
            size = [self sizeWithFont:font maxWidth:width maxNumberLines:num*i];
            h1 = size.height;
            h2 = ceilf(font.lineHeight*num*i++);
        } while (h1 >= h2);
    }
    size.width = ceilf(size.width);
    size.height = ceilf(size.height);
    return size;
}
//字节数
-(int)calcStrCharsCount{
    int nResult = 0;
    char *pchSource = (char *)[self cStringUsingEncoding:NSUTF8StringEncoding];
    int sourcelen = (int)strlen(pchSource);
    int nCurNum = 0;		// 当前已经统计的字数
    for (int n = 0; n < sourcelen; ) {
        if( *pchSource & 0x80 ) {
            pchSource += 3;		// NSUTF8StringEncoding编码汉字占３字节
            n += 3;
            nCurNum += 2;
        }
        else {
            pchSource++;
            n += 1;
            nCurNum += 1;
        }
    }
    // 字数统计规则，不足一个字(比如一个英文字符)，按一个字算
    nResult = nCurNum;
    return nResult;
}
///字数统计
-(int)calcStrWordCount{
    int nResult = 0;
    char *pchSource = (char *)[self cStringUsingEncoding:NSUTF8StringEncoding];
    int sourcelen = (int)strlen(pchSource);
    int nCurNum = 0;		// 当前已经统计的字数
    for (int n = 0; n < sourcelen; ) {
        if( *pchSource & 0x80 ) {
            pchSource += 3;		// NSUTF8StringEncoding编码汉字占３字节
            n += 3;
            nCurNum += 2;
        }
        else {
            pchSource++;
            n += 1;
            nCurNum += 1;
        }
    }
    // 字数统计规则，不足一个字(比如一个英文字符)，按一个字算
    nResult = nCurNum / 2 + nCurNum % 2;
    return nResult;
}

-(BOOL) isEmpty {
    if (!self) {
        return YES;
    } else {
        //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and nextline characters (U+000A–U+000D, U+0085).
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
        NSString *trimedString = [self stringByTrimmingCharactersInSet:set];
        
        if ([trimedString length] == 0) {
            return YES;
        } else {
            return NO;
        }
    }
}
+ (NSString *)displayTimeStringFromSeconds:(NSTimeInterval)seconds
{
    int totalSeconds = (int)ceil(seconds);
    int secondsComponent = totalSeconds % 60;
    int minutesComponent = (totalSeconds / 60) % 60;
    int hoursComponent =(totalSeconds / 60 / 60) % 60;
    if (seconds<60*60) {
        return [NSString stringWithFormat:@"%02d:%02d", minutesComponent, secondsComponent];
    }else{
        return [NSString stringWithFormat:@"%02d:%02d:%02d",hoursComponent, minutesComponent, secondsComponent];
    }
}


-(BOOL)isValidEmail{
    if (!self.length) {
        return false;
    }
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailPredicate evaluateWithObject:self];
}
-(BOOL)isValidQQ{
    if (self.length == 0) {
        return NO;
    }
    NSString *qqRegex = @"[1-9][0-9]{4,11}";
    NSPredicate *qqPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", qqRegex];
    return [qqPredicate evaluateWithObject:self];
}
-(BOOL)isValidPhoneNum{
    if (self.length == 0) {
        return NO;
    }
    NSString *phoneRegex = @"^1+\\d{10}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    if ([phoneTest evaluateWithObject:self]) {
        return YES;
    }
    return NO;
}
-(BOOL)isValidIDCard{
    //长度不为18的都排除掉
       if (self.length != 18) {
           return NO;
       }
       
       //校验格式
       NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
       NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
       BOOL flag = [identityCardPredicate evaluateWithObject:self];
       
       if (!flag) {
           return flag;    //格式错误
       }else {
           //格式正确在判断是否合法
           
           //将前17位加权因子保存在数组里
           NSArray * idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
           
           //这是除以11后，可能产生的11位余数、验证码，也保存成数组
           NSArray * idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
           
           //用来保存前17位各自乖以加权因子后的总和
           NSInteger idCardWiSum = 0;
           for(int i = 0;i < 17;i++)
           {
               NSInteger subStrIndex = [[self substringWithRange:NSMakeRange(i, 1)] integerValue];
               NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
               
               idCardWiSum+= subStrIndex * idCardWiIndex;
               
           }
           
           //计算出校验码所在数组的位置
           NSInteger idCardMod=idCardWiSum%11;
           
           //得到最后一位身份证号码
           NSString * idCardLast= [self substringWithRange:NSMakeRange(17, 1)];
           
           //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
           if(idCardMod==2)
           {
               if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"])
               {
                   return YES;
               }else
               {
                   return NO;
               }
           }else{
               //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
               if([idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]])
               {
                   return YES;
               }
               else
               {
                   return NO;
               }
           }
       }
}
- (NSString *) encrypt32MD5 {
    const char *cStr = [self UTF8String];
    unsigned char result[32];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    return [[NSString stringWithFormat:
             @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

- (NSString*)HloveyRC4:(NSString*)aInput key:(NSString*)aKey
{
    
    NSMutableArray *iS = [[NSMutableArray alloc] initWithCapacity:256];
    NSMutableArray *iK = [[NSMutableArray alloc] initWithCapacity:256];
    
    for (int i= 0; i<256; i++) {
        [iS addObject:[NSNumber numberWithInt:i]];
    }
    
    int j=1;
    
    for (short i=0; i<256; i++) {
        
        UniChar c = [aKey characterAtIndex:i%aKey.length];
        
        [iK addObject:[NSNumber numberWithChar:c]];
    }
    
    j=0;
    
    for (int i=0; i<255; i++) {
        int is = [[iS objectAtIndex:i] intValue];
        UniChar ik = (UniChar)[[iK objectAtIndex:i] charValue];
        
        j = (j + is + ik)%256;
        NSNumber *temp = [iS objectAtIndex:i];
        [iS replaceObjectAtIndex:i withObject:[iS objectAtIndex:j]];
        [iS replaceObjectAtIndex:j withObject:temp];
        
    }
    
    int i=0;
    j=0;
    
    NSString *result = aInput;
    
    for (short x=0; x<[aInput length]; x++) {
        i = (i+1)%256;
        
        int is = [[iS objectAtIndex:i] intValue];
        j = (j+is)%256;
        
        int is_i = [[iS objectAtIndex:i] intValue];
        int is_j = [[iS objectAtIndex:j] intValue];
        
        int t = (is_i+is_j) % 256;
        int iY = [[iS objectAtIndex:t] intValue];
        
        UniChar ch = (UniChar)[aInput characterAtIndex:x];
        UniChar ch_y = ch^iY;
        
        result = [result stringByReplacingCharactersInRange:NSMakeRange(x, 1) withString:[NSString stringWithCharacters:&ch_y length:1]];
    }
    
    
    
    return result;
}

+ (NSString*)URLencode:(NSString *)originalString
        stringEncoding:(NSStringEncoding)stringEncoding {
    
    NSArray *escapeChars = [NSArray arrayWithObjects:@";" , @"/" , @"?" , @":" ,
                            @"@" , @"&" , @"=" , @"+" ,    @"$" , @"," ,
                            @"!", @"'", @"(", @")", @"*", nil];
    
    NSArray *replaceChars = [NSArray arrayWithObjects:@"%3B" , @"%2F", @"%3F" , @"%3A" ,
                             @"%40" , @"%26" , @"%3D" , @"%2B" , @"%24" , @"%2C" ,
                             @"%21", @"%27", @"%28", @"%29", @"%2A", nil];
    
    NSInteger len = [escapeChars count];
    
    NSMutableString *temp = [[originalString
                              stringByAddingPercentEscapesUsingEncoding:stringEncoding]
                             mutableCopy];
    
    int i;
    for (i = 0; i < len; i++) {
        
        [temp replaceOccurrencesOfString:[escapeChars objectAtIndex:i]
                              withString:[replaceChars objectAtIndex:i]
                                 options:NSLiteralSearch
                                   range:NSMakeRange(0, [temp length])];
    }
    
    NSString *outStr = [NSString stringWithString: temp];
    
    return outStr;
}
// 字符串编码
- (NSString *)urlEncodeString
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, CFSTR(":/?#[]@!$&’(){}<>*+,;="),kCFStringEncodingUTF8));
    return result;
}

// 反URL编码
- (NSString *)decodeFromPercentEscapeString
{
    NSMutableString *outputStr = [NSMutableString stringWithString:self];
    [outputStr replaceOccurrencesOfString:@"+"
                               withString:@" "
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0, [outputStr length])];
    
    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

-(NSString *)distinguishStr{
    if (!self) {
        return self;
    }
    NSArray<NSTextCheckingResult *> *urlMatches = [self getURLStrings];
    return [[self distinguishwords:urlMatches] distinguishMobileNum:urlMatches];
}

 - (NSTextCheckingResult *)tr_firstMatch:(NSString *)word{
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:word options:NSRegularExpressionCaseInsensitive error:&error];
    if (error) {
        return nil;
    }else{
        return [regex firstMatchInString:self options:0 range:NSMakeRange(0, [self length])];
    }
}
-(NSArray <NSTextCheckingResult *> *)getChars{
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[a-zA-Z0-9_]{5,19}"
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    if (error) {
        return nil;
    }else{
        return [regex matchesInString:self
                              options:0
                                range:NSMakeRange(0, [self length])];
    }
}
- (NSTextCheckingResult *)firstMatchChar{
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[a-zA-Z0-9_]{5,19}"
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    if (error) {
        return nil;
    }else{
        return [regex firstMatchInString:self options:0 range:NSMakeRange(0, [self length])];
    }
}

-(NSArray <NSTextCheckingResult *> *)getQQNumber{
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[1-9][0-9]{4,11}"
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    if (error) {
        return nil;
    }else{
        return [regex matchesInString:self
                              options:0
                                range:NSMakeRange(0, [self length])];
    }
}
- (NSTextCheckingResult *)firstMatchQQNumber{
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[1-9][0-9]{4,11}"
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    if (error) {
        return nil;
    }else{
        return [regex firstMatchInString:self options:0 range:NSMakeRange(0, [self length])];
    }
}


- (NSArray<NSTextCheckingResult *> *)getURLStrings{
    NSError *error;
    //可以识别url的正则表达式
    NSString *regulaStr = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    if (error) {
        return nil;
    }else{
        return [regex matchesInString:self
                              options:0
                                range:NSMakeRange(0, [self length])];
    }
}
- (NSArray<NSTextCheckingResult *> *)getPhoneNums {
    NSError *error;
    //可以识别url的正则表达式
    NSString *regulaStr = @"\\d{3,4}[- ]?\\d{7,8}";

    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    if (error) {
        return nil;
    }else{
        return [regex matchesInString:self
                              options:0
                                range:NSMakeRange(0, [self length])];
    }
}


- (NSArray<NSTextCheckingResult *> *)getMobileNums {
    NSError *error;
    //可以识别url的正则表达式
    NSString *regulaStr = @"^1+\\d{10}$";
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    if (error) {
        return nil;
    }else{
        return [regex matchesInString:self
                              options:0
                                range:NSMakeRange(0, [self length])];
    }
}


-(NSString *)distinguishwords:(NSArray <NSTextCheckingResult *>*)urlMatches{
    //qq、QQ用qq都可以匹配出来
    NSArray *fitterwords = @[@"微信",@"qq"];
    NSString *content = self;
    for (int i=0; i<fitterwords.count; i++) {
        NSString *word = fitterwords[i];
        content = [content distinguishword:word urlMatches:urlMatches];
    }
    return content;
}
-(NSString *)distinguishword:(NSString *)word urlMatches:(NSArray <NSTextCheckingResult *> *)urlMatches{
    if (!self) {
        return self;
    }
    //找到了敏感词
    NSTextCheckingResult *result = [self tr_firstMatch:word];
    if (!result) {
        return self;
    }
    NSString *content = self;
    //前面的
    NSString *prefixStr = [content substringToIndex:result.range.location];
    NSString *suffixStr = [content substringFromIndex:result.range.location+result.range.length];
    NSRange range1 = NSMakeRange(0, 0);
    NSRange range2 = NSMakeRange(0, 0);
    if (prefixStr) {
        NSArray<NSTextCheckingResult *> *matches1 = [word.lowercaseString isEqualToString:@"qq"]?[prefixStr getQQNumber]:[prefixStr getChars];
        if (matches1.count) {
            NSTextCheckingResult *result = matches1.lastObject;
            range1 = result.range;
        }
    }
    //后面的
    if (suffixStr) {
        NSTextCheckingResult *result =  [word.lowercaseString isEqualToString:@"qq"]?[suffixStr firstMatchQQNumber]:[suffixStr firstMatchChar];
        if (result) {
            range2 = result.range;
        }
    }
    NSRange replaceRange1 = NSMakeRange(0, 0);
    NSRange replaceRange2 = NSMakeRange(0, 0);
    
    Boolean isRet = [self isAvailableRange:range1 URLMatchs:urlMatches];
    if (range1.length>range2.length && isRet) {
        replaceRange1 = range1;
    }else if(range1.length == range2.length && range1.length != 0){
        replaceRange1 = range1;
        replaceRange2.location = prefixStr.length+word.length+range2.location;
        replaceRange2.length = range2.length;
    }else{
        if (range2.length != 0) {
            replaceRange2.location = prefixStr.length+word.length+range2.location;
            replaceRange2.length = range2.length;
        }
    }
    NSString *continueString = nil;
    if (isRet) {
        content = [content stringByReplacingCharactersInRange:replaceRange1 withString:[self getReplaceLengthWord:replaceRange1.length]];
    }
    
    Boolean isRet2 = [self isAvailableRange:replaceRange2 URLMatchs:urlMatches];
    if (isRet2) {
        content = [content stringByReplacingCharactersInRange:replaceRange2 withString:[self getReplaceLengthWord:replaceRange2.length]];
        continueString = [content substringFromIndex:replaceRange2.location+replaceRange2.length];
        NSRange continueRanage = NSMakeRange(replaceRange2.location+replaceRange2.length, continueString.length);
        //判断后面的字符串中有没有敏感词
        continueString = [continueString distinguishword:word urlMatches:urlMatches];
        content = [content stringByReplacingCharactersInRange:continueRanage withString:continueString];
    }
    return content;
}

//不在链接中的手机号是真实的手机号
-(Boolean)isAvailableRange:(NSRange )range URLMatchs:(NSArray <NSTextCheckingResult *> *)urlMatches{
    if (range.length == 0) {
        return false;
    }
    for (int i = 0; i< urlMatches.count; i++) {
        NSTextCheckingResult *urlResult = urlMatches[i];
        NSRange urlRange = urlResult.range;
        //首或则尾在里面都不行
        if (NSLocationInRange(range.location, urlRange)||NSLocationInRange(range.location+range.length, urlRange)) {
            return false;
        }
      
    }
    return true;
}
//座机号
-(NSString *)distinguishPhoneNum:(NSArray <NSTextCheckingResult *> *)urlMatches{
    if (!self) {
        return self;
    }
    //获取字符串中的电话号码
    NSArray<NSTextCheckingResult *> *phoneMatches = [self getPhoneNums];
    NSString *content = self;
    for (int i= 0 ; i<phoneMatches.count; i++) {
        NSTextCheckingResult *phoneMatche = phoneMatches[i];
        Boolean isRet = [self isAvailableRange:phoneMatche.range URLMatchs:urlMatches];
        if (isRet) {
            content  = [content stringByReplacingCharactersInRange:phoneMatche.range withString:@"***********"];
        }
    }
    return content;
}

//手机号
-(NSString *)distinguishMobileNum:(NSArray <NSTextCheckingResult *> *)urlMatches{
    if (!self) {
        return self;
    }
    //获取字符串中的电话号码
    NSArray<NSTextCheckingResult *> *phoneMatches = [self getMobileNums];
    NSString *content = self;
    for (int i= 0 ; i<phoneMatches.count; i++) {
        NSTextCheckingResult *phoneMatche = phoneMatches[i];
        Boolean isRet = [self isAvailableRange:phoneMatche.range URLMatchs:urlMatches];
        if (isRet) {
            content  = [content stringByReplacingCharactersInRange:phoneMatche.range withString:@"***********"];
        }
    }
    return content;
}

-(NSString *)getReplaceLengthWord:(NSInteger )length{
    //    return @"*****";
    NSMutableString *placeStr = [[NSMutableString alloc] init];
    for (int i=0; i<length; i++) {
        [placeStr appendString:@"*"];
    }
    return placeStr;
}

-(NSString *)trimValue{
    if (!self) {
        return self;
    } else {
        //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and nextline characters (U+000A–U+000D, U+0085).
        NSMutableCharacterSet *set = [NSMutableCharacterSet whitespaceAndNewlineCharacterSet];
         //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
        [set addCharactersInString:@"\r\n"];
        NSString *trimedString = [self stringByTrimmingCharactersInSet:set];
        trimedString = [trimedString stringByReplacingOccurrencesOfString:@" " withString:@""];
        return trimedString;
    }
}
-(NSString *)moneyValue{
    NSDecimalNumber *decNumber    = [NSDecimalNumber decimalNumberWithString:self];
    NSNumberFormatter  *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"##.##"];///也可##.##元，对价钱的处理
    return  [numberFormatter stringFromNumber:decNumber];
}

- (NSString *)md5Value{
    const char *str = [self UTF8String];
    if (str == NULL) {
        str = "";
    }
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *value = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                          r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10],
                          r[11], r[12], r[13], r[14], r[15]];
    return [value lowercaseString];
}
-(NSArray <NSTextCheckingResult *> *)getSentences:(NSString *)sentences{
    NSError *error;
    //可以识别sentences的正则表达式
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:sentences
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    if (error) {
        return nil;
    }else{
        return [regex matchesInString:self
                              options:0
                                range:NSMakeRange(0, [self length])];
    }
}


@end
