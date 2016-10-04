#import "SetEntry.h"

@implementation SetEntry

-(id)init:(NSArray*)arrayOfIntegers :(BOOL)isDuplicate
{
    if (self == [super init])
    {
        _arrayOfIntegers = arrayOfIntegers;
        _isDuplicate = isDuplicate;
    }
    return self;
}

@end
