//
//  YHInfiniteScrollView.m
//  SMMEMBERSHIP
//
//  Created by DEV_TEAM1_IOS on 2016. 2. 24..
//  Copyright © 2016년 S.M Entertainment. All rights reserved.
//

#import "YHInfiniteScrollView.h"

@interface YHInfiniteScrollView () <GBInfiniteScrollViewDataSource, GBInfiniteScrollViewDelegate>

@end

@implementation YHInfiniteScrollView

- (void)setInfiniteScrollDirection:(YHScrollDirection)infiniteScrollDirection
{
    switch (infiniteScrollDirection)
    {
        case YHScrollDirectionHorizontal:
            self.scrollDirection = GBScrollDirectionHorizontal;
            break;
        case YHScrollDirectionVertical:
            self.scrollDirection = GBScrollDirectionVertical;
            break;
        default:
            break;
    }
}

- (void)setInfiniteAutoScrollDirection:(YHAutoScrollDirection)infiniteAutoScrollDirection
{
    switch (infiniteAutoScrollDirection)
    {
        case YHAutoScrollDirectionLeftToRight:
            self.autoScrollDirection = GBAutoScrollDirectionLeftToRight;
            break;
        case YHAutoScrollDirectionRightToLeft:
            self.autoScrollDirection = GBAutoScrollDirectionRightToLeft;
            break;
        case YHAutoScrollDirectionTopToBottom:
            self.autoScrollDirection = GBAutoScrollDirectionTopToBottom;
            break;
        case YHAutoScrollDirectionBottomToTop:
            self.autoScrollDirection = GBAutoScrollDirectionBottomToTop;
            break;
        default:
            break;
    }
}

- (instancetype)initWithDelegate:(id <YHInfiniteScrollViewDataSource, YHInfiniteScrollViewDelegate>)delegate
{
    if (self = [super init])
    {
        self.infiniteScrollViewDataSource = self;
        self.infiniteScrollViewDelegate = self;
        
        self.infiniteScrollDataSource = delegate;
        self.infiniteScrollDelegate = delegate;
    }
    
    return self;
}

/**
 *  Gets the current view.
 *
 *  @return The current page of the infinite scroll view.
 */
- (YHInfiniteScrollViewPage *)currentPage
{
    return (YHInfiniteScrollViewPage *) [super currentPage];
}

/**
 * Reloads everything from scratch.
 */
- (void)reloadData
{
    [super reloadData];
}

/**
 * Updates current page's data source.
 */
- (void)updateData
{
    [super updateData];
}

/**
 * Resets the infinite scroll view layout.
 */
- (void)resetLayout
{
    [super resetLayout];
}

/**
 * Stops automatic scrolling.
 */
- (void)stopAutoScroll
{
    [super stopAutoScroll];
}

/**
 * Starts automatic scrolling.
 */
- (void)startAutoScroll
{
    [super startAutoScroll];
}

/**
 *  Gets a reusable page.
 *
 *  @return A reusable infinite scroll view page object.
 */
- (YHInfiniteScrollViewPage *)dequeueReusablePage
{
    return (YHInfiniteScrollViewPage *)[super dequeueReusablePage];
}

/**
 * Scrolls a specific page.
 *
 *  @param index     Index of the page
 *  @param animated  YES if the scrolling should be animated, NO if it should be immediate.
 */
- (void)scrollToPageAtIndex:(NSUInteger)index animated:(BOOL)animated
{
    [super scrollToPageAtIndex:index animated:animated];
}

#pragma mark - GBInfiniteScrollViewDataSource
/**
 *  Tells the data source to return the number of pages.
 *
 *  @warning Required
 *
 *  @param infiniteScrollView Infinite Scroll View Object
 *
 *  @return An NSInteger with the number of pages of the Infinite Scroll View Object
 */
- (NSInteger)numberOfPagesInInfiniteScrollView:(GBInfiniteScrollView *)infiniteScrollView
{
    NSInteger result = 0;
    
    if ([self.infiniteScrollDataSource respondsToSelector:@selector(numberOfPagesInInfiniteScroll:)])
    {
        result = [self.infiniteScrollDataSource numberOfPagesInInfiniteScroll:(YHInfiniteScrollView *)infiniteScrollView];
    }
    
    return result;
}

/**
 *  Asks the data source for a view to display in a particular page index.
 *
 *  @warning Required
 *
 *  @param infiniteScrollView Infinite Scroll View Object
 *  @param index              Index of the page
 *
 *  @return The GBInfiniteScrollViewPage object for the index
 */
