package com.zwsafety.platform.workflow;


/**  
* Project Name:platform_activiti  
* File Name:WorkFlowService.java  
* Package Name:com.zwsafety.platform.activiti.service.impl  
* Date:2015年9月9日
* Copyright (c) 2015,zwsafety All Rights Reserved.   
*/  


import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipInputStream;

import org.activiti.bpmn.model.BpmnModel;
import org.activiti.engine.FormService;
import org.activiti.engine.HistoryService;
import org.activiti.engine.ManagementService;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.form.TaskFormData;
import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.history.HistoricProcessInstanceQuery;
import org.activiti.engine.history.HistoricTaskInstance;
import org.activiti.engine.impl.Page;
import org.activiti.engine.impl.identity.Authentication;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.activiti.engine.impl.pvm.PvmActivity;
import org.activiti.engine.impl.pvm.PvmTransition;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.Model;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.runtime.ProcessInstanceQuery;
import org.activiti.engine.task.Comment;
import org.activiti.engine.task.Task;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**  
 * @ClassName:WorkFlowAPI
 * @Description:工作流api 
 * @date:2015年9月9日 
 * @author  lzqiangPC  
 * @version  1.0 
 * @since: JDK 1.7        
 */
@Service("workFlowAPI")
public class WorkFlowAPI {
    
    private static final String USER_TASK = "userTask";
    private static final String DEFAULTOUTCOME = "提交";
/*************************************************************************************/
    @Autowired
    private RepositoryService repositoryService;
    @Autowired
    private RuntimeService runtimeService;
    @Autowired
    private TaskService taskService;
    @Autowired
    private FormService formService;
    @Autowired
    private HistoryService historyService;
    @Autowired
    private ManagementService managementService;
/***************************************************************************************/
    /**
     * @Title:saveNewDeploye
     * @Description TODO 部署流程
     * @date  2015年9月9日 
     * @author lzqiangPC  
     * @param inputStream zip压缩包，流程图和流程xml
     * @param filename 部署的名称
      */
     public void deployment(InputStream inputStream,String filename){
         try{
             ZipInputStream zipInputStream = new ZipInputStream(inputStream);
             repositoryService.createDeployment()//创建一个部署对象
                              .name(filename)//添加部署名称
                              .addZipInputStream(zipInputStream)
                              .deploy();//完成部署;
         }catch(Exception e){
             e.printStackTrace();
         }
     }
    
    /**
    * @Title:saveNewDeploye
    * @Description TODO 部署流程
    * @date  2015年9月9日 
    * @author lzqiangPC  
    * @param file zip压缩包，流程图和流程xml
    * @param filename 部署的名称
     */
    public Deployment deployment(File file, String filename){
        try{
            ZipInputStream zipInputStream = new ZipInputStream(new FileInputStream(file));
            return repositoryService.createDeployment()//创建一个部署对象
                             .name(filename)//添加部署名称
                             .addZipInputStream(zipInputStream)
                             .deploy();//完成部署;
        }catch(Exception e){
            e.printStackTrace();
        }
        return null;
    }
    /**
    * @Title:deployment
    * @Description TODO 部署流程，流程名称使用的是文件名称
    * @date  2015年9月9日 
    * @author lzqiangPC  
    * @param file zip压缩包，流程图和流程xml
     */
    public Deployment deployment(File file){
        String filename = file.getName();
        return deployment(file,filename);
    }
    /**
     * 流程部署
     */
    public Deployment deployment(String deploymentName,String resourcename,BpmnModel model) throws RuntimeException{
        try{
            return repositoryService.createDeployment().name(deploymentName).addBpmnModel(resourcename, model).deploy();
        }catch(Exception e){
            throw new RuntimeException(e);
        }
    }
    
