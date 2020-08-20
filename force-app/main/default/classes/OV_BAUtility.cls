public class OV_BAUtility {
     public static List<String> accountList{get;set;}
     public static Map<id,Account> accMap{get;set;}
   
     public static String getAcctIds(String id){  
        system.debug('-----------******-----------------'+id);
        return quoteId(getAccountIds(id));        
    }
     public static list<id> getAccountIds(String Id){
        if(accMap == null){
            accMap= new Map<id,Account>([SELECT id,ParentId,Name from Account where ParentId=:Id]);
        }
        system.debug('Size of map :'+accMap.size());
        accountList = new List<String>();
        accountList.add(Id);
        for(Account acc : accMap.values()){
            if(acc.ParentId == Id){
                //accMap.remove(acc.id);
                accountList.add(acc.id);
                getChildAccount(acc.id,accountList);
            }
        }
        system.debug('FinalList'+accountList);
        return accountList;
    }
    private static void getChildAccount(Id parentId,List<ID> accountList){
        for(Account acc : accMap.values()){
            if(parentId == acc.ParentId){
                //    accMap.remove(acc.id);
                accountList.add(acc.id);
                getChildAccount(acc.id,accountList);
            }
        }
    }
    private static void getParentAccount(Id parentId,List<ID> accountList){
        for(Account acc : accMap.values()){
            if(parentId == acc.id){
                //      accMap.remove(acc.id);
                accountList.add(acc.id);
                if(acc.ParentId != null)
                    getParentAccount(acc.ParentId,accountList);
            }
        }
    }
    private static String quoteId(List<String> ids){
        String idStr = '' ;
        for(String str : ids)
            idStr += '\'' + str + '\',';
        
        idStr = idStr.lastIndexOf(',') > 0 ? '(' + idStr.substring(0,idStr.lastIndexOf(',')) + ')' : idStr ;
        System.debug('quoteId() :  idStr =*************===== ' + idStr);   
        return idStr;
    }
}