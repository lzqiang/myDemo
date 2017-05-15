/**  
 * Project Name:platform_framework  
 * File Name:CustomGroupEntityManager.java  
 * Package Name:com.zwsafety.platform.workflow  
 * Date:2015年9月15日
 * Copyright (c) 2015,zwsafety All Rights Reserved.   
 */

package com.zwsafety.platform.workflow;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.activiti.engine.identity.Group;
import org.activiti.engine.impl.persistence.entity.GroupEntity;
import org.activiti.engine.impl.persistence.entity.GroupEntityManager;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.jdbc.core.JdbcTemplate;

/**
 * @ClassName:CustomGroupEntityManager
 * @Description:TODO(Activiti工作流使用自己用户组)
 * @date:2015年9月15日
 * @author lzqiangPC
 * @version 1.0
 * @since: JDK 1.7
 */
public class CustomGroupEntityManager extends GroupEntityManager {
    private static Logger logger = LoggerFactory
            .getLogger(CustomGroupEntityManager.class);
    private JdbcTemplate jdbcTemplate;

    @Override
    public List<Group> findGroupsByUser(String userId) {
        logger.debug("findGroupsByUser : {}", userId);
        
        String sql = "SELECT r.`roleId` AS id,r.`roleName` AS NAME FROM sys_user u LEFT JOIN lk_user_role ur ON u.`userId` = ur.`userId` "+
                     "LEFT JOIN sys_role r ON r.`roleId` = ur.`roleId` WHERE u.`userId` = ? ";
        List<Map<String, Object>> list = jdbcTemplate.queryForList(sql, userId);
        List<Group> groups = new ArrayList<Group>();

        for (Map<String, Object> map : list) {
            String name = (String) map.get("name");
            String id = (String) map.get("id");
            GroupEntity groupEntity = new GroupEntity();
            groupEntity.setId(id);
            groupEntity.setName(name);
            groups.add(groupEntity);
        }

        return groups;
    }

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }
}
