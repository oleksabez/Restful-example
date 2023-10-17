@RestResource(urlMapping='/tasks')
global class taskRESTfulAPI {
    @httpGet
    global static List<Task> getTasks() {
        Map<String, String> params = RestContext.request.params;
        Integer limitation;
        if(params != null) {
            try {
            	limitation = Integer.valueOf(params.get('limitation'));
            } catch(Exception ex) {
                System.debug('Unproper value of limitation parameter');
            }
            if(limitation != null) {
                return [SELECT Id, Subject, Description FROM Task LIMIT :limitation];
            }
        }
        return [SELECT Id, Subject, Status, Description FROM Task]; 
    }
    @httpPost
    global static String createTask(String Subject, String Status, String Description) {
        try {
            Task tsk = new Task(Subject=Subject,Status=Status,Description=Description);
            insert tsk;
            return 'Record ' + tsk.Id + ' was successfuly created';
        } catch(Exception ex) {
            return ex.getMessage();
        }
    }
    @httpPatch
    global static String renewTask(String taskId, String Status) {
        try {
            Task toChange = [SELECT Id, Status FROM Task WHERE Id =: taskId];
            toChange.Status = Status;
            update toChange;
            return 'Status of task ' + taskId + ' was successfuly changed';
        } catch(Exception ex) {
            return 'Error has occured during record updating: ' + ex.getMessage();
        }
    }
    @httpDelete
    global static String removeTask() {
        Id taskId = RestContext.request.params.get('taskId');
        try {
            delete [SELECT Id FROM Task WHERE Id =: taskId];
            return 'Record ' + taskId + ' was successfuly deleted';
        } catch(Exception ex) {
            return 'Error has occured during deleting: ' + ex.getMessage();
        }
    }
}