    /**
    * @Title:findDeploymentList
    * @Description TODO(查询部署对象信息按部署实践asc升序排列  对应表(act_re_deployment);). 
    * @date  2015年9月9日 
    * @author lzqiangPC  
    * @return List<Deployment>
     */
    public  List<Deployment> findDeploymentList(){
        List<Deployment> list = repositoryService.createDeploymentQuery()//创建部署对象查询
                .orderByDeploymenTime()
                .asc()
                .list();
        return list;
    }
    /**
    * @Title:findDeploymentByDeploymentId
    * @Description TODO(根据deploymentId获取Deployment对象). 
    * @date  2015年9月10日 
    * @author lzqiangPC  
    * @param deploymentId
    * @return
     */
    public Deployment findDeploymentByDeploymentId(String deploymentId){
        return repositoryService.createDeploymentQuery().deploymentId(deploymentId).singleResult();
    }
    /**
    * @Title:findProcessDefinitionByPdId
    * @Description TODO(根据processDefinitionId获取ProcessDefinition对象). 
    * @date  2015年9月11日 
    * @author lzqiangPC  
    * @param processDefinitionId
    * @return
     */
    public ProcessDefinition findProcessDefinitionByPdId(String processDefinitionId){
         return  repositoryService.createProcessDefinitionQuery().processDefinitionId(processDefinitionId).singleResult();
    }
    
    /**
    * @Title:findProcessDefinitionListPage
    * @Description TODO(分页查询流程定义). 
    * @date  2015年9月10日 
    * @author lzqiangPC  
    * @param pageNo 第几页
    * @param pageSize 每页显示多少条数据
    * @return
     */
    public List<ProcessDefinition> findProcessDefinitionListPage(int startPage,int endPage){
        return repositoryService.createProcessDefinitionQuery()
                                .orderByProcessDefinitionName()
                                .orderByProcessDefinitionVersion()
                                .desc()
                                .listPage(startPage,endPage);
    }
    /**
    * @Title:findProcessDefinitionListCount
    * @Description TODO(ProcessDefinition总数). 
    * @date  2015年9月10日 
    * @author lzqiangPC  
    * @return
     */
    public long findProcessDefinitionListCount(){
        return repositoryService.createProcessDefinitionQuery().count();
    }
    
    /**
    * findResourceInputStream
    * @Description TODO( 获取流程图的InputStream 根据部署对象Id和图片名称 获取资源的输入流). 
    * @date  2015年9月9日 
    * @author lzqiangPC  
    * @param deploymentId 部署对象id
    * @param resourceName 资源名称
    * @return
     */
    public InputStream findResourceInputStream(String deploymentId,
            String resourceName) {
        return  repositoryService.getResourceAsStream(deploymentId,resourceName);
    }
    /**
    * @Title:findImageInputStream
    * @Description TODO( 获取流程图的InputStream 根据部署对象Id获取图片的输入流). 
    * @date  2015年9月9日 
    * @author lzqiangPC  
    * @param deploymentId 部署对象id
    * @return
     */
    public InputStream findImgInputStream(String deploymentId){
        List<String> resourceNames = repositoryService.getDeploymentResourceNames(deploymentId);
        for(String name:resourceNames){
            if(name.endsWith("png")){
                return findResourceInputStream(deploymentId,name);
            }
        }
        return null;
    }
    
    /**
     * @Title:findImageInputStream
     * @Description TODO( 获取流程图的InputStream 根据部署对象Id获取XML的输入流). 
     * @date  2015年9月9日 
     * @author lzqiangPC  
     * @param deploymentId 部署对象id
     * @return
      */
     public InputStream findXMLInputStream(String deploymentId){
         List<String> resourceNames = repositoryService.getDeploymentResourceNames(deploymentId);
         for(String name:resourceNames){
             if(name.endsWith("bpmn") || name.endsWith("xml")){
                 return findResourceInputStream(deploymentId,name);
             }
         }
         return null;
     }

