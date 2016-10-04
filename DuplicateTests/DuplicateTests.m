#import <XCTest/XCTest.h>
#import "Duplicate.h"
#import "FileParser.h"

@interface DuplicateTests : XCTestCase

@property Duplicate *duplicate;

@end

@implementation DuplicateTests

- (void)setUp {
    [super setUp];
    self.duplicate = [[Duplicate alloc] init];
}

- (void)tearDown {
    [super tearDown];
    self.duplicate = nil;
}

- (NSArray*)readFromInputFile
{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *path = [bundle pathForResource:@"input" ofType:@"txt"];
    
    return [FileParser readFilesLine:path];
}

#pragma mark convertStringToInteger

- (void)testConvertStringWithNoDivision
{
    NSString* value = @"1";
    
    NSNumber* result = [self.duplicate convertStringToNumber:value];
    
    XCTAssertTrue(result.intValue == 1);
}

- (void)testConvertStringToIntegerWithInvalidString
{
    NSString* value = @"1.2";
    
    NSNumber* result = [self.duplicate convertStringToNumber:value];
    
    XCTAssertTrue(result.intValue == negativeInfinity);
}

- (void)testConvertStringToIntegerWithCharsOnString
{
    NSString* value = @"A";
    
    NSNumber* result = [self.duplicate convertStringToNumber:value];
    
    XCTAssertTrue(result.intValue == negativeInfinity);
}

- (void)testConvertStringToIntegerWithSpecialCharsOnString
{
    NSString* value = @"%";
    
    NSNumber* result = [self.duplicate convertStringToNumber:value];
    
    XCTAssertTrue(result.intValue == negativeInfinity);
}

#pragma mark splitStringInIntegers

- (void)testSplitsValidStringWithTwoIntegers
{
    NSString* value = @"1, 2";
    
    NSArray* result = [self.duplicate splitStringInIntegers:value];
    
    XCTAssertTrue(result.count == 2);
}

- (void)testSplitsStringWithTwoIntegersAndExtraDivisionInTheEnd
{
    NSString* value = @"1, 2, ";
    
    XCTAssertThrows([self.duplicate splitStringInIntegers:value], @"");
}

- (void)testSplitsInvalidString
{
    NSString* value = @"1.2";
    
    XCTAssertThrows([self.duplicate splitStringInIntegers:value], @"");
}

- (void)testSplitsInvalidStringWithValidSeparation
{
    NSString* value = @"5, 1.2";
    
    XCTAssertThrows([self.duplicate splitStringInIntegers:value], @"");
}

- (void)testSplitsStringWithText
{
    NSString* value = @"This is a text";
    
    XCTAssertThrows([self.duplicate splitStringInIntegers:value], @"");
}

- (void)testSplitsInvalidStringWithChar
{
    NSString* value = @"1, A";
    
    XCTAssertThrows([self.duplicate splitStringInIntegers:value]);
}

- (void)testSplitsInvalidStringWithManyChars
{
    NSString* value = @"A, B, C";
    
    XCTAssertThrows([self.duplicate splitStringInIntegers:value]);
}

- (void)testSplitsInvalidStringWithOnlyComma
{
    NSString* value = @",,,";
    
    XCTAssertThrows([self.duplicate splitStringInIntegers:value]);
}

- (void)testSplitsInvalidStringWithSpecialChars
{
    NSString* value = @"#, %, ^";
    
    XCTAssertThrows([self.duplicate splitStringInIntegers:value]);
}

- (void)testSplitSingeNumber
{
    NSString* value = @"3";
    
    NSArray* result = [self.duplicate splitStringInIntegers:value];
    
    XCTAssertTrue(result.count == 1);
}

#pragma mark arraysAreEqual

- (void)testArraysAreEqualWhenTheyHaveDifferentSize
{
    NSString* value1 = @"1,2,3";
    NSArray* array1 = [self.duplicate splitStringInIntegers:value1];
    
    NSString* value2 = @"3";
    NSArray* array2 = [self.duplicate splitStringInIntegers:value2];
    
    XCTAssertFalse([self.duplicate arraysAreEqual:array1 :array2]);
}

