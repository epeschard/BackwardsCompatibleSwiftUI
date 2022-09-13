import SwiftUI

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
struct ProgressView<Content> : View where Content : View {
    let title: String
    let style: UIActivityIndicatorView.Style
    let content: () -> Content

    var body: some View {
        Group {
            if #available(OSX 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *) {
                SwiftUI.ProgressView(title)
                        .progressViewStyle(CircularProgressViewStyle())
            } else {
                VStack {
                    ActivityIndicator(
                        isAnimating: true,
                        style: style
                    )
                    Text(title)
                }
            }
        }
    }

    init(
        title: String,
        style: UIActivityIndicatorView.Style = .large,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.style = style
        self.content = content
    }
}

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
struct ActivityIndicator: UIViewRepresentable {

    typealias UIView = UIActivityIndicatorView
    var isAnimating: Bool
    fileprivate var configuration = { (indicator: UIView) in }
    let style: UIActivityIndicatorView.Style

    func makeUIView(
        context: UIViewRepresentableContext<Self>
    ) -> UIView {
        UIView(style: style)
    }

    func updateUIView(
        _ uiView: UIView,
        context: UIViewRepresentableContext<Self>
    ) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
        configuration(uiView)
    }
}

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension View where Self == ActivityIndicator {
    func configure(
        _ configuration: @escaping (Self.UIView) -> Void
    ) -> Self {
        Self(
            isAnimating: self.isAnimating,
            configuration: configuration,
            style: self.style
        )
    }
}
