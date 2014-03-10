//
//  SixColumnsFlowLayout.m
//  Cagliostro
//
//  Created by Jean-André Santoni on 10/03/2014.
//  Copyright (c) 2014 Jean-André Santoni. All rights reserved.
//

#import "SixColumnsFlowLayout.h"

@interface SixColumnsFlowLayout ()
    @property (nonatomic, strong) NSDictionary *layoutInfo;
@end

@implementation SixColumnsFlowLayout

#pragma mark - Layout

- (void)prepareLayout
{
    NSMutableDictionary *newLayoutInfo = [NSMutableDictionary dictionary];
    NSMutableDictionary *cellLayoutInfo = [NSMutableDictionary dictionary];
    
    NSInteger sectionCount = [self.collectionView numberOfSections];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    
    for (NSInteger section = 0; section < sectionCount; section++) {
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];
        
        for (NSInteger item = 0; item < itemCount; item++) {
            indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            
            UICollectionViewLayoutAttributes *itemAttributes =
            [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            itemAttributes.frame = [self frameForAlbumPhotoAtIndexPath:indexPath];
            
            cellLayoutInfo[indexPath] = itemAttributes;
        }
    }
    
    newLayoutInfo[@"EpisodeCell"] = cellLayoutInfo;
    
    self.layoutInfo = newLayoutInfo;
}

- (CGRect)frameForAlbumPhotoAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row / 6;
    NSInteger col = indexPath.row % 6;
    
    NSInteger det = row % 3;
    
    NSInteger INSET = 10;
    NSInteger WIDTH = 115;
    
    NSInteger LOW = 130;
    NSInteger HIGH = 190;
    
    if (       (col == 0 || col == 3) && det == 0) { return CGRectMake(INSET + col * (WIDTH+INSET), INSET + row*160     , WIDTH, HIGH);
    } else if ((col == 0 || col == 3) && det == 1) { return CGRectMake(INSET + col * (WIDTH+INSET), INSET + row*160 + 40, WIDTH, LOW );
    } else if ((col == 0 || col == 3) && det == 2) { return CGRectMake(INSET + col * (WIDTH+INSET), INSET + row*160 + 20, WIDTH, LOW );
    }
    
    if (       (col == 1 || col == 4) && det == 0) { return CGRectMake(INSET + col * (WIDTH+INSET), INSET + row*160     , WIDTH, LOW );
    } else if ((col == 1 || col == 4) && det == 1) { return CGRectMake(INSET + col * (WIDTH+INSET), INSET + row*160 - 20, WIDTH, HIGH);
    } else if ((col == 1 || col == 4) && det == 2) { return CGRectMake(INSET + col * (WIDTH+INSET), INSET + row*160 + 20, WIDTH, LOW );
    }
    
    if (       (col == 2 || col == 5) && det == 0) { return CGRectMake(INSET + col * (WIDTH+INSET), INSET + row*160     , WIDTH, LOW );
    } else if ((col == 2 || col == 5) && det == 1) { return CGRectMake(INSET + col * (WIDTH+INSET), INSET + row*160 - 20, WIDTH, LOW );
    } else if ((col == 2 || col == 5) && det == 2) { return CGRectMake(INSET + col * (WIDTH+INSET), INSET + row*160 - 40, WIDTH, HIGH);
    }

    return CGRectMake(10 + col*125, 10 + row*160, 115, LOW);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *allAttributes = [NSMutableArray arrayWithCapacity:self.layoutInfo.count];
    
    [self.layoutInfo enumerateKeysAndObjectsUsingBlock:^(NSString *elementIdentifier,
                                                         NSDictionary *elementsInfo,
                                                         BOOL *stop) {
        [elementsInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath,
                                                          UICollectionViewLayoutAttributes *attributes,
                                                          BOOL *innerStop) {
            if (CGRectIntersectsRect(rect, attributes.frame)) {
                [allAttributes addObject:attributes];
            }
        }];
    }];
    
    return allAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.layoutInfo[@"EpisodeCell"][indexPath];
}

- (CGSize)collectionViewContentSize
{
    return CGSizeMake(768, 1450);
}

@end