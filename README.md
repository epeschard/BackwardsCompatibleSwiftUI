# BackwardsCompatibleSwiftUI

This Swift Package provides backwards compatible SwiftUI types. By creating our own LazyHStack, which will be available on all OS versions, the compiler no longer complains. This is because now, LazyHStack refers to BackwardsCompatibleSwiftUI.LazyHStack and not SwiftUI.LazyHStack. Then, on our own implementation we check for the version, and there we decide whether to use the old SwiftUI.HStack, or the new SwiftUI.LazyHStack.

To learn more about this approach look at [this article](https://swiftui-lab.com/backward-compatibility/ "Backward Compatibility with SwiftUI") by SwiftUILab.
