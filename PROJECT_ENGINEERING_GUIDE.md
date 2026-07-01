# Flutter 通用工程文档

## 1. 文档目的

本文档用于约束 Agent 在 Flutter 项目中的初始化、开发、调试、打包与扩展行为。  
目标是让单人开发的项目也具备稳定、清晰、可维护、可扩展的工程结构。

本文档是业务无关的通用工程标准，适用于本地应用，默认支持：

- Android
- Web
- Windows

如后续扩展为在线应用，在本文档基础上增加远程数据层即可，无需推翻整体结构。

---

## 2. 工程目标

- 使用主流、现代、稳定的 Flutter 工程化方案。
- 保持轻流程，不引入过重仪式和无意义模板。
- 所有代码组织以长期维护和 Agent 持续协作为优先。
- 所有基础设施必须在项目初期完成预留：
  - 状态管理
  - 路由
  - 本地存储
  - 国际化
  - 主题切换
  - 日志
  - 错误处理
  - 多环境入口
- 所有新增功能必须遵守统一目录结构和依赖方向。

---

## 3. 非目标

当前阶段默认不做以下事项，除非需求明确提出：

- 不引入复杂 DDD 分层
- 不提前拆分多 package
- 不构建重型 CI/CD 体系
- 不引入多套状态管理方案
- 不引入复杂渠道 flavor 体系
- 不默认接入远程网络层
- 不做与具体业务绑定的目录命名和抽象

---

## 4. 强制技术选型

### 4.1 Flutter 与语言

- Flutter Stable
- Dart Stable
- 默认启用 Web、Windows Desktop 支持

### 4.2 状态管理

- `flutter_riverpod`
- `riverpod_generator`

约束：

- 全局和模块状态统一使用 Riverpod
- 禁止引入 `provider`、`bloc`、`getx` 作为第二套状态方案

### 4.3 路由

- `go_router`

约束：

- 全部路由集中在 `app/router/`
- 禁止页面内散落硬编码路由字符串

### 4.4 本地存储

- 配置型存储：`shared_preferences`
- 结构化数据存储：`drift`

约束：

- 页面层不得直接访问 `shared_preferences` 或数据库
- 存储能力必须通过 service / repository 暴露

### 4.5 数据模型与生成

- `freezed`
- `json_serializable`
- `build_runner`

约束：

- DTO、状态对象、不可变配置对象优先使用生成
- 禁止手写低价值样板代码

### 4.6 国际化

- Flutter 官方 `gen_l10n`

约束：

- 所有面向用户的文本必须进入 `l10n`
- 禁止在页面中直接写硬编码中文或英文文案

### 4.7 日志与错误处理

- `talker_flutter`

约束：

- 全局日志统一入口
- 全局错误统一捕获和映射

### 4.8 工程脚本与模板

- `melos`
- `mason_cli`

约束：

- `melos` 用于统一命令入口
- `mason` 用于生成标准模块骨架
- 即使当前是单应用，也保留未来升级空间

---

## 5. 依赖策略

- 核心依赖只约束方案，不在本文档中固定详细版本号。
- 新项目默认选择当前稳定版，不主动追逐实验性依赖。
- 升级依赖时优先保持主流兼容组合，不单独升级某个核心基础设施造成生态割裂。
- 核心依赖包括但不限于：
  - `flutter_riverpod`
  - `riverpod_annotation`
  - `go_router`
  - `drift`
  - `shared_preferences`
  - `freezed_annotation`
  - `json_annotation`
  - `talker_flutter`
  - `build_runner`
  - `riverpod_generator`
  - `drift_dev`
  - `freezed`
  - `json_serializable`
  - `flutter_gen_runner`
  - `melos`
  - `mason_cli`

---

## 6. 标准目录结构

