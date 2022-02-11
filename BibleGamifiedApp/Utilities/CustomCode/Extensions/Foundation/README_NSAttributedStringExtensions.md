## NSAttributedStringExtensions.swift
## Capabilities & Usage


Create Bold String

```Swift
var attributedString = NSAttributedString.init(string: "IndiaNIC Infotech Ltd.")
attributedString = attributedString.bolded
```

Add Underline to the string

```Swift
var attributedString = NSAttributedString.init(string: "IndiaNIC Infotech Ltd.")
attributedString = attributedString.underlined
```

Add Italic to the string

```Swift
var attributedString = NSAttributedString.init(string: "IndiaNIC Infotech Ltd.")
attributedString = attributedString.italicized
```

Struckthrough string

```Swift
var attributedString = NSAttributedString.init(string: "IndiaNIC Infotech Ltd.")
attributedString = attributedString.struckthrough
```

Add Shadow to the string

```Swift
var attributedString = NSAttributedString.init(string: "IndiaNIC Infotech Ltd.")
attributedString = attributedString.shadow
```

Get Attributes of the String

```Swift
attributedString.attributes
```

Add Custom Color to the String

```Swift
var attributedString = NSAttributedString.init(string: "IndiaNIC Infotech Ltd.")
attributedString = attributedString.colored(with: .red)
```

Add Custom Font to the String

```Swift
var attributedString = NSAttributedString.init(string: "IndiaNIC Infotech Ltd.")
attributedString = attributedString.font(with: UIFont.systemFont(ofSize: 12))
```


Apply Custom Attributes to the String

```Swift
let myAttribute = [ NSAttributedStringKey.backgroundColor: UIColor.yellow ]
attributedString = attributedString.applying(attributes: myAttribute, toRangesMatching: "IndiaNIC")
```

Default Operators to perform operations
```Swift
attributedString = attributedString.bolded + anotherAttributedString.struckthrough
```
