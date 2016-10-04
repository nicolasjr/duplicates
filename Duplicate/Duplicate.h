#import <Foundation/Foundation.h>
#import "Exceptions.h"
#import "ReportGenerator.h"
#import "SetEntry.h"

@interface Duplicate : NSObject

- (BOOL)insertSetOfValue:(NSString*)value;
- (BOOL)arraysAreEqual:(NSArray*)array :(NSArray*)other;

- (NSNumber*)convertStringToNumber:(NSString*)string;
- (NSArray*)splitStringInIntegers:(NSString*)value;

- (NSInteger)totalDuplicates;
- (NSInteger)totalNonDuplicates;
- (NSInteger)totalInvalids;

- (NSString*)reportAmountOfDuplicatesAndNonDuplicates;
- (NSString*)reportInvalidInputs;
- (NSString*)reportMostFrequentDuplicates;

@end