```text
lib/
  app/                         # 应用装配层，只放启动、路由、主题、环境
    app.dart                   # 应用根组件
    bootstrap/                 # 启动初始化，处理环境、日志、配置恢复
      bootstrap.dart
      app_config.dart
      app_env.dart
    router/                    # 全局路由、守卫、跳转规则
      app_router.dart
      route_guards.dart
    theme/                     # 全局主题与设计令牌
      app_theme.dart
      app_colors.dart
      app_typography.dart
      app_spacing.dart
      app_radius.dart
      app_theme_extension.dart

  core/                        # 基础设施与通用能力，业务无关
    constants/                 # 全局常量
    enums/                     # 通用枚举
    errors/                    # 异常、失败模型、错误映射
      app_exception.dart
      app_failure.dart
      error_mapper.dart
    logging/                   # 日志封装与全局错误接入
      app_logger.dart
      log_observer.dart
    utils/                     # 轻量工具函数，禁止堆砌无边界工具
    extensions/                # 类型扩展
    platform/                  # 平台差异封装，避免平台判断扩散

  l10n/                        # 国际化资源，业务无关的多语言文案入口
    app_en.arb
    app_zh.arb

  data/                        # 数据实现层，负责本地存储和数据转换
    local/                     # 本地数据源，业务无关的存储实现
      prefs/                   # 偏好设置、轻量配置存储
      db/                      # 结构化数据库能力
        app_database.dart
        tables/
        daos/
        converters/
    models/                    # DTO、数据模型，不直接暴露给页面
    repositories/              # 仓储实现，连接 domain 与 data

  domain/                      # 抽象层，放实体、接口、规则，尽量与实现解耦
    entities/                  # 业务抽象实体
    repositories/              # 仓储接口
    usecases/                  # 可选，用于封装明确动作

  features/                    # 功能模块层，按功能拆分，不按技术类型平铺
    settings/                  # 设置模块，建议首批预置语言、主题、应用信息
      presentation/            # 页面、组件、交互展示
      application/             # 状态编排、控制器、动作入口
      domain/                  # 模块内抽象规则
      data/                    # 模块内特定数据实现
    home/                      # 示例功能模块，名称按业务替换
      presentation/
      application/
      domain/
      data/

  shared/                      # 跨功能共享资源，避免重复实现
    widgets/                   # 通用组件
    layouts/                   # 通用布局壳
    providers/                 # 全局共享 Provider，如语言、主题
      locale_provider.dart
      theme_provider.dart
    services/                  # 全局共享服务，如主题、语言配置读写
      locale_service.dart
      theme_service.dart

  gen/                         # 生成代码输出目录

main_development.dart          # 开发环境入口
main_staging.dart              # 预发环境入口
main_production.dart           # 生产环境入口
```

---

## 7. 目录职责约束

- `app/` 只做装配，不写业务实现。
- `core/` 只放通用能力，不得依赖具体 feature。
- `l10n/` 只放国际化资源，不得放业务逻辑。
- `data/` 只负责数据读写与转换，不直接处理页面逻辑。
- `domain/` 放抽象与边界，避免依赖 Flutter UI 细节。
- `features/` 必须按功能建模块，每个模块内再分层。
- `shared/` 只放跨模块复用内容，禁止把业务代码借道塞进来。
- `gen/` 为生成目录，禁止手动修改生成文件。

---

## 8. 分层与依赖方向

强制依赖方向如下：

```text
presentation -> application -> domain
presentation -> shared
application -> domain
data -> domain
app -> core/shared/features
core 不依赖 features
```

补充约束：

- `presentation` 不直接依赖数据库实现
- `presentation` 不直接访问 `shared_preferences`
- `presentation` 不直接创建复杂 service
- `data` 可以依赖 `core`
- `domain` 不依赖 `presentation`
- 跨 feature 调用优先通过共享抽象或共享 service，禁止直接深层耦合

---

## 9. 状态管理规范

### 9.1 默认方案

统一使用 Riverpod。

### 9.2 Provider 规则

- 命名统一为 `xxxProvider`
- 异步场景优先使用 `AsyncNotifier`
- 简单同步状态使用 `Notifier`
- 临时 UI 小状态可以留在 Widget 内部，但不得滥用

### 9.3 状态边界

- 页面展示状态放 `presentation/application`
- 应用级主题、语言、配置类状态放 `shared/providers`
- 仓储和存储对象通过 Provider 注入，不在页面直接 new

### 9.4 异步状态规范

所有异步 UI 必须显式处理：

- loading
- data
- error

不得省略错误态和加载态。

---

## 10. 路由规范

- 统一使用 `go_router`
- 所有路由集中在 `app/router/app_router.dart`
- 所有页面跳转优先基于命名或统一路径常量
- 路由守卫统一放 `route_guards.dart`
- Web 必须支持刷新与深链访问
- 页面初始化逻辑不得替代路由守卫职责

