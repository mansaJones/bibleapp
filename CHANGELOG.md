<a href="https://www.indianic.com/"><img src="https://drwappqdd0b0v.cloudfront.net/wp-content/uploads/2016/09/logo-black-indianic.png"></a>


# Instruction 

### You can get common classes in structure application and all iOS team members must have to follow this structure and common classes.

Everyone requested to follow these coding standards. 
https://docs.google.com/spreadsheets/d/1iP8SNOwL7ad90LuXsjJJ_Sb0AmBm_9hUubCM3VYwQTk/edit?usp=sharing

Your code will be reviewed and the rating will be given based on the following scale:
*  Readability / Clarity - 25%
*  Maintainability - 25%
*  Architecture / Design - 20%
*  Reusability - 20%
*  Reliability / Robustness / Efficiency - 10%


#### Question : Why we use common classes and application structure, i have my structure ?
Answer : Our main goal is to save time and reduce bug fixing time, niether to increase time, so if all of us is on same phase on coding and structure level then if any issue is found then we can easlily resolve if particular person is not available and we can save lots of our developement time and bug resolving time and we can other lots of stuffs in production hours.

# CHANGELOG 
---------------------------------------------------
---------------------------------------------------

# Version : 1.0

`Date : 29 Nov 2018 11:40 AM`

We have added few common classes in this version mentioned below :

#### Constant.swift 
    Application general common file 
    
#### APIConstant.swift
    Define all your API related constant in this file.
    Do not add any other constant if it is not related to the API.
    
#### DeviceHelper.swift along with readme file 
    We can get all device related information that is mentioned below : 
        - Equatable
	    - Device identification
	    - Device family detection
	    - Device group detection
	    - Simulator detection
	    - Battery state
	    - Battery level
	    - Various device metrics (e.g. screen size, screen ratio, PPI)
	    - Low Power Mode detection
	    - Guided Access Session detection
	    - Screen brightness
	    - Display Zoom detection
	    - Detect available sensors (Touch ID, Face ID)
	    - Detect available disk space
	    - Device height / width / size
 
#### AppConstants.swift
    We have to set UserDefaults keys which is used in the whole application, if we use all keys in 1 place hen we can find easily
    
#### FileHelper.swift along with readme file 
    We can perform few operations in Document directory / Cache / Library / Bundle .
        - Get Files from specific path
        - Get files from document directory
        - Get files from cache directory
        - Get files from library directory
        - Get files from document directory with custom directory
        - Create directory in specific path in Document directory
        - Create directory in specific path in cache path
        - Create directory in specific path library path
        - Get resource path from bundle
        - Check file file is exist in bundle
        - Get path of file from home directory
        - Check file is exist in home directory
        - Get all files of specific extension
        - Get file created date
        - Remove directory or file from specific path
        
#### UIAlertControllerExtensions.swift
    We can use this class to display native Alert / Actionsheet

#### UIColorExtensions.swift
    If any color we are using in whole application then we have to use this UIColor extension

#### UIFontExtensions.swift
    If any custom font we are using in whole application and programmatically we have to set then we have to use this UIFont extension, there we added few enums to declare font 

#### UIViewExtensions.swift
    To work with the layer operation such as Border, CornerRadius, Shadow and many more directly from the storyboard.
    
#### DateHelper.swift along with readme file
    Date related below oprations you can perform that is mentioned below :
	    - Convert from string
	    - Convert to string
	    - Compare dates
	    - Adjust dates
	    - Create dates for...
	    - Forcing a week to start on monday
	    - Time since...
	    - Extracting components
	    
#### String+Validation.swift along with readme file
    We added few string validation that is mentioned belwo :
        - Check if string contains one or more letters.
        - Check if string contains one or more numbers.
        - Check if string contains only letters.
        - Check if string contains at least one letter and one number.
        - Check if string contains only numbers.
        - Check if string is valid Email address or not.
        - Check if string starts with substring.
        - Check if string ends with substring.
        - Check if string contains one or more instance of substring.
        - Check if string is https URL.
        - Check if string is http URL.
        - Check if isEmoji
        - and many more operations 
        - Also we have manage enum for all Regex 
        - String is blank 
        - String characters total count
        - Get max length
        - Get min length
        - To check valid url
        
#### StringExtension.swift 
        - Remove Whitespace from string.
        - String with no spaces or new lines in beginning and end.
        - String decoded from base64  (if applicable).
        - String encoded in base64 (if applicable).
        - Replace the string with other string.
        - Array with unicodes for all characters in a string.
        - Readable string from a URL string.
        - URL escaped string.
        - Bool value from string (if applicable).
        - Double value from string (if applicable).
        - Float value from string (if applicable).
        - Float32 value from string (if applicable).
        - Float64 value from string (if applicable).
        - Integer value from string (if applicable).
        - Int16 value from string (if applicable).
        - Int32 value from string (if applicable).
        - Int64 value from string (if applicable).
        - Int8 value from string (if applicable).
        - URL from string (if applicable).
        - First character of string (if applicable).
        - Last character of string (if applicable).
        - Remove all the other Characters except the numbers.
        - Check string text in main string
        - Replace text
        - Get character from index
        - Get character from index
        - Get last index from character
        - Get substring from range
        - Seperated by characters
        - Replace text by with text
        - Leading and Tralling from spaces from string
        - To triming / removing particular character
        - To triming / removing string
        - Remove specific character at index
        - Remove all specific character
        - Get the width for the string based on the height and font.
        - Get the height for the string based on the width and font.
        - Get MD5 string (you need to add bridging header and add #import <CommonCrypto/CommonCrypto.h> in it otherwise you will get an error)

