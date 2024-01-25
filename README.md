# play_music

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

这是一个熟悉flutter 这个流程的项目

# 遍历项目中所有需要翻译的文件
dart run localization_script

# 将需要翻译的文件导出生成excel表
dart run localization_script -f localization.xlsx -d lib/localization

# 将excel表，生成对应的map文件
dart run localization_script