建议包含的基础路由：

- 启动页
- 首页
- 设置页
- 调试页（可选，仅开发环境）

---

## 11. 本地存储规范

### 11.1 配置存储

用于：

- 主题模式
- 语言模式
- 首次启动标记
- 调试开关
- 用户轻量偏好

约束：

- 通过 `theme_service.dart`、`locale_service.dart` 这类 service 统一操作
- 页面不得直接读写配置

### 11.2 结构化存储

用于：

- 列表数据
- 收藏、历史、分类、索引
- 可查询和可迁移的数据

约束：

- 使用 `drift`
- 数据表、DAO、转换器分目录放置
- 数据库访问统一经 repository 暴露

### 11.3 模型职责

- DTO：序列化与数据交换
- Entity：业务抽象
- DB Model / Table：数据库结构

禁止一个类同时承担三种职责。

---

## 12. 国际化规范

- 必须从项目初始就接入 i18n
- 默认支持 `zh_CN`、`en_US`
- 所有用户可见文本必须进入 `arb`
- 语言模式支持：
  - 跟随系统
  - 中文
  - 英文
- 启动时恢复语言设置
- 设置页必须提供语言切换入口

补充约束：

- 路由标题也应走本地化
- 错误提示、弹窗、空状态文案统一本地化
- Key 命名必须语义化，不使用无意义编号

---

## 13. 主题系统规范

- 必须在项目初期接入主题系统
- 主题模式支持：
  - 跟随系统
  - 浅色
  - 深色
- 启动时恢复主题设置
- 设置页必须提供主题切换入口
- 所有颜色、圆角、间距、字体优先走设计令牌
- 不允许在业务页面散落大面积魔法颜色值
- 如后续支持品牌换肤，必须基于 `ThemeExtension` 扩展

---

## 14. 日志与错误处理规范

### 14.1 日志

统一封装 `AppLogger`。

日志分级至少包含：

- debug
- info
- warning
- error

约束：

- 开发环境保留详细日志
- 生产环境只保留必要错误和关键事件
- 页面层不得随意直接 `print`

### 14.2 错误处理

统一处理以下入口：

- `FlutterError.onError`
- `PlatformDispatcher.instance.onError`
- `runZonedGuarded`

统一错误模型：

- `AppException`
- `AppFailure`
- `ErrorMapper`

约束：

- 页面不直接显示原始异常堆栈
- 错误文案需可本地化
- 数据层异常必须转为上层可消费的失败模型

---

## 15. 多环境与入口规范

使用多入口文件：

- `main_development.dart`
- `main_staging.dart`
- `main_production.dart`

入口职责仅包括：

- 选择环境
- 注入配置
- 调用 `bootstrap()`

`bootstrap()` 负责：

- 初始化 Flutter binding
- 初始化日志
- 初始化本地配置
- 恢复主题
- 恢复语言
- 注册全局错误处理
- 注入 Provider 容器
- 启动应用

禁止在 `main_xxx.dart` 中写业务逻辑。

---

## 16. 代码生成规范

允许并推荐以下生成场景：

- Riverpod Provider
- Freezed 不可变模型
- JSON 序列化
- Drift 数据访问
- Assets 资源引用

统一命令：

```bash
dart run build_runner build --delete-conflicting-outputs
dart run build_runner watch --delete-conflicting-outputs
```

约束：

- 不手改生成文件
- 修改模型后立即重新生成
- 提交前确保生成代码同步

---

## 17. 注释规范

- 代码注释统一使用中文
- 注释必须简短、轻量、直接
- 注释主要说明：
  - 职责边界
  - 特殊约束
  - 为什么这样做
  - 平台差异点
- 禁止生成废话注释，如“定义变量”“构建组件”
- 公共基础设施、Provider、Repository、数据库表、路由守卫建议补简短中文注释

---

## 18. Agent 执行规则

### 18.1 必须遵守

- 新功能必须按 `features/功能名/` 建模块
- 新增页面必须接入路由系统
- 新增文本必须接入 i18n
- 新增样式必须兼容浅色和深色主题
- 新增存储能力必须经过 service / repository
- 新增异步状态必须处理 loading / error / data
- 新增公共类和基础设施需要简短中文注释
- 新增依赖必须说明用途，避免重复能力

