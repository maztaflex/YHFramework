//
//  YHInfiniteScrollView.h
//  SMMEMBERSHIP
//
//  Created by DEV_TEAM1_IOS on 2016. 2. 24..
//  Copyright © 2016년 S.M Entertainment. All rights reserved.
//

#import <GBInfiniteScrollView/GBInfiniteScrollView.h>
#import "YHInfiniteScrollViewPage.h"

typedef NS_ENUM(NSInteger, YHAutoScrollDirection) {
    YHAutoScrollDirectionRightToLeft,   /**<
                                         * Automatic scrolling from right to left.
                                         * @warning Default
                                         */
    YHAutoScrollDirectionLeftToRight,   /**<
                                         * Automatic scrolling from left to right.
                                         */
    YHAutoScrollDirectionTopToBottom,   /**<
                                         * Automatic scrolling from top to bottom.
                                         */
    YHAutoScrollDirectionBottomToTop    /**<
                                         * Automatic scrolling from bottom to top.
                                         */
};

typedef NS_ENUM(NSInteger, YHScrollDirection) {
    YHScrollDirectionHorizontal,        /**<
                                         * Horizontal scroll direction.
                                         * @warning Default
                                         */
    YHScrollDirectionVertical           /**<
                                         * Vertical scroll direction.
                                         */
};


@protocol YHInfiniteScrollViewDelegate;
@protocol YHInfiniteScrollViewDataSource;


@interface YHInfiniteScrollView : GBInfiniteScrollView

@property (nonatomic, assign) YHScrollDirection infiniteScrollDirection;
@property (nonatomic, assign) YHAutoScrollDirection infiniteAutoScrollDirection;


@property (nonatomic, weak) id <YHInfiniteScrollViewDataSource> infiniteScrollDataSource;
@property (nonatomic, weak) id <YHInfiniteScrollViewDelegate> infiniteScrollDelegate;

- (instancetype)initWithDelegate:(id <YHInfiniteScrollViewDataSource, YHInfiniteScrollViewDelegate>)delegate;
- (YHInfiniteScrollViewPage *)currentPage;
- (void)reloadData;
- (void)updateData;
- (void)resetLayout;
- (void)stopAutoScroll;
- (void)startAutoScroll;
- (YHInfiniteScrollViewPage *)dequeueReusablePage;
- (void)scrollToPageAtIndex:(NSUInteger)index animated:(BOOL)animated;

@end

@protocol YHInfiniteScrollViewDataSource<NSObject>
@required

- (NSInteger)numberOfPagesInInfiniteScroll:(YHInfiniteScrollView *)infiniteScroll;
- (YHInfiniteScrollViewPage *)infiniteScrollView:(YHInfiniteScrollView *)infiniteScrollView pageAtIndex:(NSUInteger)index;

@end

@protocol YHInfiniteScrollViewDelegate<NSObject>

@optional

- (void)infiniteScrollDidPan:(UIPanGestureRecognizer*)pan;
- (void)infiniteScrollDidScrollNextPage:(YHInfiniteScrollView *)infiniteScroll;
- (void)infiniteScrollDidScrollPreviousPage:(YHInfiniteScrollView *)infiniteScroll;
- (void)infiniteScroll:(YHInfiniteScrollView *)infiniteScroll didTapAtIndex:(NSInteger)pageIndex;
- (BOOL)infiniteScrollShouldScrollNextPage:(YHInfiniteScrollView *)infiniteScroll;
- (BOOL)infiniteScrollShouldScrollPreviousPage:(YHInfiniteScrollView *)infiniteScroll;


@end