    /**
    * @Title:deleteProcessDefinitionbyDeploymentId
    * @Description TODO(使用部署对象Id,删除流程定义). 
    * @date  2015年9月9日 
    * @author lzqiangPC  
    * @param deploymentId
     */
    public void deleteProcessDefinitionbyDeploymentId(String deploymentId) {
        repositoryService.deleteDeployment(deploymentId,true);//true级联删除
    }
    /**
    * @Title:deleteProcessDefinitionByProcessDefintionId
    * @Description TODO(使用流程定义id,删除流程定义). 
    * @date  2015年9月11日 
    * @author lzqiangPC  
    * @param processDefinitionId
     */
    public void deleteProcessDefinitionByProcessDefintionId(String processDefinitionId){
        ProcessDefinition pd = findProcessDefinitionByPdId(processDefinitionId);
        deleteProcessDefinitionbyDeploymentId(pd.getDeploymentId());
    }

    /**
    * @Title:findTaskListByAssignee
    * @Description TODO(根据查询assignee当前执行的任务). 
    * @date  2015年9月9日 
    * @author lzqiangPC  
    * @param assignee 办理人
    * @return List<Task>
     */
    public List<Task> findTaskListByAssignee(String assignee) {
        List<Task> list = taskService.createTaskQuery()
                   .taskAssignee(assignee)//指定个人任务查询
                   .orderByTaskCreateTime()
                   .desc()
                   .list();
        return list;
    }
    
    /**
    * @Title:findTaskCandidateOrAssigned
    * @Description TODO(查询候选组任务). 
    * @date  2015年9月18日 
    * @author lzqiangPC  
    * @param candidateGroup 用户id
    * @return
     */
    public List<Task> findTaskCandidateGroup(String userid){
        List<Task> list = taskService.createTaskQuery()
                           .taskCandidateUser(userid)
                           .orderByTaskCreateTime()
                           .desc()
                           .list();
        return list;
                    
    }
    
    /**
    * @Title:findTaskFormKeyByTaskId
    * @Description TODO(使用任务id获取当前任务节点中对应Form Key对应的值). 
    * @date  2015年9月9日 
    * @author lzqiangPC  
    * @param taskid 任务id
    * @return form key对应的值
     */
    public String findTaskFormKeyByTaskId(String taskid) {
        TaskFormData taskFormData = formService.getTaskFormData(taskid);
        String formKey = taskFormData.getFormKey();
        return formKey;
    }

    /**
    * @Title:findBuindessKeyByTaskId
    * @Description TODO(使用任务id获取buindess_key). 
    * @date  2015年9月9日 
    * @author lzqiangPC  
    * @param taskId
    * @return buindess_key
     */
    public String findBuindessKeyByTaskId(String taskId) {
        Task task = findTaskByTaskId(taskId);
        String processInstanceId = task.getProcessInstanceId();
        ProcessInstance pi = findProcessInstanceByPIid(processInstanceId);
        
        String buindess_key = pi.getBusinessKey();
        return buindess_key;
    }
    /**
     * 
    * @Title:findVariableValueByTaskId
    * @Description TODO 根据任务id和变量名称获取变量值
    * @date  2015年9月9日 
    * @author lzqiangPC  
    * @param taskId 任务id
    * @param variableName 流程变量名称
    * @return
     */
    public String findVariableValueByTaskId(String taskId,String variableName){
        String variableValue = (String) taskService.getVariable(taskId,variableName);
        return variableValue;
    }
    
    /**
    * @Title:findOutComeListByTaskId
    * @Description TODO( 查询连线名称集合). 
    * @date  2015年9月9日 
    * @author lzqiangPC  
    * @param taskId
    * @return
     */
    public  List<String> findOutComeListByTaskId(String taskId){
        return findOutComeListByTaskId(taskId,null);
    }
    
