LanaPixel
===============
A font for localizing pixel art games
---------------
Most pixel art fonts support a very small set of characters (typically basic Latin, with a few accented characters and Cyrillic if you're lucky), making them unsuitable for use in games that should  be localized. I created LanaPixel to use in my own games, but since this is a common problem, I've decided to make it available to the public.

LanaPixel contains approximately 19k characters, with support for most modern European languages (Latin, Greek, Cyrillic), Turkish (Latin), and Korean (Hangul), good support for Japanese and Simplified Chinese, and decent support for Traditional Chinese. The Latin, Greek, and Cyrillic characters have kerning.

This is a pixel font, designed to be displayed at 11px and multiples thereof. The actual character dimensions vary, but they are all designed to look nice together. The CJK characters are 9x9 pixels, the Latin characters have a cap-height of 7px and an x-height of 5px. The font is a TTF for maximum compatibility with game engines, and includes both bitmaps and outlines.

Most of the outlines are courtesy of chimeforest (https://github.com/chimeforest), derived from the PNG generated from the original bitmap font by @LorenLemcke on Twitter.

Coverage details
---------------
Latin:

- Basic Latin
- Latin-1 Supplement
- Latin Extended-A
- *Partial* Latin-Extended-B (Romanian consonants and vowels used in modern Slavic languages)
- Latin Ligatures
- Latin Full Width Forms

Greek:

- Greek
- *Partial* Greek Extended (miniscule vowels with some of the simpler diacritics)

Cyrillic:

- *Partial* Cyrillic (Full support for Russian, Ukrainian, Serbian, Bulgarian, and probably others, but very limited support for historical characters and Cyrillic characters used for non-Slavic languages)

CJK:

- Hiragana, Katakana (except a couple of symbols used only for vertical writing)
- Katakana Half Width Forms
- *Partial* CJK Symbols and Punctuation (all punctuation and Suzhou numerals)
- CJK Half-Width punctuation
- Approximately 6970 hanzi/kanji in the CJK Unified Ideographs and Extension A blocks
	- All JIS Level 1 kanji and a large selection of Level 2 kanji. This includes all Jōyō kanji and many additional kanji.
	- Most common 3000 Simplified Chinese characters, plus a bunch of extras
	- Most common 1000 Traditional Chinese characters, plus a bunch of extras, but excluding a few that are found in Extension B
	- The appearance of the characters that are written differently in Chinese and Japanese skews towards Japanese, as I am more familiar with that language.
- Bopomofo
- Bopomofo Extended

Hangul (Note: Hangul is excluded from the "NoKorean" version of the font):

- Hangul Syllables (modern Korean; trivia: this block comprises 11k of the 19k glyphs in this font, which is why a version without it is available)

Miscellaneous:

- *Partial* IPA Extensions (ɑ, ɒ, ə, ʊ, ʔ)
- *Partial* General Punctuation (dashes and various quotes)
- *Partial* Arrows (the basic 8-directional arrows)
- *Partial* Miscellaneous Symbols (checkboxes, astrological symbols, card suits, music notes)
- Half Width Symbol Variants (half-width arrows)
- Runic (I focused on modern languages for this font, but I can't resist runes)
- Special symbols in the Private Use Area representing various controller inputs, in outline and filled styles. See the accompanying controllerbuttons.html file for a table of them.

East Asian localization caveat
---------------
The small size inevitably leads to legibility issues for more complex characters, such as some Chinese characters. To make sure your game remains legible, you should make your localizer aware of the small resolution of the text and ask them to favour wordings that use visually simpler characters. In the case of Japanese, hard-to-read kanji can usually be replaced with their kana readings.

The same goes for Korean. Closed syllables with R/L (e.g. 를 reul) are particularly hard to read at this size (and even some larger sizes!) and are best used sparingly.

Support me
---------------
This font is completely free, including for commercial use, but if you find it useful and have the money to spare, I wouldn't say no to a few bucks! https://ko-fi.com/eishiya


License
---------------
LanaPixel font (c) 2020-2022, eishiya (https://mastodon.art/@eishiya)

You may choose either one of these two licences for this font:

- The SIL Open Font License, the full text of which can be found in the LanaPixel_OpenFontLicense.txt file.
- CC-BY 4.0, the full text of which can be found in the LanaPixel_CC-BYLicense.txt file.

The licenses are provided as separate files for easy drop-in into your game's licences list.

tl;dr:

- You *can* use this font for free, even in commercial projects.
- You *can* modify this font to suit your needs.
- You *can* distribute this font and modifications of it with your games.
	- If you do, you must include the above copyright notice somewhere with your game, but it doesn't have to be in the game credits, it can just be in the game files somewhere.
	- If you're using the OFL, just copy the license file wherever you have your other licences and you're good to go.
	- If you're using CC-BY, you need to include a notice that the font is licenced under CC-BY 4.0 and the disclaimer of warranties. Copying the included file *should* suffice for that.
	- Honestly though, I'm not going to be strict about this bit, just don't be a dick, and don't claim others' work as your own.
- You *cannot* sell this font on its own, even if you have modified it.