import SwiftUI

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public struct AsyncImage<I, P> : View where I: View, P: View {

  let url: URL?
  let scale: CGFloat?
  let content: (Image) -> I
  let placeholder: () -> P

  @ObservedObject private var imageLoader = ImageLoader()

  public var body: some View {
    Group {
      if #available(OSX 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *) {
        if let scale = scale {
          SwiftUI.AsyncImage(
            url: url,
            scale: scale,
            content: content,
            placeholder: placeholder
          )
        } else {
          SwiftUI.AsyncImage(
            url: url,
            content: content,
            placeholder: placeholder
          )
        }
      } else {
        AsyncImage(
          url: url,
          scale: scale,
          content: content,
          placeholder: placeholder
        )
      }
    }
  }

  public init(
    url: URL?,
    scale: CGFloat? = nil,
    content: @escaping (Image) -> I,
    placeholder: @escaping () -> P
  ) {
    self.url = url
    self.scale = scale
    self.content = content
    self.placeholder = placeholder

    if let url = url {
      imageLoader.load(from: url)
    }
  }
}

// MARK: - Image Loader

import Combine

class ImageLoader: ObservableObject {
  @Published var image: UIImage?
  private var cancellable: AnyCancellable?

  func load(from url: URL) {
    cancellable = URLSession.shared.dataTaskPublisher(for: url)
      .map { UIImage(data: $0.data) }
      .replaceError(with: nil)
      .receive(on: DispatchQueue.main)
      .assign(to: \.image, on: self)
  }

  deinit {
    cancellable?.cancel()
  }
}