- (void)testArraysAreEqualWhenTheyHaveDifferentContent
{
    NSString* value1 = @"1,2,3";
    NSArray* array1 = [self.duplicate splitStringInIntegers:value1];
    
    NSString* value2 = @"1,2,4";
    NSArray* array2 = [self.duplicate splitStringInIntegers:value2];
    
    XCTAssertFalse([self.duplicate arraysAreEqual:array1 :array2]);
}

- (void)testArraysAreEqualWhenTheyHaveSameContentInSameOrder
{
    NSString* value1 = @"1,2,3";
    NSArray* array1 = [self.duplicate splitStringInIntegers:value1];
    NSArray* array2 = [self.duplicate splitStringInIntegers:value1];
    
    XCTAssertTrue([self.duplicate arraysAreEqual:array1 :array2]);
}

- (void)testArraysAreEqualWhenTheyHaveSameContentInDifferentOrder
{
    NSString* value1 = @"1,2,3";
    NSArray* array1 = [self.duplicate splitStringInIntegers:value1];
    
    NSString* value2 = @"1,3,2";
    NSArray* array2 = [self.duplicate splitStringInIntegers:value2];
    
    XCTAssertTrue([self.duplicate arraysAreEqual:array1 :array2]);
}

- (void)testArraysAreEqualWhenTheyHaveRepeatedIntegers
{
    NSString* value1 = @"1,2,3,5,2";
    NSArray* array1 = [self.duplicate splitStringInIntegers:value1];
    
    NSString* value2 = @"1,3,2,2,5";
    NSArray* array2 = [self.duplicate splitStringInIntegers:value2];
    
    XCTAssertTrue([self.duplicate arraysAreEqual:array1 :array2]);
}

- (void)testArraysAreDifferentWhenTheyHaveRepeatedIntegersAndSameSize
{
    NSString* value1 = @"1,2,3,5,1";
    NSArray* array1 = [self.duplicate splitStringInIntegers:value1];
    
    NSString* value2 = @"1,3,2,2,5";
    NSArray* array2 = [self.duplicate splitStringInIntegers:value2];
    
    XCTAssertFalse([self.duplicate arraysAreEqual:array1 :array2]);
}

#pragma mark insertSetOfValue

- (void)testInsertingTwoDifferentSets
{
    NSString* value1 = @"1,2,3";
    NSString* value2 = @"1,4,7";
    
    [self.duplicate insertSetOfValue:value1];
    XCTAssertFalse([self.duplicate insertSetOfValue:value2]);
    XCTAssertTrue([self.duplicate totalNonDuplicates] == 2);
    XCTAssertTrue([self.duplicate totalDuplicates] == 0);
}

- (void)testInsertingTwoEqualSetsInSameOrder
{
    NSString* value1 = @"1,2,3";
    NSString* value2 = @"1,2,3";
    
    [self.duplicate insertSetOfValue:value1];
    XCTAssertTrue([self.duplicate insertSetOfValue:value2]);
    XCTAssertTrue([self.duplicate totalNonDuplicates] == 0);
    XCTAssertTrue([self.duplicate totalDuplicates] == 2);
}

- (void)testInsertingTwoEqualSetsInDifferentOrder
{
    NSString* value1 = @"1,2,3";
    NSString* value2 = @"1,3,2";
    
    [self.duplicate insertSetOfValue:value1];
    XCTAssertTrue([self.duplicate insertSetOfValue:value2]);
    XCTAssertTrue([self.duplicate totalNonDuplicates] == 0);
    XCTAssertTrue([self.duplicate totalDuplicates] == 2);
}

#pragma mark readFromInputFile

- (void)testVerifyNonDuplicatesFromInputFile
{
    NSArray* sets = [self readFromInputFile];
    
    for (NSString* s in sets)
    {
        [self.duplicate insertSetOfValue:s];
    }
    
    XCTAssertTrue([self.duplicate totalNonDuplicates] == 1);
}

- (void)testVerifyDuplicatesFromInputFile
{
    NSArray* sets = [self readFromInputFile];
    
    for (NSString* s in sets)
    {
        [self.duplicate insertSetOfValue:s];
    }
    
    XCTAssertTrue([self.duplicate totalDuplicates] == 500);
}

- (void)testVerifyInvalidsFromInputFile
{
    NSArray* sets = [self readFromInputFile];
    
    for (NSString* s in sets)
    {
        [self.duplicate insertSetOfValue:s];
    }
    
    XCTAssertTrue([self.duplicate totalInvalids] == 6);
}

@end
