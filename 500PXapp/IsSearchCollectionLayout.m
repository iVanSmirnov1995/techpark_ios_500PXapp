//
//  IsSearchCollectionLayout.m
//  500PXapp
//
//  Created by Максим Стегниенко on 26.10.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import "IsSearchCollectionLayout.h"

@interface IsSearchCollectionLayout ()
{
    NSMutableArray *layoutArr;
    CGSize  currentContentSize;
}

@end


@implementation IsSearchCollectionLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    layoutArr = [self generateLayout];
    
    
}

- ( NSArray*)layoutAttributesForElementsInRect:(CGRect)rect {
    return layoutArr;
    
}

- (CGSize)collectionViewContentSize {
    
    return currentContentSize;
}

-(NSMutableArray *) generateLayout {
    
    
    NSMutableArray *arr  = [NSMutableArray new];
    NSInteger sectionCount = 1;
    if ([self.collectionView.dataSource respondsToSelector:@selector(numberOfSectionsInCollectionView:)] ) {
        sectionCount = [self.collectionView.dataSource numberOfSectionsInCollectionView:self.collectionView];
        
    }
    CGSize cellSize = self.cellSize;
    
    float collectionWidth = self.collectionView.bounds.size.width;
    float xOffset = 5;
    float yOffset = 5;
    float screenWidht = [UIScreen mainScreen].bounds.size.width;
    float screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    
    for (NSInteger section = 0 ; section < sectionCount ; section++) {
        NSInteger itemCount = [ self.collectionView.dataSource collectionView:self.collectionView numberOfItemsInSection:section];
        for (NSInteger item = 0 ;item < itemCount; item++) {
            NSIndexPath *idxPath = [NSIndexPath indexPathForItem:item inSection:section];
            
            if (section==0 ) {
                UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:idxPath];
                
                
                
                attr.frame = CGRectMake(0, 10, screenWidht, 200);
                //  NSLog(@"%f", [UIScreen mainScreen].bounds.size.width);
                
                
                [arr addObject:attr];
                yOffset = yOffset + 215;
                
            }
            
            
            
            if (section==1 ) {
                UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:idxPath];
                
                attr.frame = CGRectMake(xOffset, yOffset, screenWidht/2, 100);
                [arr addObject:attr];
                
                xOffset += screenWidht/2;
                if (xOffset+ 100 > collectionWidth ) {
                    xOffset = 5;
                    yOffset += 115;
                }
                
                
            }
            if (section==2 ) {
                UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:idxPath];
                attr.frame = CGRectMake(xOffset, yOffset, screenWidht/2, 100);
                [arr addObject:attr];
                
                xOffset += screenWidht/2;
                if (xOffset+100 > collectionWidth ) {
                    xOffset = 5;
                    yOffset += 115;
                }
                
            }
            
            
            
        }
        
    }
    
    
    
    
    currentContentSize = CGSizeMake(xOffset, yOffset);
    
    return arr;
    
}

@end
