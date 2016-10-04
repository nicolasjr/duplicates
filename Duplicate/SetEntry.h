#import <Foundation/Foundation.h>

@interface SetEntry : NSObject

- (id)init:(NSArray*)arrayOfIntegers :(BOOL)isDuplicate;

@property NSArray* arrayOfIntegers;
@property BOOL isDuplicate;

@end
