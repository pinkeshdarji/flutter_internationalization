class AppLanguage {
  final String name;
  final String languageCode;

  AppLanguage(this.name, this.languageCode);

  static List<AppLanguage> languages() {
    return <AppLanguage>[
      AppLanguage('English', 'en'),
      AppLanguage('German', 'de'),
      AppLanguage('French', 'fr'),
    ];
  }

  bool operator ==(dynamic other) =>
      other != null && other is AppLanguage && this.name == other.name;

  @override
  int get hashCode => super.hashCode;
}
