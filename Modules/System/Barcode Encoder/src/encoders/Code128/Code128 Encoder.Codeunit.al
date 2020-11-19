// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved. 
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
/// <summary> 
/// Code-128 barcode font implementation from IDAutomation
/// from: https://www.idautomation.com/barcode-fonts/code-128/ 
/// Alpha-numeric barcode with three character sets. Supports Code-128, GS1-128 (Formerly known as UCC/EAN-128) and ISBT-128.
/// </summary>
codeunit 9216 Code128BarcodeEncoder implements IBarcodeEncoder
{
    Access = Public;

    /// <summary> 
    /// Encodes the barcode string to print a barcode using the IDautomation barcode font.
    /// From: https://en.wikipedia.org/wiki/Code_128/
    /// Code 128 is a high-density linear barcode symbology defined in ISO/IEC 15417:2007.[1] It is used for alphanumeric or numeric-only barcodes. 
    /// It can encode all 128 characters of ASCII and, by use of an extension symbol (FNC4), the Latin-1 characters defined in ISO/IEC 8859-1. 
    /// It generally results in more compact barcodes compared to other methods like Code 39, especially when the texts contain mostly digits.
    /// GS1-128 (formerly known as UCC/EAN-128) is a subset of Code 128 and is used extensively worldwide in shipping and packaging industries as a product identification code for the container and pallet levels in the supply chain.
    /// 
    /// Use the Function IsFontEncoder() to check if this function implemented to prevent an error, or implement your own function by subscribing to event OnBeforeEncodeFont()
    /// </summary>
    /// <seealso cref="OnBeforeEncodeFont"/> 
    /// <seealso cref="OnAfterEncodeFont"/>
    /// <param name="TempBarcodeParameters">Parameter of type Record BarcodeParameters temporary.</param>
    /// <returns>Return variable "EncodedText" of type Text.</returns>
    procedure FontEncoder(var TempBarcodeParameters: Record BarcodeParameters temporary) EncodedText: Text
    var
        SymbologyEncoderImpl: Codeunit Code128_BarcodeEncoderImpl;
        IsHandled: Boolean;
    begin
        OnBeforeEncodeFont(TempBarcodeParameters, EncodedText, IsHandled);

        SymbologyEncoderImpl.FontEncoder(TempBarcodeParameters, EncodedText, IsHandled);

        OnAfterEncodeFont(TempBarcodeParameters, EncodedText);
    end;

    /// <summary> 
    /// Encodes the barcode string to generate a barcode image in Base64 format
    /// From: https://en.wikipedia.org/wiki/Code_128/
    /// Code 128 is a high-density linear barcode symbology defined in ISO/IEC 15417:2007.[1] It is used for alphanumeric or numeric-only barcodes. 
    /// It can encode all 128 characters of ASCII and, by use of an extension symbol (FNC4), the Latin-1 characters defined in ISO/IEC 8859-1. 
    /// It generally results in more compact barcodes compared to other methods like Code 39, especially when the texts contain mostly digits.
    /// GS1-128 (formerly known as UCC/EAN-128) is a subset of Code 128 and is used extensively worldwide in shipping and packaging industries as a product identification code for the container and pallet levels in the supply chain.
    /// 
    /// This Function is currently throwing an error and is reserved for future use when Base64ImageEncoding will be supported.
    /// Use the Function IsBase64Encoder() to check if this function implemented to prevent an error, or implement your own function by subscribing to event OnBeforeEncodeBase64Image()
    /// </summary>
    /// <seealso cref="OnBeforeEncodeBase64Image"/> 
    /// <seealso cref="OnAfterEncodeBase64Image"/>
    /// <param name="TempBarcodeParameters">Parameter of type Record BarcodeParameters temporary.</param>
    /// <returns>Return variable "Base64Image" of type Text.</returns>
    procedure Base64ImageEncoder(var TempBarcodeParameters: Record BarcodeParameters temporary) Base64Image: Text
    var
        SymbologyEncoderImpl: Codeunit Code128_BarcodeEncoderImpl;
        IsHandled: Boolean;
    begin
        OnBeforeEncodeBase64Image(TempBarcodeParameters, Base64Image, IsHandled);

        SymbologyEncoderImpl.Base64ImageEncoder(TempBarcodeParameters, Base64Image, IsHandled);

        OnAfterEncodeBase64Image(TempBarcodeParameters, Base64Image);
    end;

    /// <summary> 
    /// Validates if the Input String is a valid string to encode the barcode.
    /// From: https://en.wikipedia.org/wiki/Code_128/
    /// Code 128 includes 108 symbols: 103 data symbols, 3 start symbols, and 2 stop symbols. 
    /// Each symbol consists of three black bars and three white spaces of varying widths. All widths are multiples of a basic "module". 
    /// Each bar and space is 1 to 4 modules wide, and the symbols are fixed width: the sum of the widths of the three black bars and three white bars is 11 modules.
    /// The stop pattern is composed of two overlapped symbols and has four bars. The stop pattern permits bidirectional scanning. When the stop pattern is read left-to-right (the usual case), the stop symbol (followed by a 2-module bar) is recognized. 
    /// When the stop pattern is read right-to-left, the reverse stop symbol (followed by a 2-module bar) is recognized. A scanner seeing the reverse stop symbol then knows it must skip the 2-module bar and read the rest of the barcode in reverse.
    /// Despite its name, Code 128 does not have 128 distinct symbols, so it cannot represent 128 code points directly. To represent all 128 ASCII values, it shifts among three code sets (A, B, C). 
    /// Together, code sets A and B cover all 128 ASCII characters. Code set C is used to efficiently encode digit strings. 
    /// The initial subset is selected by using the appropriate start symbol. Within each code set, some of the 103 data code points are reserved for shifting to one of the other two code sets. 
    /// The shifts are done using code points 98 and 99 in code sets A and B, 100 in code sets A and C and 101 in code sets B and C to switch between them):
    ///    -  128A (Code Set A) – ASCII characters 00 to 95 (0–9, A–Z and control codes), special characters, and FNC 1–4
    ///    -  128B (Code Set B) – ASCII characters 32 to 127 (0–9, A–Z, a–z), special characters, and FNC 1–4
    ///    -  128C (Code Set C) – 00–99 (encodes two digits with a single code point) and FNC1
    /// </summary>
    /// <seealso cref="OnBeforeValidateInputString"/> 
    /// <seealso cref="OnAfterValidateInputString"/>
    /// <param name="TempBarcodeParameters">Parameter of type Record BarcodeParameters temporary.</param>
    /// <returns>Return variable "InputStringOK" of type Boolean.</returns>
    procedure ValidateInputString(var TempBarcodeParameters: Record BarcodeParameters temporary) InputStringOK: Boolean
    var
        SymbologyEncoderImpl: Codeunit Code128_BarcodeEncoderImpl;
        IsHandled: Boolean;
    begin
        OnBeforeValidateInputString(TempBarcodeParameters, InputStringOK, IsHandled);

        SymbologyEncoderImpl.ValidateInputString(TempBarcodeParameters, InputStringOK, IsHandled);

        OnAfterValidateInputString(TempBarcodeParameters, InputStringOK);
    end;

    /// <summary> 
    /// Shows if this encoder is implemented as a Barcode Font Encoder
    /// </summary>
    /// <returns>Return variable "Boolean".</returns>
    procedure IsFontEncoder(): Boolean
    begin
        exit(true);
    end;

    /// <summary> 
    /// Shows if this encoder is implemeted as a Barcode Image in Base64 format
    /// </summary>
    /// <returns>Return variable "Boolean".</returns>
    procedure IsBase64ImageEncoder(): Boolean
    begin
        exit(false);
    end;

    /// <summary> 
    /// Event publisher to overule the standard encoding
    /// </summary>
    /// <seealso cref="FontEncoder"/>
    /// <param name="TempBarcodeParameters">Parameter of type Record BarcodeParameters temporary.</param>
    /// <param name="EncodedText">Parameter of type Text.</param>
    /// <param name="IsHandled">Parameter of type Boolean.</param>
    [IntegrationEvent(false, false)]
    local procedure OnBeforeEncodeFont(var TempBarcodeParameters: Record BarcodeParameters temporary; var EncodedText: Text; var IsHandled: Boolean)
    begin
    end;

    /// <summary> 
    /// Event publisher to process the generated encoded text the standard encoding
    /// </summary>
    /// <seealso cref="FontEncoder"/>    
    /// <param name="TempBarcodeParameters">Parameter of type Record BarcodeParameters temporary.</param>
    /// <param name="EncodedText">Parameter of type Text.</param>
    [IntegrationEvent(false, false)]
    local procedure OnAfterEncodeFont(var TempBarcodeParameters: Record BarcodeParameters temporary; var EncodedText: Text)
    begin
    end;

    /// <summary> 
    /// Event publisher to overule the standard validation of the encoding
    /// </summary>
    /// <seealso cref="Base64ImageEncoder"/> 
    /// <param name="TempBarcodeParameters">Parameter of type Record BarcodeParameters temporary.</param>
    /// <param name="InputStringOK">Parameter of type Boolean.</param>
    /// <param name="IsHandled">Parameter of type Boolean.</param>
    [IntegrationEvent(false, false)]
    local procedure OnBeforeValidateInputString(var TempBarcodeParameters: Record BarcodeParameters temporary; var InputStringOK: Boolean; var IsHandled: Boolean)
    begin
    end;

    /// <summary> 
    /// Event publisher to add additional validation to the standard encoding
    /// </summary>
    /// <seealso cref="ValidateInputString"/> 
    /// <param name="TempBarcodeParameters">Parameter of type Record BarcodeParameters temporary.</param>
    /// <param name="InputStringOK">Parameter of type Boolean.</param>
    [IntegrationEvent(false, false)]
    local procedure OnAfterValidateInputString(var TempBarcodeParameters: Record BarcodeParameters temporary; InputStringOK: Boolean)
    begin
    end;

    /// <summary> 
    /// Event publisher to overule the standard encoding
    /// </summary>
    /// <seealso cref="ValidateInputString"/> 
    /// <param name="TempBarcodeParameters">Parameter of type Record BarcodeParameters temporary.</param>
    /// <param name="Base64Image">Parameter of type Text.</param>
    /// <param name="IsHandled">Parameter of type Boolean.</param>
    [IntegrationEvent(false, false)]
    local procedure OnBeforeEncodeBase64Image(var TempBarcodeParameters: Record BarcodeParameters temporary; var Base64Image: Text; var IsHandled: Boolean)
    begin
    end;

    /// <summary> 
    /// Event publisher to process the generated encoded base64 text of the standard encoding
    /// </summary>
    /// <seealso cref="Base64ImageEncoder"/> 
    /// <param name="TempBarcodeParameters">Parameter of type Record BarcodeParameters temporary.</param>
    /// <param name="Base64Image">Parameter of type Text.</param>
    [IntegrationEvent(false, false)]
    local procedure OnAfterEncodeBase64Image(var TempBarcodeParameters: Record BarcodeParameters temporary; var Base64Image: Text)
    begin
    end;
}
