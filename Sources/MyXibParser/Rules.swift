//
//  File.swift
//
//
//  Created by 蒋艺 on 2023/7/4.
//

let ignoredTags: [String] = []

// default Rules was omitted for simplicity
let defaultRules: [String: String] = [
    "opaque": "isOpaque = false",
    "userInteractionEnabled": "isUserInteractionEnabled = false",
    "customClass": "customClass = "
]

func shouldIgnoreProperty(tag: String, key: String) -> Bool {
    let propertyToIgnore: [String: [String]] = [
        "label": ["minimumFontSize"],
        "button": ["buttonType", "lineBreakMode"],
        "imageView": ["catalog"],
        "tableView": ["style"],
        "collectionView": ["dataMode"],
        "common": [
            "horizontalHuggingPriority",
            "verticalHuggingPriority",
            "fixedFrame", "id",
            "adjustsLetterSpacingToFitWidth"
        ]
    ]
    
    let ignoredRules = propertyToIgnore["common", default: []] + propertyToIgnore[tag, default: []]
    return ignoredRules.contains(key)
}

let rules: Rules = [
    "label": [
        "adjustsFontSizeToFit": "adjustsFontSizeToFitWidth"
    ],
    "slider": [
        "minValue": "minimumValue",
        "maxValue": "maximumValue",
    ],
    "collectionView": [
        "multipleTouchEnabled": "isMultipleTouchEnabled",
        "directionalLockEnabled": "isDirectionalLockEnabled",
        "pagingEnabled": "isPagingEnabled",
        "prefetchingEnabled": "isPrefetchingEnabled",
    ],
    "common": [
        "clipSubviews": "clipsToBounds",
        "opaque": "isOpaque",
        "userInteractionEnabled": "isUserInteractionEnabled"
    ]
]
