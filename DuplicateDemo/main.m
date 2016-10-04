#import <Foundation/Foundation.h>
#import "Duplicate.h"
#import "FileParser.h"

int main(int argc, const char * argv[])
{
    @autoreleasepool
    {
        // since it's a command line project, the path for the file must be absolute.
        NSString* path = @"/Volumes/Duplicate/DuplicateTests/input.txt";

        Duplicate* duplicate = [[Duplicate alloc] init];
        
        NSArray* sets = [FileParser readFilesLine:path];
        for (NSString* s in sets)
        {
            [duplicate insertSetOfValue:s];
        }
        
        NSLog(@"---- Report ----\n\n");
        NSLog(@"%@", [duplicate reportMostFrequentDuplicates]);
        NSLog(@"\n\n%@", [duplicate reportInvalidInputs]);
        NSLog(@"\n\n%@", [duplicate reportAmountOfDuplicatesAndNonDuplicates]);
    }
    
    return 0;
}
