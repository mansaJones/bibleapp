### Encryption and Decryption Use
==============================


## Function Calling From Swift Code 
// Encryption and Decryption Example
let strValue = "The amount of random conversations that lead to culture-shifting ideas is insane."

// Define the key: 32 Characters
let key = "NjFlYWJhNjEwZDYxN2MxNzU0YWNlYzM1" // key.count * 8 is the AES mode. here 256

// Define the IV: 16 Characters
let iv = "ZjdjNTNlNzFlOTJj"

// Encrypt the data
let strEncrypted = KPEncryptor.encrypt(withKey: key, iv: iv, plainText: strValue)
print(strEncrypted)

// Decrypt the data
let decrypted = KPEncryptor.decrypt(withKey: key, iv: iv, cypherText: strEncrypted)
print(decrypted)

## Function Calling From Objective-C Code 
NSString *strKey = @"42583BFFC43C34DB77863C29BED0EC22";

NSString *strIV = @"02E8B634F12D11EB";
NSString *strPlainText = @"hi";

NSString *strEncryptedText = [KPEncryptor encryptWithKey:strKey iv:strIV plainText:strPlainText];

NSLog(@"%@", strEncryptedText);

NSString *strw1 = @"iosbTkk2Tvjq8etNlAZLsA==";

NSString *strDecryptedText = [KPEncryptor decryptWithKey:strKey iv:strIV cypherText:strEncryptedText];

NSLog(@"%@", strDecryptedText);

