# pms-pm 监狱管理模块

## 模块说明

这是 PMS 系统的监狱管理业务模块，用于处理与监狱管理相关的业务逻辑。

## 目录结构

```
pms-pm/
├── src/
│   └── main/
│       ├── java/com/pms/pm/
│       │   ├── domain/          # 实体类
│       │   ├── mapper/          # Mapper 接口
│       │   └── service/         # Service 接口和实现
│       │       └── impl/        # Service 实现类
│       └── resources/mapper/pm/ # MyBatis XML 映射文件
└── pom.xml
```

## 使用示例

### 1. 创建实体类 (domain)

在 `src/main/java/com/pms/pm/domain/` 下创建实体类，例如：

```java
package com.pms.pm.domain;

import com.pms.common.annotation.Excel;
import com.pms.common.core.domain.BaseEntity;

public class Archive extends BaseEntity {
    private Long archiveId;
    
    @Excel(name = "档案编号")
    private String archiveNo;
    
    // getter/setter...
}
```

### 2. 创建 Mapper 接口

在 `src/main/java/com/pms/pm/mapper/` 下创建 Mapper 接口：

```java
package com.pms.pm.mapper;

import com.pms.pm.domain.Archive;
import java.util.List;

public interface ArchiveMapper {
    List<Archive> selectArchiveList(Archive archive);
    Archive selectArchiveById(Long archiveId);
    int insertArchive(Archive archive);
    int updateArchive(Archive archive);
    int deleteArchiveById(Long archiveId);
}
```

### 3. 创建 Mapper XML

在 `src/main/resources/mapper/pm/` 下创建对应的 XML 文件：

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="com.pms.pm.mapper.ArchiveMapper">
    
    <resultMap type="com.pms.pm.domain.Archive" id="ArchiveResult">
        <id property="archiveId" column="archive_id"/>
        <result property="archiveNo" column="archive_no"/>
    </resultMap>
    
    <select id="selectArchiveList" parameterType="com.pms.pm.domain.Archive" resultMap="ArchiveResult">
        SELECT * FROM pm_archive
    </select>
    
</mapper>
```

### 4. 创建 Service 接口

在 `src/main/java/com/pms/pm/service/` 下创建 Service 接口：

```java
package com.pms.pm.service;

import com.pms.pm.domain.Archive;
import java.util.List;

public interface IArchiveService {
    List<Archive> selectArchiveList(Archive archive);
    Archive selectArchiveById(Long archiveId);
    int insertArchive(Archive archive);
    int updateArchive(Archive archive);
    int deleteArchiveById(Long archiveId);
}
```

### 5. 创建 Service 实现类

在 `src/main/java/com/pms/pm/service/impl/` 下创建实现类：

```java
package com.pms.pm.service.impl;

import com.pms.pm.mapper.ArchiveMapper;
import com.pms.pm.domain.Archive;
import com.pms.pm.service.IArchiveService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ArchiveServiceImpl implements IArchiveService {
    
    @Autowired
    private ArchiveMapper archiveMapper;
    
    @Override
    public List<Archive> selectArchiveList(Archive archive) {
        return archiveMapper.selectArchiveList(archive);
    }
    
    // 其他方法实现...
}
```

### 6. 创建 Controller（在 pms-admin 模块）

Controller 应该放在 `pms-admin/src/main/java/com/pms/web/controller/pm/` 目录下：

```java
package com.pms.web.controller.pm;

import com.pms.common.core.controller.BaseController;
import com.pms.common.core.domain.AjaxResult;
import com.pms.pm.domain.Archive;
import com.pms.pm.service.IArchiveService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/pm/archive")
public class ArchiveController extends BaseController {
    
    @Autowired
    private IArchiveService archiveService;
    
    @GetMapping("/list")
    public TableDataInfo list(Archive archive) {
        startPage();
        List<Archive> list = archiveService.selectArchiveList(archive);
        return getDataTable(list);
    }
}
```

## 注意事项

1. **依赖关系**：本模块通过 `pms-framework` 被引入到主应用中
2. **包命名规范**：所有类都应在 `com.pms.pm` 包及其子包下
3. **Mapper XML 位置**：必须放在 `resources/mapper/pm/` 目录下，以便 MyBatis 扫描
4. **Controller 位置**：Controller 应放在 `pms-admin` 模块的 `com.pms.web.controller.pm` 包下
5. **前端页面**：Vue 页面应放在 `pms-ui-js/src/views/pm/` 或 `pms-ui-ts/src/views/pm/` 目录下

## 数据库表命名建议

建议使用 `pm_` 作为表名前缀，例如：
- `pm_archive` - 档案管理表
- `pm_criminal` - 罪犯信息表
- `pm_record` - 流水记录表
