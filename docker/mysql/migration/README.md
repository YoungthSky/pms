# 数据库迁移脚本目录

此目录存放版本升级时的数据库变更脚本。

## 命名规范

```
V{版本号}__{描述}.sql
```

示例：
- `V2.0.0__add_criminal_photo_column.sql`
- `V2.0.0__create_medical_record_table.sql`
- `V2.1.0__add_index_to_archive.sql`

## 执行规则

1. 升级脚本 `upgrade.sh` 会自动查找与目标版本号匹配的 SQL 文件
2. 文件按字母顺序执行
3. 每个文件应当是幂等的（使用 IF NOT EXISTS / IF EXISTS）
4. 执行前会自动备份数据库

## 注意事项

- 不要修改已执行的迁移脚本
- 大表变更建议在低峰期执行
- DDL 语句建议使用 `ALTER TABLE ... IF EXISTS` 等安全写法