- (GBInfiniteScrollViewPage *)infiniteScrollView:(GBInfiniteScrollView *)infiniteScrollView pageAtIndex:(NSUInteger)index
{
    YHInfiniteScrollViewPage *result = nil;
    
    
    if ([self.infiniteScrollDataSource respondsToSelector:@selector(infiniteScrollView:pageAtIndex:)])
    {
        result = [self.infiniteScrollDataSource infiniteScrollView:(YHInfiniteScrollView *)infiniteScrollView pageAtIndex:index];
    }
    
    return result;
}

#pragma mark - GBInfiniteScrollViewDelegate
/**
 *  Called when the GBInfiniteScrollView is panning
 *
 *  @warning Optional
 *
 *  @param UIPanGestureRecognizer
 */

-(void)infiniteScrollViewDidPan:(UIPanGestureRecognizer*)pan
{
    if ([self.infiniteScrollDelegate respondsToSelector:@selector(infiniteScrollDidPan:)]) {
        [self.infiniteScrollDelegate infiniteScrollDidPan:pan];
    }
}
/**
 *  Called when the GBInfiniteScrollView has scrolled to next page.
 *
 *  @warning Optional
 *
 *  @param infiniteScrollView Infinite Scroll View Object
 */
- (void)infiniteScrollViewDidScrollNextPage:(GBInfiniteScrollView *)infiniteScrollView
{    
    if ([self.infiniteScrollDelegate respondsToSelector:@selector(infiniteScrollDidScrollNextPage:)])
    {
        [self.infiniteScrollDelegate infiniteScrollDidScrollNextPage:(YHInfiniteScrollView *)infiniteScrollView];
    }
}

/**
 *  Called when the GBInfiniteScrollView has scrolled to previous page.
 *
 *  @warning Optional
 *
 *  @param infiniteScrollView Infinite Scroll View Object
 */
- (void)infiniteScrollViewDidScrollPreviousPage:(GBInfiniteScrollView *)infiniteScrollView
{
    if ([self.infiniteScrollDelegate respondsToSelector:@selector(infiniteScrollDidScrollPreviousPage:)])
    {
        [self.infiniteScrollDelegate infiniteScrollDidScrollPreviousPage:(YHInfiniteScrollView *)infiniteScrollView];
    }
}

/**
 * Called when use tap on GBInfiniteScrollView
 *
 *  @warning Optional
 *
 *  @param infiniteScrollView Infinite Scroll View Object
 *  @param pageIndex tapped page index
 */
- (void)infiniteScrollView:(GBInfiniteScrollView *)infiniteScrollView didTapAtIndex:(NSInteger)pageIndex
{
    if ([self.infiniteScrollDelegate respondsToSelector:@selector(infiniteScrollView:didTapAtIndex:)])
    {
        [self.infiniteScrollDelegate infiniteScroll:(YHInfiniteScrollView *)infiniteScrollView didTapAtIndex:pageIndex];
    }
}

/**
 *  Asks the delegate if it is allowed to scroll to next page.
 *
 *  @warning Optional
 *
 *  @param infiniteScrollView Infinite Scroll View Object
 */
- (BOOL)infiniteScrollViewShouldScrollNextPage:(GBInfiniteScrollView *)infiniteScrollView
{
    BOOL result = NO;
    
    if ([self.infiniteScrollDelegate respondsToSelector:@selector(infiniteScrollShouldScrollNextPage:)])
    {
        result = [self.infiniteScrollDelegate infiniteScrollShouldScrollNextPage:(YHInfiniteScrollView *)infiniteScrollView];
    }
    
    return result;
}

/**
 *  Asks the delegate if it is allowed to scroll to previous page.
 *
 *  @warning Optional
 *
 *  @param infiniteScrollView Infinite Scroll View Object
 */
- (BOOL)infiniteScrollViewShouldScrollPreviousPage:(GBInfiniteScrollView *)infiniteScrollView
{
    BOOL result = NO;
    
    if ([self.infiniteScrollDelegate respondsToSelector:@selector(infiniteScrollShouldScrollPreviousPage:)])
    {
        result = [self.infiniteScrollDelegate infiniteScrollShouldScrollPreviousPage:(YHInfiniteScrollView *)infiniteScrollView];
    }
    
    return result;
}

@end
