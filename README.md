YHFramework
========================

## CocosPods Library
```
pod 'AFNetworking', '~> 2.6.0'
pod 'GBInfiniteScrollView'
pod 'SDWebImage'
pod 'MONActivityIndicatorView'
pod 'ZXingObjC'
pod 'Fabric'
pod 'Crashlytics'
pod 'MarqueeLabel'
pod 'iOS-Slide-Menu'
pod 'PureLayout'
pod 'GoogleMaps'
pod 'Google/Analytics'
```

## 신규 프로젝트 적용 방법
1. YHFramework_PrefixHeader.pch 파일 복사 하여 해당 프로젝트에 추가
2. Build Setting -> 'prefix' 검색 -> Prefix Header 항목에 ${SRCROOT}/${PROJECT_NAME}/YHFramework_PrefixHeader.pch 입력
3. Podfile 생성후(pod init) 위 필수 pod 라이브러리 추가 및 설치 
4. /YHFramework 폴드 전체 해당 프로젝트에 복사


## 주의 사항
- YHTools.h 를 제외한 모든 클래스는 Subclassing 통해 사용
- YHInfiniteScrollView 클래스 사용시 Scene 속성에서 'Adjust Scroll Insets' 속정을 해제


## License
The MIT License (MIT)

Copyright (c) 2013 Gerardo Blanco

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
