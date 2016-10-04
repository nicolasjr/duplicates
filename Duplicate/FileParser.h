#import <Foundation/Foundation.h>

@interface FileParser : NSObject

+ (NSArray*)readFilesLine:(NSString*)filePath;

@end
