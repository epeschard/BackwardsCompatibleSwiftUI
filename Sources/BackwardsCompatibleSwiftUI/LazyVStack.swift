import SwiftUI

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public struct LazyVStack<Content> : View where Content : View {
  let alignment: HorizontalAlignment
  let spacing: CGFloat?
  let content: () -> Content
  
  public var body: some View {
    Group {
      if #available(OSX 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *) {
        SwiftUI.LazyVStack(
          alignment: alignment,
          spacing: spacing,
          content: content
        )
      } else {
        VStack(
          alignment: alignment,
          spacing: spacing,
          content: content
        )
      }
    }
  }
  
  public init(
    alignment: HorizontalAlignment = .center,
    spacing: CGFloat? = nil,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.alignment = alignment
    self.spacing = spacing
    self.content = content
  }
}
