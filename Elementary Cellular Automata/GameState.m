//
//  GameState.m
//  Elementary Cellular Automata
//
// Copyright (c) 2011 Brian Temple
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "GameState.h"

@implementation GameState
@synthesize rows, maxRows;

- (id)initGameWithMaximumNumberOfRows:(int)maximumNumberOfRows
{
    self.maxRows = maximumNumberOfRows;
    [self reset];
    
    return self;
}

- (void)reset 
{
    self.rows = [[NSMutableArray alloc] initWithCapacity:maxRows];
    
    NSMutableArray *row = [[NSMutableArray alloc] initWithCapacity:WIDTH];
    for (int i = 0; i < WIDTH; i++) 
    {
        if (i == WIDTH/2) 
        {
            [row addObject:[NSNumber numberWithInt:1]];
        }
        else
        {
            [row addObject:[NSNumber numberWithInt:0]];
        }
    }
    [rows addObject:row];
}

- (void)update
{
    // If we have hit the maximum number of rows, delete the oldest ones
    // (max rows can change because of device rotation)
    while (rows.count >= maxRows)
    {
        [rows removeObjectAtIndex:0];
    }
    
    NSMutableArray *previousRow = [rows lastObject];
    NSMutableArray *newRow = [[NSMutableArray alloc] initWithCapacity:WIDTH];
    
    for (int i = 0; i < WIDTH; i++)
    {
        NSNumber *left;
        if (i == 0)
        {
            left = [NSNumber numberWithInt:0];
        }
        else
        {
            left = [previousRow objectAtIndex:i-1];
        }
        
        NSNumber *right;
        if (i == WIDTH-1)
        {
            right = [NSNumber numberWithInt:0];
        }
        else
        {
            right = [previousRow objectAtIndex:i+1];
        }
        
        [newRow addObject:[self findNextCellStateForLeft:left middle:[previousRow objectAtIndex:i] right:right]];
    }
    [rows addObject:newRow];
}

// This function implements the Rule 30 celular autonoma rules.
// The states for this are:
//
// 111 110 101 100 011 010 001 000
//  0   0   0   1   1   1   1   0
- (NSNumber *) findNextCellStateForLeft:(NSNumber *)left middle:(NSNumber *)middle right:(NSNumber *)right
{
    if (0 == [middle intValue])
    {
        if (1 == ([left intValue] + [right intValue]))
        {
            return [NSNumber numberWithInt:1];
        }
        else
        {
            return [NSNumber numberWithInt:0];
        }
    }
    else
    {
        if (1 == [left intValue])
        {
            return [NSNumber numberWithInt:0];
        }
        else
        {
            return [NSNumber numberWithInt:1];
        }
    }
}

@end
