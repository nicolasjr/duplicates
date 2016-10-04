#import "Duplicate.h"

@implementation Duplicate
{
    NSMutableArray* invalidEntries;
    NSMutableArray* entries;
    NSMutableDictionary* duplicateEntriesDictionary;
}

- (id)init
{
    if ([super init] == self)
    {
        invalidEntries = [[NSMutableArray alloc] init];
        entries = [[NSMutableArray alloc] init];
        duplicateEntriesDictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (BOOL)insertSetOfValue:(NSString*)values
{
    NSArray* setOfValuesArray = nil;
    
    @try
    {
        setOfValuesArray = [self splitStringInIntegers:values];
    }
    @catch (NSException *exception)
    {
        [invalidEntries addObject:values];
        return false;
    }
    
    BOOL isDuplicate = [self alreadyExistingSet: setOfValuesArray];
    
    [entries addObject:[[SetEntry alloc] init:setOfValuesArray :isDuplicate]];
    
    return isDuplicate;
}

- (NSArray*)splitStringInIntegers:(NSString*)value
{
    NSArray* items = [value componentsSeparatedByString:@","];
    
    NSMutableArray* values = [[NSMutableArray alloc] init];
    for(NSString* s in items)
    {
        NSString* sTrimmed = [s stringByTrimmingCharactersInSet:
                              [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSNumber* number = [self convertStringToNumber:sTrimmed];
        
        if (number.intValue == negativeInfinity)
            [NSException raise:WrongFormat format:WrongFormatMessage];
        
        [values addObject:number];
    }
    
    return values;
}

- (NSNumber*)convertStringToNumber:(NSString*)string
{
    int value = string.intValue;
    // This may seem a bit redundant, but since char's intValue is equal to 0, it's necessary to convert it back
    // to string, and compare it to the string received as parameter.
    NSString* stringWithValue = [NSString stringWithFormat:@"%i", value];
    
    if (stringWithValue.length != string.length || ![stringWithValue isEqualToString: string])
        return [NSNumber numberWithInt:negativeInfinity];
    
    return [NSNumber numberWithInt: value];
}

- (BOOL)alreadyExistingSet:(NSArray*)set
{
    for (SetEntry* entry in entries)
    {
        BOOL areEqual = [self arraysAreEqual:set :entry.arrayOfIntegers];
        
        if (areEqual)
        {
            if (!entry.isDuplicate)
            {
                [entry setIsDuplicate:YES];
                // create new entry on duplicateEntriesDictionary
                NSMutableArray *duplicateForEntry = [[NSMutableArray alloc] initWithObjects:entry.arrayOfIntegers, set, nil];
                [duplicateEntriesDictionary setObject:duplicateForEntry forKey:entry.arrayOfIntegers];
            }
            else
                [[duplicateEntriesDictionary objectForKey:entry.arrayOfIntegers] addObject:set];
            
            return true;
        }
    }
    return false;
}

- (BOOL)arraysAreEqual:(NSArray*)array :(NSArray*)other
{
    if (array.count != other.count)
        return false;
    
    if (![self arrayContainsAllObjectsOfArray:array :other])
        return false;
    
    return true;
}

- (BOOL)arrayContainsAllObjectsOfArray:(NSArray*)array :(NSArray*)other
{
    NSMutableArray* a = [NSMutableArray arrayWithArray:array];
    
    for (NSNumber* n in other)
    {
        if (![a containsObject:n])
            return false;
        // gets index of object because it's possible that the entry has more than one occurrence in the array,
        // therefore, using removeObject would remove all of those occurrences, breaking completely the logic.
        [a removeObjectAtIndex:[a indexOfObject:n]];
    }    
    return true;
}

- (NSArray*)getMostFrequentDuplicate
{
    NSInteger totalEntries = 0;
    NSArray* mostDuplicateSets;
    
    for (NSArray* key in duplicateEntriesDictionary)
    {
        NSArray* a = [duplicateEntriesDictionary objectForKey:key];
        
        if (a.count > totalEntries)
        {
            totalEntries = a.count;
            mostDuplicateSets = a;
        }
    }
    return mostDuplicateSets;
}

- (NSInteger)totalDuplicates
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"_isDuplicate == %@", [NSNumber numberWithBool: YES]];
    return [entries filteredArrayUsingPredicate:predicate].count;
}

- (NSInteger)totalNonDuplicates
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"_isDuplicate == %@", [NSNumber numberWithBool: NO]];
    return [entries filteredArrayUsingPredicate:predicate].count;
}

- (NSInteger)totalInvalids
{
    return invalidEntries.count;
}

- (NSString*)reportAmountOfDuplicatesAndNonDuplicates
{
    return [ReportGenerator reportAmountOfDuplicatesAndNonDuplicates:[self totalDuplicates] :[self totalNonDuplicates]];
}

- (NSString*)reportInvalidInputs
{
    return [ReportGenerator reportInvalidInputs:invalidEntries];
}

- (NSString*)reportMostFrequentDuplicates
{
    return [ReportGenerator reportMostFrequentDuplicates:[self getMostFrequentDuplicate]];
}

@end
