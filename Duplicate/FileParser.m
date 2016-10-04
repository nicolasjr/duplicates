#import "FileParser.h"

@implementation FileParser

+ (NSArray*)readFilesLine:(NSString*)filePath
{
    NSError* error;
    NSString* fileContent = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    
    NSString* fileContentWithNoEmptyLine = [self stringByRemovingBlankLines:fileContent];
    
    NSArray* sets = [fileContentWithNoEmptyLine componentsSeparatedByString:@"\n"];
    
    return sets;
}

+ (NSString*)stringByRemovingBlankLines:(NSString*)s;
{
    NSScanner *scan = [NSScanner scannerWithString:s];
    NSMutableString *string = NSMutableString.new;
    while (!scan.isAtEnd) {
        [scan scanCharactersFromSet:NSCharacterSet.newlineCharacterSet intoString:NULL];
        NSString *line = nil;
        [scan scanUpToCharactersFromSet:NSCharacterSet.newlineCharacterSet intoString:&line];
        if (line) [string appendFormat:@"%@\n",line];
    }
    if (string.length) [string deleteCharactersInRange:(NSRange){string.length-1,1}];
    return string;
}

@end
