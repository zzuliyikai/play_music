import 'dart:convert';
import 'dart:io';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class ResCacheManager {
  static final dio = Dio();

  /// 资源存放目录
  static const String relativePath = 'res_cache';

  /// 资源最大存放数量
  static const int cacheSize = 1000 * 1000 * 30;

  static Future<String?> download(String url, String suffix) async {
    // 获取应用程序的本地文件系统目录
    final Directory appDirectory = await getApplicationDocumentsDirectory();
    // 目标目录的相对路径
    Directory resCacheDir = Directory('${appDirectory.path}/$relativePath');

    // 检查目录是否已经存在
    if (!resCacheDir.existsSync()) {
      // 如果目录不存在，则创建目录
      resCacheDir.createSync(recursive: true);
    }

    // 如果缓存中存在直接返回文件路径
    List<FileSystemEntity> files = resCacheDir.listSync();
    for (FileSystemEntity element in files) {
      if (_getFileName(element).contains(_stringToMD5(url))) {
        return element.path;
      }
    }

    if (_getFileDirSize(files) < cacheSize) {
      // 执行下载逻辑
      return _downloadRaw(url, resCacheDir, suffix);
    } else {
      // 获取文件访问时间并进行排序 LRU算法进行删除
      files.sort((a, b) {
        // 获取文件a的访问时间
        DateTime aAccessTime = (a.statSync().accessed);

        // 获取文件b的访问时间
        DateTime bAccessTime = (b.statSync().accessed);

        // 按访问时间降序排列
        return bAccessTime.compareTo(aAccessTime);
      });

      // 删除文件 递归调用次方法
      _deleteFileUtilsIdleSpace(files);

      // 执行下载逻辑
      return _downloadRaw(url, resCacheDir, suffix);
    }
  }

  static void removeAllFile() async {
    // 获取应用程序的本地文件系统目录
    final Directory appDirectory = await getApplicationDocumentsDirectory();
    _deleteDirectory('${appDirectory.path}/$relativePath');
  }

  // 定义一个函数用于计算字符串的MD5哈希值
  static String _stringToMD5(String input) {
    // 将字符串转换为UTF-8编码的字节数组
    var content = utf8.encode(input);
    // 使用MD5算法生成摘要
    var digest = md5.convert(content);
    // 将摘要转换为十六进制字符串并返回
    return hex.encode(digest.bytes);
  }

  static double _getFileDirSize(List<FileSystemEntity> files) {
    // 记录总文件大小
    double totalSize = 0;
    // 遍历文件列表并累计文件大小
    for (FileSystemEntity file in files) {
      // 检查是否是文件
      if (file is File) {
        totalSize += file.lengthSync();
      }
    }
    return totalSize;
  }

  static void _deleteFileUtilsIdleSpace(List<FileSystemEntity> files) {
    File lastFile = files.last as File;
    lastFile.deleteSync();
    files.removeAt(files.length - 1);
    if (_getFileDirSize(files) > cacheSize) {
      _deleteFileUtilsIdleSpace(files);
    }
  }

  static Future<String?> _downloadRaw(
      String url, Directory resCacheDir, String suffix) async {
    final String localPath = '${resCacheDir.path}/${_stringToMD5(url)}.$suffix';

    try {
      // 发起下载请求
      Response response = await dio.download(url, localPath);

      if (response.statusCode == 200) {
        return localPath;
      } else {
        throw Exception(
            'response.statusCode != 200  statusCode == ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('e.message = $e');
    }
  }

  static String _getFileName(FileSystemEntity entity) {
    // 使用uri属性获取文件路径，并调用pathSegments获取路径的部分
    List<String> pathSegments = entity.uri.pathSegments;

    // 返回路径中的最后一个部分，即文件或目录的名称
    return pathSegments.isNotEmpty ? pathSegments.last : '';
  }

  static void _deleteDirectory(String path) {
    // 创建目录对象
    Directory directory = Directory(path);

    // 如果目录存在
    if (directory.existsSync()) {
      // 获取目录中的内容列表
      List<FileSystemEntity> contents = directory.listSync();

      // 遍历目录中的内容
      for (FileSystemEntity content in contents) {
        if (content is File) {
          // 如果是文件，则删除文件
          content.deleteSync();
        } else if (content is Directory) {
          // 如果是目录，则递归删除目录及其内容
          _deleteDirectory(content.path);
        }
      }
      // 删除空目录
      directory.deleteSync();
    }
  }
}
