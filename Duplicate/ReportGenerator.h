#import <Foundation/Foundation.h>

@interface ReportGenerator : NSObject

+ (NSString*)reportAmountOfDuplicatesAndNonDuplicates: (NSInteger)totalDuplicates :(NSInteger)totalNonDuplicates;
+ (NSString*)reportInvalidInputs: (NSArray*)invalidEntries;
+ (NSString*)reportMostFrequentDuplicates: (NSArray*)mostFrequentDuplicates;

@end