    /**
     * @Title:findOutComeListByTaskId
     * @Description TODO( 查询连线名称集合). 
     * @date  2015年9月9日 
     * @author lzqiangPC  
     * @param taskId 任务id
     * @param defaultName:如果该线没有名称，显示默认名称
     * @return
      */
    public  List<String> findOutComeListByTaskId(String taskId,String defaultName){
        try{
            if(StringUtils.isBlank(defaultName)){
                defaultName=DEFAULTOUTCOME;
            }
            ActivityImpl activityImpl = findActivitiImplByTaskId(taskId);
            //获取当前活动完成之后连线的名称
            return getOutComeList(activityImpl,defaultName);
        }catch(Exception e){
            e.printStackTrace();
        }
        return null;
    }
    
    public List<String> getOutComeList(PvmActivity pvmActivity,String defaultName){
        //获取当前活动完成之后连线的名称
        List<PvmTransition> pvmTransitionList = pvmActivity.getOutgoingTransitions();
        List<String> list = new ArrayList<String>();
        if(pvmTransitionList != null && pvmTransitionList.size()>0){
            for(PvmTransition pvmTransition:pvmTransitionList){
               PvmActivity ac = pvmTransition.getDestination();
               if(ac.getProperty("type").equals("exclusiveGateway")){
                   list.addAll(getOutComeList(ac,defaultName));
               }else{
                    String name = (String) pvmTransition.getProperty("name");
                    if(StringUtils.isNotBlank(name)){
                        list.add(name);
                    }else{
                        list.add(defaultName);
                    }
               }
            }
        }
        return list;
    }
    
    /**
    * @Title:findActivitiImplByTaskId
    * @Description TODO(根据TaskId获取ActivitiImpl). 
    * @date  2015年9月24日 
    * @author lzqiangPC  
    * @param taskId
    * @return
     */
    private ActivityImpl findActivitiImplByTaskId(String taskId) {
        //1.使用任务ID查询任务对象
        Task task = findTaskByTaskId(taskId);
        //获取流程定义Id
        String processDefinitionId = task.getProcessDefinitionId();
        //查询流程定义的实体对象processDefinitionEntity
        //ProcessDefinitionEntity extends ProcessDefinitionImpl implements ProcessDefinition
        ProcessDefinitionEntity processDefinitionEntity = (ProcessDefinitionEntity) repositoryService.getProcessDefinition(processDefinitionId);
        //获取流程实例Id
        String processInstanceId = task.getProcessInstanceId();
        //获取流程实例对象
        ProcessInstance pi = findProcessInstanceByPIid(processInstanceId);
        //获取当前活动的Id
        String activityId = pi.getActivityId();
        //获取当前的活动
        ActivityImpl activityImpl = processDefinitionEntity.findActivity(activityId);
        return activityImpl;
    }
    
    /**
    * @Title:findCommentByTaskId
    * @Description TODO(获取批注信息 传递的是当前任务id 获取历史任务id对应的批注). 
    * @date  2015年9月9日 
    * @author lzqiangPC  
    * @param taskId
    * @return List<Comment>
     */
    public  List<Comment> findCommentByTaskId(String taskId){
        List<Comment> list = new ArrayList<Comment>();
        //使用当前的任务id 查询当前流程对应的历史任务id
        //使用当前任务id 获取任务对象
        Task task = findTaskByTaskId(taskId);
        //获取流程实例id
        String processInstanceId = task.getProcessInstanceId();
        //或者使用流程实例id查询
        list = taskService.getProcessInstanceComments(processInstanceId);
        return list;
    }

