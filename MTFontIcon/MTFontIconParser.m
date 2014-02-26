//
//  MTFontIconParser.m
//  
//
//  Created by Gio on 14/08/2013.
//
//

#import "MTFontIconParser.h"
#import "MTFontIconModel.h"

NSString *MTFontIconIconsKey = @"font-icons";

NSString *MTFontIconParserFontKey = @"font-name";
NSString *MTFontIconIconNameKey = @"icon-name";
NSString *MTFontIconIconCodeKey = @"icon-code";
NSString *MTFontIconBaselineAdjustementKey = @"baseline-adjustement";
NSString *MTFontIconScaleAdjustementKey = @"scale-adjustement";

static NSString *kFileName = @"MTFontIcon";
static NSString *kFileExtension = @"plist";

@implementation MTFontIconParser

+ (NSDictionary *)parseFontIcons
{
    return [self parseFontIconsFromArray:[self settingsArrayFromDefaultFile]];
}

+ (NSDictionary *)parseFontIconsFromArray:(NSArray *)array
{
    NSMutableDictionary *iconsDict = [[NSMutableDictionary alloc] init];
    [array enumerateObjectsUsingBlock:^(NSDictionary *dataDict, NSUInteger idx, BOOL *stop) {
        MTFontIconModel *model = [[MTFontIconModel alloc] init];
        NSString *name = dataDict[MTFontIconIconNameKey];
        model.name = name;
        model.code = dataDict[MTFontIconIconCodeKey];
        model.fontName = dataDict[MTFontIconParserFontKey];
        if (dataDict[MTFontIconBaselineAdjustementKey]) {
            model.baselineAdjustement = [dataDict[MTFontIconBaselineAdjustementKey] floatValue];
        }
        if (dataDict[MTFontIconScaleAdjustementKey]) {
            model.scaleAdjustement = [dataDict[MTFontIconScaleAdjustementKey] floatValue];
        }
        iconsDict[name] = model;
    }];
    return [NSDictionary dictionaryWithDictionary:iconsDict];
}

+ (NSArray *)settingsArrayFromDefaultFile
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:kFileName ofType:kFileExtension];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSDictionary *settingsDict = [NSDictionary dictionaryWithContentsOfFile:filePath];
        return settingsDict[MTFontIconIconsKey];
    } else {
        // Throw an exception?
        return nil;
    }
}

@end
