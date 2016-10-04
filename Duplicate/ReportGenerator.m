#import "ReportGenerator.h"

@implementation ReportGenerator

+ (NSString*)reportAmountOfDuplicatesAndNonDuplicates: (NSInteger)totalDuplicates :(NSInteger)totalNonDuplicates
{
    NSString* report = [NSString stringWithFormat:@"Total Duplicates: %ld", totalDuplicates];
    report = [NSString stringWithFormat:@"%@\nTotal Non-Duplicates: %ld", report, totalNonDuplicates];
    
    return report;
}

+ (NSString*)reportInvalidInputs: (NSArray*)invalidEntries
{
    NSString* report = [NSString stringWithFormat:@"\nTotal Invalid: %ld", [invalidEntries count]];
    report = [NSString stringWithFormat:@"%@\n\nThe Invalid Entries are:", report];
    
    for (NSString* s in invalidEntries)
        report = [NSString stringWithFormat:@"%@\n%@", report, s];
    
    return report;
}

+ (NSString*)reportMostFrequentDuplicates: (NSArray*)mostFrequentDuplicates
{
    NSString* report = @"The most common duplicate is:";
    
    for (NSArray* a in mostFrequentDuplicates)
    {
        NSString* entriesString = @"";
        
        for (NSNumber* n in a)
            entriesString = [NSString stringWithFormat:@"%@%i, ", entriesString, n.intValue];
        
        entriesString = [entriesString substringWithRange:NSMakeRange(0, entriesString.length - 2)];
        report = [NSString stringWithFormat:@"%@\n%@", report, entriesString];
    }
    
    report = [NSString stringWithFormat:@"%@\n\nIt appears %ld times", report, mostFrequentDuplicates.count];
    
    return report;
}

@end