    /**
    * @Title:findProcessDefinitionByTaskId
    * @Description TODO(根据任务id 查询流程定义). 
    * @date  2015年9月9日 
    * @author lzqiangPC  
    * @param taskId
    * @return ProcessDefinition
     */
    public ProcessDefinition findProcessDefinitionByTaskId(String taskId) {
        Task task = findTaskByTaskId(taskId);
        //流程定义id
        String processDefinitionId = task.getProcessDefinitionId();
        //流程定义对象
        ProcessDefinition pd = findProcessDefinitionByPdId(processDefinitionId);
        return pd;  
    }
    
    
    /**
    * @Title:findCompletedProcessInstances
    * @Description TODO(获取历史流程实例). 
    * @date  2015年9月9日 
    * @author lzqiangPC  
    * @param userId
    * @param page
    * @return List<HistoricProcessInstance>
     */
    public List<HistoricProcessInstance> findCompletedProcessInstances(String userId, Page page) {
        List<HistoricProcessInstance> historicProcessInstances = historyService
              .createHistoricProcessInstanceQuery()
              .orderByProcessInstanceEndTime()
              .desc()
              .list();
        return historicProcessInstances;
    }
    /**
    * @Title:findTaskByTaskId
    * @Description TODO(根据任务id获取Task对象). 
    * @date  2015年9月17日 
    * @author lzqiangPC  
    * @param taskId
    * @return
    * @throws RuntimeException
     */
    public Task findTaskByTaskId(String taskId) throws RuntimeException{
        try{
            return taskService.createTaskQuery()
                              .taskId(taskId)
                              .singleResult();
        }catch(Exception e){
            throw new RuntimeException(e);
        }
    }
    /**
    * @Title:isProcessEnd
    * @Description TODO(根据processInstanceId判断流程是否结束 true结束 false：没有结束). 
    * @date  2015年9月9日 
    * @author lzqiangPC  
    * @param processInstanceId
    * @return true结束  false还没结束
     */
    public boolean isProcessEndByProcessInstanceId(String processInstanceId){
        ProcessInstance pi = findProcessInstanceByPIid(processInstanceId);
        if(null == pi){
           return true;
        }else{
            return false;
        }
    }
    
    /**
     * @Title:isProcessEnd
     * @Description TODO(根据processDefinitionId判断流程是否结束 true结束 false：没有结束). 
     * @date  2015年9月9日 
     * @author lzqiangPC  
     * @param processInstanceId
     * @return true结束  false还没结束
      */
    public boolean isProcessEndByProcessDefintionId(String processDefinitionId){
        ProcessInstance pi = runtimeService.createProcessInstanceQuery()//创建流程实例查询
                .processDefinitionId(processDefinitionId)//使用流程定义id查询
                .singleResult();
        if(null == pi){
           return true;
        }else{
            return false;
        }
    }
    
    /**
    * @Title:updateSuspendState
    * @Description TODO( 挂起、激活流程实例). 
    * @date  2015年9月9日 
    * @author lzqiangPC  
    * @param suspend true:修改成激活 false：修改成挂起
    * @param processDefinitionId
     */
    public void updateSuspendState(boolean suspendState,String processDefinitionId) throws RuntimeException {
        try{
            if (suspendState) {
                repositoryService.activateProcessDefinitionById(processDefinitionId, true, null);//激活
            } else{
                repositoryService.suspendProcessDefinitionById(processDefinitionId, true, null);//挂起
            }
        }catch(Exception e){
            throw new RuntimeException(e);
        }
    }
    
    
    /**
     * 查看当前活动，获取当前活动对应的坐标x,y,width,height,将
       4个值放入到map<String,Object>中
       map集合的key：表示坐标x，y,width,height
       map集合的value：表示坐标对应的值
     */
    public Map<String, Object> findCoordingByTaskId(String taskId) {
        //使用任务id，查询任务对象
        Task task = taskService.createTaskQuery()
                                .taskId(taskId)
                                .singleResult();
        //获取流程定义的id
        String processDefinitionId = task.getProcessDefinitionId();
        //获取流程定义的实体对象(对应bpmn文件)
        ProcessDefinitionEntity processDefinitionEntity = (ProcessDefinitionEntity) repositoryService.getProcessDefinition(processDefinitionId);
        
        //使用流程实例id 查询正在执行的执行对象表，获取当前活动对应的流程实例对象
        //流程实例id
        String processInstanceId = task.getProcessInstanceId();
        //使用流程实例id，查询正在执行的执行对象表，获取当前活动对应的流程实例对象
        ProcessInstance pi = findProcessInstanceByPIid(processInstanceId);
        //获取当前活动的id
        String activityId = pi.getActivityId();
        //获取当前活动对象
        ActivityImpl activityImpl = processDefinitionEntity.findActivity(activityId);
        //存放坐标集合
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("x",activityImpl.getX());
        map.put("y",activityImpl.getY());
        map.put("width",activityImpl.getWidth());
        map.put("height",activityImpl.getHeight());
        return map;
    }
    
