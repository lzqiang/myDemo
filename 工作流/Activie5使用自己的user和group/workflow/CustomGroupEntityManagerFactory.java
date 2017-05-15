
/**  
* Project Name:platform_framework  
* File Name:CustomGroupEntityManagerFactory.java  
* Package Name:com.zwsafety.platform.workflow  
* Date:2015年9月15日
* Copyright (c) 2015,zwsafety All Rights Reserved.   
*/  

package com.zwsafety.platform.workflow;  
import org.activiti.engine.impl.interceptor.Session;
import org.activiti.engine.impl.interceptor.SessionFactory;
import org.activiti.engine.impl.persistence.entity.GroupEntityManager;
import org.activiti.engine.impl.persistence.entity.GroupIdentityManager;
/**  
 * @ClassName:CustomGroupEntityManagerFactory
 * @Description:TODO(Activiti工作流使用自己用户组) 
 * @date:2015年9月15日 
 * @author  lzqiangPC  
 * @version  1.0 
 * @since: JDK 1.7        
 */
public class CustomGroupEntityManagerFactory implements SessionFactory {
    private GroupEntityManager groupEntityManager;

    public void setGroupEntityManager(GroupEntityManager groupEntityManager) {
        this.groupEntityManager = groupEntityManager;
    }

    public Class<?> getSessionType() {
        return GroupIdentityManager.class;
    }

    public Session openSession() {
        return groupEntityManager;
    }
}
  
