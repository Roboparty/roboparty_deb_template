---
name: Pull Request
about: 提交代码变更 / Submit a code change
---

<!-- 请勾选类型 / Check the PR type -->
- [ ] 🐛 Bug fix 修复
- [ ] ✨ New feature 新功能
- [ ] 📦 Packaging 打包
- [ ] 📝 Docs 文档
- [ ] 🔧 CI / workflow 变更

## 变更说明 / Description

## 版本检查 / Version check

- [ ] 本次变更不需要改版本号
- [ ] 已更新 debian/changelog
- [ ] 已同步 package.xml
- [ ] changelog 和 package.xml 版本一致

## 测试 / Testing

- [ ] dpkg-buildpackage -us -uc -b 构建通过
- [ ] 已在 [amd64 / arm64] 上测试

> ⚠️ **禁止使用 AI 生成 PR 描述。AI 生成的 PR 将被直接关闭。**
> **Do not use AI-generated PR descriptions.**