    public Model newModel(){
        return repositoryService.newModel();
    }
    
    public void saveModel(Model model){
        repositoryService.saveModel(model);
    }
    
    public void addModelEditorSource(String modelId,byte[] text){
        repositoryService.addModelEditorSource(modelId, text);
    }
    
    /**
    * @Title:findModelListPage
    * @Description TODO(获取流程图模型列表). 
    * @date  2015年9月11日 
    * @author lzqiangPC  
    * @param startPage
    * @param endPage
    * @return
     */
    public List<Model>  findModelListPage(int startPage,int endPage){
        return repositoryService.createModelQuery().orderByLastUpdateTime().desc().listPage(startPage,endPage);
    }
    /**
    * @Title:findModelCount
    * @Description TODO(获取模型列表个数). 
    * @date  2015年9月11日 
    * @author lzqiangPC  
    * @return
     */
    public long findModelCount() {
        return repositoryService.createModelQuery().count();
    }
    /**
    * @Title:deleteModel
    * @Description TODO(删除Model). 
    * @date  2015年9月14日 
    * @author lzqiangPC  
    * @param modelId
    * @throws RuntimeException
     */
    public void deleteModel(String modelId) throws RuntimeException {
        try{
            repositoryService.deleteModel(modelId);
        }catch(Exception e){
            throw new RuntimeException(e);
        }
    }
    /**
    * @Title:findModel
    * @Description TODO(获取Model). 
    * @date  2015年9月14日 
    * @author lzqiangPC  
    * @param modelId
    * @return
    * @throws RuntimeException
     */
    
    public Model findModel(String modelId) throws RuntimeException {
        try{
           return repositoryService.getModel(modelId);
        }catch(Exception e){
            throw new RuntimeException(e);
        }
    }
    /**
    * @Title:findModelEditorSource
    * @Description TODO(获取ModelEditorSource). 
    * @date  2015年9月14日 
    * @author lzqiangPC  
    * @param modelId
    * @return
    * @throws RuntimeException
     */
    public byte[] findModelEditorSource(String modelId) throws RuntimeException {
        try{
           return repositoryService.getModelEditorSource(modelId);
        }catch(Exception e){
            throw new RuntimeException(e);
        }
    }
    
    /**
    * @Title:addComment
    * @Description TODO(添加批注信息). 
    * @date  2015年9月17日 
    * @author lzqiangPC  
    * @param taskId
    * @param processInstanceId
    * @param message
    * @param userId
     */
    public void addComment(String taskId,String message,String userId){
        //添加批注
        /**
         * 注意：添加批注的时候，由于Activiti底层代码是使用：
         *      String userId = Authentication.getAuthenticatedUserId();
                CommentEntity comment = new CommentEntity();
                comment.setUserId(userId);
                                                  所有需要从Session中获取当前登录人，作为该任务的办理人（审核人），对应act_hi_comment表中的User_ID的字段，不过不添加审核人，该字段为null
                                                 所以要求，添加配置执行使用Authentication.setAuthenticatedUserId();添加当前任务的审核人
         * */
        
        Task task = taskService.createTaskQuery().taskId(taskId).singleResult();
        Authentication.setAuthenticatedUserId(userId);
        taskService.addComment(taskId, task.getProcessInstanceId(), message);
    }
    
