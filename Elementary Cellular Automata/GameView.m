//
//  GameView.m
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

#import "GameView.h"

@implementation GameView
@synthesize gameState;

- (void)drawRect:(CGRect)rect
{
    if (gameState == NULL)
    {
        return;
    }
        
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(context);
    
    CGContextSetRGBFillColor(context, 0, 0, 0, 1);
    CGContextFillRect(context, CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height));
    
    int cellSize = self.bounds.size.width / WIDTH;
    double xOffset = (self.bounds.size.width - (cellSize * WIDTH))/2.0;
    
    CGContextSetRGBFillColor(context, 1, 0, 0, 1);
    for (int i = 0; i < self.gameState.rows.count; i++)
    {        
        NSMutableArray *currentRow = [self.gameState.rows objectAtIndex:i];
        for (int j = 0; j < [currentRow count]; j++)
        {
            NSNumber *currentCell = [currentRow objectAtIndex:j];
            if ([currentCell boolValue])
            {
                CGRect cellRect = CGRectMake(xOffset + (cellSize * j), cellSize * i, cellSize, cellSize);
                CGContextFillEllipseInRect(context, cellRect);
            }
        }
    }
    
    UIGraphicsPopContext();
}
@end
