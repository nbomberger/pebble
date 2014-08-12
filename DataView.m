//
//  DataView.m
//  arcpebble
//
//  Created by Matthew Roll on 8/11/14.
//  Copyright (c) 2014 arcweb. All rights reserved.
//

#import "DataView.h"

@implementation DataView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)showData:(int)num
{
    if (self.dataImage == nil)
    {
        self.dataImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 90, 90)];
        
        [self addSubview:self.dataImage];
    }
    
    NSString *filename = [NSString stringWithFormat:@"dice%d.gif", num];
    
    self.dataImage.image = [UIImage imageNamed:filename];
}

@end
