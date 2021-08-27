public with sharing class Util {
    public static sObject GetRandomItem(List<SObject> lst){
        
        if(lst == null) throw new NullParameterException();
        if(lst.size() == 0) throw new EmptyListException();
            
        return lst.get(Math.mod(Integer.valueof(Math.random()*1000000000), lst.size()));
    }
    
    Public class EmptyListException extends System.Exception{}
    Public class NullParameterException extends System.Exception{}
    
}
