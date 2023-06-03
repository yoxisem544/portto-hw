//
//  Kingfisher+SVG+WebP.swift
//  Homework
//
//  Created by David on 2023/6/3.
//

import Kingfisher
import KingfisherWebP
import SVGKit

struct SVGAndWebPImageProcessor: ImageProcessor {
    let identifier: String = "com.homework.svg_webp_processor"

    static let `default` = SVGAndWebPImageProcessor()

    func process(item: ImageProcessItem, options: KingfisherParsedOptionsInfo) -> KFCrossPlatformImage? {
        switch item {
        case .image(let image):
            return image
        case .data(let data):
            if data.isWebPFormat {
                return KingfisherWrapper<KFCrossPlatformImage>.image(webpData: data,
                                                                     scale: options.scaleFactor,
                                                                     onlyFirstFrame: options.onlyLoadFirstFrame)
            } else if data.isSVG, let svgImage = SVGKImage(data: data)?.uiImage {
                return svgImage
            } else {
                return DefaultImageProcessor.default.process(item: item, options: options)
            }
        }
    }
}

struct SVGAndWebPSerializer: CacheSerializer {

    static let `default` = SVGAndWebPSerializer()

    /// Whether the image should be serialized in a lossy format. Default is false.
    public var isLossy: Bool = false

    /// The compression quality when converting image to a lossy format data. Default is 1.0.
    public var compressionQuality: CGFloat = 1.0

    private init() {}

    public func data(with image: KFCrossPlatformImage, original: Data?) -> Data? {
        if let original {
            if original.isSVG {
                return original
            } else if original.isWebPFormat {
                let qualityInWebp = min(max(0, compressionQuality), 1) * 100
                return image.kf.normalized.kf.webpRepresentation(isLossy: isLossy, quality: Float(qualityInWebp))
            }
        }

        // fallback
        return DefaultCacheSerializer.default.data(with: image, original: original)
    }

    public func image(with data: Data, options: KingfisherParsedOptionsInfo) -> KFCrossPlatformImage? {
        SVGAndWebPImageProcessor.default.process(item: .data(data), options: options)
    }
}
