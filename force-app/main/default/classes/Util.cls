public with sharing class Util {
    public Util() {}

    public static sObject GetRandomItem(List<sObject> lst){
        return lst.get(Math.mod(Integer.valueof(Math.random()*1000000000),lst.size()));
    }
}
