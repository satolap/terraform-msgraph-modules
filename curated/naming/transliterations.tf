locals {
  # The built-in table of the ascii filter. It covers the letters with
  # diacritics of Latin-1 Supplement and Latin Extended-A, and the comma-below
  # letters Ș and Ț of Latin Extended-B, so that a name keeps
  # the base letter instead of losing the whole letter. Terraform normalizes
  # strings to NFC, so a base letter followed by a combining mark arrives as
  # the precomposed letter and is found here. The ascii filter drops every
  # other character outside ASCII.
  default_transliterations = {
    "À" = "A", "Á" = "A", "Â" = "A", "Ã" = "A", "Ä" = "A", "Å" = "A", "Ā" = "A", "Ă" = "A", "Ą" = "A"
    "à" = "a", "á" = "a", "â" = "a", "ã" = "a", "ä" = "a", "å" = "a", "ā" = "a", "ă" = "a", "ą" = "a"
    "Æ" = "AE", "æ" = "ae"
    "Ç" = "C", "Ć" = "C", "Ĉ" = "C", "Ċ" = "C", "Č" = "C"
    "ç" = "c", "ć" = "c", "ĉ" = "c", "ċ" = "c", "č" = "c"
    "Ď" = "D", "Đ" = "D", "Ð" = "D"
    "ď" = "d", "đ" = "d", "ð" = "d"
    "È" = "E", "É" = "E", "Ê" = "E", "Ë" = "E", "Ē" = "E", "Ĕ" = "E", "Ė" = "E", "Ę" = "E", "Ě" = "E"
    "è" = "e", "é" = "e", "ê" = "e", "ë" = "e", "ē" = "e", "ĕ" = "e", "ė" = "e", "ę" = "e", "ě" = "e"
    "Ĝ" = "G", "Ğ" = "G", "Ġ" = "G", "Ģ" = "G"
    "ĝ" = "g", "ğ" = "g", "ġ" = "g", "ģ" = "g"
    "Ĥ" = "H", "Ħ" = "H"
    "ĥ" = "h", "ħ" = "h"
    "Ì" = "I", "Í" = "I", "Î" = "I", "Ï" = "I", "Ĩ" = "I", "Ī" = "I", "Ĭ" = "I", "Į" = "I", "İ" = "I"
    "ì" = "i", "í" = "i", "î" = "i", "ï" = "i", "ĩ" = "i", "ī" = "i", "ĭ" = "i", "į" = "i", "ı" = "i"
    "Ĳ" = "IJ", "ĳ" = "ij"
    "Ĵ" = "J", "ĵ" = "j"
    "Ķ" = "K", "ķ" = "k", "ĸ" = "k"
    "Ĺ" = "L", "Ļ" = "L", "Ľ" = "L", "Ŀ" = "L", "Ł" = "L"
    "ĺ" = "l", "ļ" = "l", "ľ" = "l", "ŀ" = "l", "ł" = "l"
    "Ñ" = "N", "Ń" = "N", "Ņ" = "N", "Ň" = "N", "Ŋ" = "N"
    "ñ" = "n", "ń" = "n", "ņ" = "n", "ň" = "n", "ŉ" = "n", "ŋ" = "n"
    "Ò" = "O", "Ó" = "O", "Ô" = "O", "Õ" = "O", "Ö" = "O", "Ø" = "O", "Ō" = "O", "Ŏ" = "O", "Ő" = "O"
    "ò" = "o", "ó" = "o", "ô" = "o", "õ" = "o", "ö" = "o", "ø" = "o", "ō" = "o", "ŏ" = "o", "ő" = "o"
    "Œ" = "OE", "œ" = "oe"
    "Ŕ" = "R", "Ŗ" = "R", "Ř" = "R"
    "ŕ" = "r", "ŗ" = "r", "ř" = "r"
    "Ś" = "S", "Ŝ" = "S", "Ş" = "S", "Š" = "S", "Ș" = "S"
    "ś" = "s", "ŝ" = "s", "ş" = "s", "š" = "s", "ș" = "s", "ſ" = "s"
    "ß" = "ss"
    "Ţ" = "T", "Ť" = "T", "Ŧ" = "T", "Ț" = "T"
    "ţ" = "t", "ť" = "t", "ŧ" = "t", "ț" = "t"
    "Þ" = "TH", "þ" = "th"
    "Ù" = "U", "Ú" = "U", "Û" = "U", "Ü" = "U", "Ũ" = "U", "Ū" = "U", "Ŭ" = "U", "Ů" = "U", "Ű" = "U", "Ų" = "U"
    "ù" = "u", "ú" = "u", "û" = "u", "ü" = "u", "ũ" = "u", "ū" = "u", "ŭ" = "u", "ů" = "u", "ű" = "u", "ų" = "u"
    "Ŵ" = "W", "ŵ" = "w"
    "Ý" = "Y", "Ŷ" = "Y", "Ÿ" = "Y"
    "ý" = "y", "ŷ" = "y", "ÿ" = "y"
    "Ź" = "Z", "Ż" = "Z", "Ž" = "Z"
    "ź" = "z", "ż" = "z", "ž" = "z"
  }
}