    /**
    * @Title:claim
    * @Description TODO(任务签收). 
    * @date  2015年9月18日 
    * @author lzqiangPC  
    * @param taskId
    * @param userid
     */
    public void claim(String taskId, String userid) throws Exception {
        try {
            taskService.claim(taskId,userid);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
    
    /**
    * @Title:runingProcessInstancePage
    * @Description TODO(分页获取正在运行的流程实例). 
    * @date  2015年9月22日 
    * @author lzqiangPC  
    * @param processDefinitionKey 可以为null，如果为nul 则不过滤pdkey
    * @param startPage
    * @param endPage
    * @return
     */
    public List<ProcessInstance> runingProcessInstancePage(String processDefinitionKey,int startPage,int endPage){
        ProcessInstanceQuery processInstanceQuery = runtimeService.createProcessInstanceQuery();
        if(StringUtils.isNotEmpty(processDefinitionKey)){
            processInstanceQuery = processInstanceQuery.processDefinitionKey(processDefinitionKey);
        }
        List<ProcessInstance> list =  processInstanceQuery
                                     .active()
                                     .orderByProcessInstanceId()
                                     .desc()
                                     .listPage(startPage,endPage);
        return list;
    }
    
    /**
    * @Title:runingProcessInstanceCount
    * @Description TODO(获取正在运行的流程实例总数). 
    * @date  2015年9月22日 
    * @author lzqiangPC  
    * @param processDefinitionKey可以为null，则不过滤pdkey
    * @return
     */
    public long runingProcessInstanceCount(String processDefinitionKey){
        ProcessInstanceQuery processInstanceQuery = runtimeService.createProcessInstanceQuery();
        if(StringUtils.isNotEmpty(processDefinitionKey)){
            processInstanceQuery = processInstanceQuery.processDefinitionKey(processDefinitionKey);
        }
        long count = processInstanceQuery.active()
                                         .orderByProcessInstanceId()
                                         .count();
        return count;
    }
    
    /**
    * @Title:findFinishedProcessInstaces
    * @Description TODO(分页获取已结束的流程实例). 
    * @date  2015年9月22日 
    * @author lzqiangPC  
    * @param processDefinitionKey
    * @param startPage
    * @param endPage
    * @return
     */
    public List<HistoricProcessInstance> findFinishedProcessInstaces(String processDefinitionKey,int startPage,int endPage) {
        HistoricProcessInstanceQuery historicProcessInstanceQuery = historyService.createHistoricProcessInstanceQuery();
        if(StringUtils.isNotEmpty(processDefinitionKey)){
            historicProcessInstanceQuery.processDefinitionKey(processDefinitionKey);
        }
        List<HistoricProcessInstance> list  = historicProcessInstanceQuery
                                              .finished()
                                              .orderByProcessInstanceEndTime()
                                              .desc()
                                              .listPage(startPage, endPage);
       return list;
    }
    
    /**
    * @Title:historicTaskInstanceList
    * @Description TODO(历史任务实例). 
    * @date  2015年9月23日 
    * @author lzqiangPC  
    * @param deploymentId
    * @param startPage 开始页
    * @param endPage 结束页
    * @return
     */
    public List<HistoricTaskInstance> findHistoricTaskInstanceList(String deploymentId,int startPage,int endPage){
        List<HistoricTaskInstance> historicTasks = historyService
                .createHistoricTaskInstanceQuery()
                .deploymentId(deploymentId).listPage(startPage, endPage);
        return historicTasks;
    }
    
    /**
     * @Title:historicTaskInstanceList
     * @Description TODO(历史任务实例总数). 
     * @date  2015年9月23日 
     * @author lzqiangPC  
     * @param processInstanceId
     * @return
      */
     public long findHistoricTaskInstanceCout(String taskId){
         long count = historyService
                 .createHistoricTaskInstanceQuery()
                 .taskId(taskId).count();
         return count;
     }
     /**
     * @Title:endProcessInstance
     * @Description TODO(手动使流程终止). 
     * @date  2015年9月24日 
     * @author lzqiangPC  
     * @param processInstanceId 流程实例id
     * @throws RuntimeException
      */
     public void endProcessInstance(String processInstanceId)throws RuntimeException {
        try{
            runtimeService.deleteProcessInstance(processInstanceId, "end");
        }catch(Exception e){
            throw new RuntimeException(e);
        }
     }
     
     /**
     * @Title:findInvolvedProcessInstancesPage
     * @Description TODO(用户参与的流程,分页获取list). 
     * @date  2015年9月24日 
     * @author lzqiangPC  
     * @param userId
     * @param startPage
     * @param endPage
     * @return
      */
     public List<HistoricProcessInstance> findInvolvedProcessInstancesPage(String userId,int startPage,int endPage) {
         List<HistoricProcessInstance> historicProcessInstances = historyService
                 .createHistoricProcessInstanceQuery()
                 .involvedUser(userId)
                 .listPage(startPage,endPage);
         return historicProcessInstances;
     }
     /**
     * @Title:findInvolvedProcessInstancesCount
     * @Description TODO(用户参与的流程个数). 
     * @date  2015年9月24日 
     * @author lzqiangPC  
     * @param userId
     * @return
      */
     public long findInvolvedProcessInstancesCount(String userId) {
         long count = historyService.createHistoricProcessInstanceQuery()
                 .involvedUser(userId).count();
         return count;
     }
     
     /**
      * @Title:findProcessInstanceByPIid
      * @Description TODO(根据流程实例Id获取流程实例对象). 
      * @date  2015年9月24日 
      * @author lzqiangPC  
      * @param processInstanceId
      * @return
       */
      private ProcessInstance findProcessInstanceByPIid(String processInstanceId) {
          return runtimeService.createProcessInstanceQuery()
                     .processInstanceId(processInstanceId)
                     .singleResult();
      }
      
      /**
       * @Title:next
       * @Description TODO(获取当前任务的下一任务节点). 
       * @date  2015年9月24日 
       * @author lzqiangPC  
       * @param taskId
       * @return
        */
       public List<PvmActivity> next(String taskId){
           ActivityImpl activity = findActivitiImplByTaskId(taskId);
           List<PvmActivity> list = getNextActivities(activity);
           return list;
       }
       
       public List<PvmActivity> getNextActivities(PvmActivity pvmActivity) {
           List<PvmActivity> pvmActivities = new ArrayList<PvmActivity>();
           for (PvmTransition pvmTransition : pvmActivity.getOutgoingTransitions()) {
               PvmActivity targetActivity = pvmTransition.getDestination();
               if (USER_TASK.equals(targetActivity.getProperty("type"))) {
                   pvmActivities.add(targetActivity);
               } else {
                   pvmActivities.addAll(this.getNextActivities(targetActivity));
               }
           }
           return pvmActivities;
       }
       
       /**
        * @Title:Previous
        * @Description TODO(获取当前任务的上一任务节点). 
        * @date  2015年9月24日 
        * @author lzqiangPC  
        * @param taskId
        * @return
         */
        public List<PvmActivity> Previous(String taskId){
            ActivityImpl activity = findActivitiImplByTaskId(taskId);
            List<PvmActivity> list = getPreviousActivities(activity);
            return list;
        }
       
       public List<PvmActivity> getPreviousActivities(PvmActivity pvmActivity) {
           List<PvmActivity> pvmActivities = new ArrayList<PvmActivity>();
           for (PvmTransition pvmTransition : pvmActivity.getIncomingTransitions()) {
               PvmActivity targetActivity = pvmTransition.getSource();
               if (USER_TASK.equals(targetActivity.getProperty("type"))) {
                   pvmActivities.add(targetActivity);
               } else {
                   pvmActivities.addAll(this.getPreviousActivities(targetActivity));
               }
           }
           return pvmActivities;
       }

}
  
