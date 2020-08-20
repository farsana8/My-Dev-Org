public class lightningLookupController {
  
    @AuraEnabled(cacheable=true)
    public static List<RecordsData> fetchRecords( String objectName, String filterField, String searchString,string parent,string parentField ) {
        List<RecordsData> recordsDataList = new List<RecordsData>();
          String query;
        list<sobject> sobjectList=new list<sobject>();
        try {
            if(searchString=='')
            {
                //query = 'SELECT Id, ' + filterField+ ' FROM '+objectName+ ' LIMIT 10';
             sobjectList= getHierarchy2(parent,parentField,filterField);
            }
            else
            {
	         query = 'SELECT Id, ' + filterField+
	                        ' FROM '+objectName+
	                        ' WHERE '+filterField+' LIKE ' + '\'' + String.escapeSingleQuotes(searchString.trim()) + '%\'' + ' LIMIT 50000';
                
             sobjectList=Database.query(query);
            }
	        for(SObject s : sobjectList){
	            RecordsData recordsData = new RecordsData();
	            recordsData.value = String.valueOf(s.get('id'));
	            recordsData.label = String.valueOf(s.get(filterField));
	            recordsDataList.add(recordsData);
	        } 
	    } catch (Exception err) {
	    	if ( String.isNotBlank( err.getMessage() ) && err.getMessage().contains( 'error:' ) ) {
                throw new AuraHandledException(err.getMessage().split('error:')[1].split(':')[0] + '.');
            } else {
                throw new AuraHandledException(err.getMessage());
            }
	    }
        
        return recordsDataList;
    }
      @AuraEnabled
        public static List<account> getHierarchy( String recordId ) {
        
           map<id,account> accountMap=new map<id,account>([select id,name,parentid from account] );
            list<account> accountHierarchyList=new list<account> ();
            account primaryAcc=accountMap.get(recordId);
            string parentId=primaryAcc.parentid;
            while(parentId!=null)
            {
                for(account acc:accountMap.values())
                {
                    if(parentid!=null)
                    {
                        account a=accountMap.get(parentid);
                        accountHierarchyList.add(a);
                        parentid=a.ParentId;
                    }
                }
            }
            System.debug('accountHierarchyList'+accountHierarchyList);
            return accountHierarchyList;
        }
    
     @AuraEnabled
        public static List<SObject> getHierarchy2( String recordId, String parent, String filterField ) {
            String sobjectType = id.valueOf(recordId).getSObjectType().getDescribe().getName();

               string query = 'SELECT Id,' + parent+','+filterField+' FROM '+sobjectType;
         
            list<SObject> sobjectList=Database.query(query);
                
            map<id,SObject> SObjectMap=new map<id,SObject>();
            
            system.debug('sobjectList'+sobjectList);
            list<SObject> HierarchyList=new list<SObject>();
            for(sobject obj:sobjectList)
            {
                SObjectMap.put(obj.id,obj);
               
            }
            
            SObject primaryObj=SObjectMap.get(recordId);
            string parentId=string.valueof(primaryObj.get(parent));
            while(parentId!=null)
            {
                for(SObject obj:SObjectMap.values())
                {
                    if(parentid!=null)
                    {
                        SObject a=SObjectMap.get(parentid);
                        HierarchyList.add(a);
                        system.debug('list'+a);
                        parentid=string.valueof(a.get(parent));
                    }
                }
            }
            System.debug('accountHierarchyList'+HierarchyList);
            return HierarchyList;
           
        }
     @AuraEnabled
        public static List<SObject> getHierarchy3( String recordId, String parent, String filterField ) {
           String sobjectType = id.valueOf(recordId).getSObjectType().getDescribe().getName();
           string query = 'SELECT Id,' + parent+','+filterField+' FROM '+sobjectType;
           list<SObject> sobjectList=Database.query(query);
           list<SObject> HierarchyList=new list<SObject>();
           String parentId=recordId;
            if(parentid!=null)
            {
                for(SObject sobj:sobjectList)
                {
                    if(sobj.get(parent)==parentid)
                        HierarchyList.add(sobj);
                }
            }
            System.debug('accountHierarchyList'+HierarchyList);
            return HierarchyList;
           
           
        }
    public class RecordsData{
        @AuraEnabled public String label {get;set;}
        @AuraEnabled public String value {get;set;}
    }
}