### 18.2 明确禁止

- 禁止新增第二套状态管理方案
- 禁止把页面写成巨型文件
- 禁止页面直接访问数据库或配置存储
- 禁止在 `shared/` 塞具体业务逻辑
- 禁止将 `core/` 依赖到具体 feature
- 禁止硬编码用户可见文案
- 禁止写死主题颜色而绕过主题系统
- 禁止无边界堆积 `utils`

---

## 19. 初始化步骤

### 19.1 创建项目

```bash
flutter create .
flutter config --enable-web --enable-windows-desktop
```

### 19.2 安装依赖

```bash
flutter pub add flutter_riverpod riverpod_annotation go_router drift shared_preferences freezed_annotation json_annotation talker_flutter
flutter pub add --dev build_runner riverpod_generator drift_dev freezed json_serializable flutter_gen_runner melos mason_cli
```

说明：

- 安装时使用当前稳定版本即可，不在本文档固定具体版本号。
- 如核心依赖之间存在兼容性约束，以当前稳定兼容组合为准。

### 19.3 初始化基础结构

Agent 必须完成：

- 创建标准目录结构
- 创建多入口文件
- 创建 `bootstrap`
- 创建 `app_router`
- 创建主题系统
- 创建语言系统
- 创建日志系统
- 创建本地配置 service
- 创建设置模块
- 配置 `analysis_options.yaml`
- 配置 `l10n`
- 配置 `melos`
- 配置基础 `mason` 模板

---

## 20. 日常开发命令

```bash
flutter pub get
dart run build_runner watch --delete-conflicting-outputs
flutter run -d android
flutter run -d chrome
flutter run -d windows
flutter analyze
dart format .
flutter test
```

要求：

- 开发时保持 `analyze` 无错误
- 修改模型、Provider、数据库、资源后立即生成
- 提交前必须执行格式化、分析、测试

---

## 21. 调试规范

### 21.1 开发调试

优先使用：

- Flutter DevTools
- Riverpod 状态观察
- Talker 日志输出
- 组件 rebuild 与性能观察

### 21.2 调试页建议

允许保留一个仅开发环境可见的调试页，用于：

- 查看当前环境
- 查看主题状态
- 查看语言状态
- 查看本地配置
- 查看日志输出
- 查看数据库基础信息

### 21.3 排查优先级

性能问题优先检查：

- 重复 rebuild
- 大列表渲染
- 图片资源
- 同步阻塞逻辑
- 数据库查询粒度

---

## 22. 打包流程

### 22.1 Android

```bash
flutter build appbundle
flutter build apk --split-per-abi
```

要求：

- 正式版优先 `AAB`
- 配置签名
- 检查版本号、应用名、图标、权限

### 22.2 Web

```bash
flutter build web
```

要求：

- 检查刷新是否正常
- 检查深链路由
- 检查静态资源路径
- 检查缓存策略和基础部署路径

### 22.3 Windows

```bash
flutter build windows
```

要求：

- 检查应用名和版本信息
- 检查窗口图标与基础元数据
- 检查本地存储路径和权限行为

---

## 23. 最小质量门禁

提交前必须通过：

```bash
dart format .
flutter analyze
flutter test
```

测试最低要求：

- 核心逻辑有 unit test
- 关键页面有基础 widget test
- 涉及启动流程、设置切换、数据库迁移时必须补测试

---

## 24. 后续扩展到在线应用时的增量规则

如项目后续接入线上能力，仅新增以下内容：

- `data/remote/`
- 网络客户端
- 认证与 token 管理
- 远程配置
- 崩溃上报
- 埋点
- 离线同步策略

推荐规则：

- 远程层与本地层并列
- Repository 统一聚合远程和本地数据源
- 不改变原有 `features / domain / shared / app` 结构

---

## 25. 交付标准

一个符合本文档的 Flutter 项目，至少应满足以下结果：

- 可直接运行 Android / Web / Windows
- 已接入 Riverpod、go_router、i18n、主题切换、本地配置、日志、错误捕获
- 已具备多入口环境能力
- 已具备统一目录结构
- 已具备基础设置模块
- 已具备生成命令和统一开发命令
- 代码注释为简短中文
- 目录含中文职责说明
- Agent 可基于本文档持续稳定扩展功能
