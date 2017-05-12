package com.ttpai.boss.activiti.test;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import org.activiti.engine.ActivitiException;
import org.activiti.engine.ManagementService;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.task.Task;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * @author tianlong
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:/applicationContext.xml", "classpath:/applicationContext_dubbo.xml", "classpath:/applicationContext-jade.xml", "classpath:/applicationContext-rose.xml", "classpath:/activiti.xml"})
public class ActivitiTest {
    
    @Autowired
    private RepositoryService repositoryService;
    @Autowired
    private RuntimeService runtimeService;
    @Autowired
    private TaskService taskService;
    @Autowired
    private ManagementService managementService;

    
    @Test
    public void deploy(){
        repositoryService.createDeployment().addClasspathResource("com/ttpai/boss/activiti/test/VacationRequest.bpmn20.xml").deploy();
        System.out.println("Number of process definitions:" + 
        repositoryService.createDeploymentQuery().count());
    }
    
    @Test
    public void testTask(){
        Map<String, Object> variables = new HashMap<String, Object>();
        variables.put("employeeName", "Kermit");
        variables.put("numberOfDays", new Integer(4));
        variables.put("vacationMotivation", "I'm really tired!");
        runtimeService.startProcessInstanceByKey("vacationRequest", variables);
        System.out.println("Number of process instances:" + runtimeService.createProcessInstanceQuery().count());
    }
    
    @Test
    public void printTask(){
        List<Task> list = taskService.createTaskQuery().taskCandidateGroup("management").list();
        for(Task task:list){
            System.out.println("Task available:" + task.getName());
        }
    }
    
    @Test
    public void finishTask(){
        List<Task> list = taskService.createTaskQuery().taskCandidateGroup("management").list();
        Task task = list.get(0);
        Map<String, Object> variables = new HashMap<String, Object>();
        variables.put("vacationApproved", "false");
        variables.put("managerMotivation", "We have a tight deadline!");
        taskService.complete(task.getId(), variables);
    }
    
    @Test
    public void suspendProcessDefinition(){
        repositoryService.suspendProcessDefinitionByKey("vacationRequest");
        try{
            runtimeService.startProcessInstanceByKey("vacationRequest");
        } catch (ActivitiException e){
            e.printStackTrace();
        }
    }
    
    @Test
    public void activateProcessDefinition(){
        repositoryService.activateProcessDefinitionByKey("vacationRequest");
    }
    
    @Test
    public void suspendProcessInstance(){
        runtimeService.suspendProcessInstanceById("2501");
        try{
            taskService.complete("17505");
        } catch (ActivitiException e){
            e.printStackTrace();
        }
    }
    
    @Test
    public void activateProcessInstance(){
        runtimeService.activateProcessInstanceById("2501");
    }
    
    @Test
    public void queryApiTest1(){
        List<Task> list = taskService.createTaskQuery().taskAssignee("Kermit").processVariableValueEquals("vacationApproved", "false").orderByDueDate().asc().list();
        for(Task task:list){
            System.out.println(task.getName());
        }
    }
    
    @Test
    public void queryApiTest2(){
        List<Task> list = taskService.createNativeTaskQuery().sql("select * from " + managementService.getTableName(Task.class) + " t where t.NAME_=#{taskName}").parameter("taskName", "Adjust vacation request").list();
        for(Task task:list){
            System.out.println(task.getName());
        }
    }
    
    @Test
    public void testSetVariable(){
        runtimeService.setVariable("2501", "instance", "instance");
        runtimeService.setVariableLocal("2501", "instancelocal", "instancelocal");
        taskService.setVariable("17505", "task", "task");
        taskService.setVariableLocal("17505", "tasklocal", "tasklocal");
        System.out.println("|||__||| variable finish!!!");
    }
    
    @Test
    public void testGetVariable(){
//        Map<String, Object> map = runtimeService.getVariablesLocal("2501");
//        Set<Entry<String, Object>> entrySet = map.entrySet();
//        for(Entry entry : entrySet){
//            System.out.println(entry.getKey() + ":" + entry.getValue());
//        }
        Map<String, Object> map = taskService.getVariablesLocal("17505");
        Set<Entry<String, Object>> entrySet = map.entrySet();
        for(Entry entry : entrySet){
            System.out.println(entry.getKey() + ":" + entry.getValue());
        }
    }
    
    public static void main(String[] args){
        ActivitiTest test = new ActivitiTest();
        test.deploy();
    }
    
}
