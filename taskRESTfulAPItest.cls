@isTest
public class taskRESTfulAPItest {
    @testSetup
    private static void dataFactory() {
        insert new Task(Subject='Call',Status='In progress',Description='lux');
    }
    private static testMethod void testGet() {
        RestRequest request = new RestRequest();
        request.addParameter('limitation', '1');
        RestContext.request = request;
        taskRESTfulAPI.getTasks();
        request = new RestRequest();
        RestContext.request = request;
        taskRESTfulAPI.getTasks();
    }
    private static testMethod void testPost() {
        taskRESTfulAPI.createTask('Call', 'In progress', 'No');
        taskRESTfulAPI.createTask(null, null, null);
    }
    private static testMethod void testPatch() {
        taskRESTfulAPI.renewTask([SELECT Id FROM Task LIMIT 1].Id, 'In progress');
        taskRESTfulAPI.renewTask(null, null);
    }
    private static testMethod void testDelete() {
        RestRequest request = new RestRequest();
        request.addParameter('taskId', [SELECT ID FROM TASK LIMIT 1].Id);
        RestContext.request = request;
        taskRESTfulAPI.removeTask();
        request = new RestRequest();
        request.addParameter('taskId', 'signal');
        taskRESTfulAPI.removeTask();
    }
}