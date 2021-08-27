@isTest
public class UtilTest 
{
    
    @isTest static void GetRandomItenTest(){
        //preparação do cenário
        List<criatura__c> creatureList = new List<criatura__c>();
        for(integer i = 0; i<= 200; i++)
        {
            creatureList.add(TestHelper.CriaCriatura(i));
        }
        
        //teste
        test.startTest();
        Criatura__c cri = (Criatura__c) Util.GetRandomItem(creatureList);
        test.stopTest();
        //
        //validação do resultado
        Boolean flag = false;
        for (Criatura__c criFor : creatureList)
        {
            if(criFor.name == cri.name) flag = true;
        }
        System.assert(flag, 'O item randomico não existe na lista');
    }
    
    @isTest static void GetRandomItenTest2(){//Valida lista vazia
        //preparação do cenário
        List<criatura__c> creatureList = new List<criatura__c>();
        
        try
        {
        //teste
        test.startTest();
        Criatura__c cri = (Criatura__c) Util.GetRandomItem(creatureList);
        test.stopTest();
        }
        catch (System.Exception e)
        {
            system.assert(e instanceof Util.EmptyListException, 'Unexpected Exception');
        }
        
    }
    
    @isTest static void GetRandomItenTest3(){//Valida null
        try
        {
        //teste
        test.startTest();
        Criatura__c cri = (Criatura__c) Util.GetRandomItem(null);
        test.stopTest();
        }
        catch (System.Exception e)
        {
            system.assert(e instanceof Util.NullParameterException, 'Unexpected Exception');
        }
        
    }
    
    @isTest static void GetRandomItenTest4(){
        List<criatura__c> creatureList = new List<criatura__c>();
        creatureList.add(TestHelper.CriaCriatura(1));
        //teste
        test.startTest();
        Criatura__c cri = (Criatura__c) Util.GetRandomItem(creatureList);
        test.stopTest();
        
        //validação do resultado
        system.assertEquals(cri, creatureList[0]);
    }
}