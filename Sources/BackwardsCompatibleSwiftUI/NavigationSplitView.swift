import SwiftUI

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public struct NavigationSplitView<Content> : View where Content : View {
  let sidebar: () -> Content
  let content: (() -> Content)?
  let detail: () -> Content
  
  public var body: some View {
    Group {
      if let content = content {
        if #available(OSX 13.0, iOS 16.0, tvOS 16.0, watchOS 9.0, *) {
          SwiftUI.NavigationSplitView(
            sidebar: sidebar,
            content: content,
            detail: detail
          )
        } else {
          NavigationView {
            sidebar()
            content()
            detail()
          }
        }
      } else {
        if #available(OSX 13.0, iOS 16.0, tvOS 16.0, watchOS 9.0, *) {
          SwiftUI.NavigationSplitView(
            sidebar: sidebar,
            detail: detail
          )
        } else {
          NavigationView {
            sidebar()
            detail()
          }
        }
      }
    }
  }
  
  public init(
    @ViewBuilder sidebar: @escaping () -> Content,
    @ViewBuilder content: @escaping () -> Content,
    @ViewBuilder detail: @escaping () -> Content
  ) {
    self.sidebar = sidebar
    self.content = content
    self.detail = detail
  }
}
