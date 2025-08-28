enum ThemeStrategy { alwaysLight, alwaysDark, system }

enum SupportedLanguage {
  english('en', 'US', 'i18n.english.us'),
  chinese('zh', 'CN', 'i18n.chinese.cn');

  final String languageCode;
  final String countryCode;
  final String i18nKey;

  const SupportedLanguage(this.languageCode, this.countryCode, this.i18nKey);
}
