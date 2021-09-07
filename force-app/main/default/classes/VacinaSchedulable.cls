public class VacinaSchedulable implements Schedulable{
    private String humanId = Schema.SObjectType.Criatura__c.getRecordTypeInfosByName().get('Humano').getRecordTypeId();
    
    public void execute(SchedulableContext SC) {
        vacinar();
    }

    public void vacinar(){
        List<Criatura__c> zombieList = [SELECT id, RecordTypeId, Tipo_do_Zumbi__c, Data_de_Zumbificacao__c FROM Criatura__c where RecordTypeId = '0125e000000qYv8AAE' LIMIT 100];

        Decimal potenciaAntigeno = 0;
        Decimal ac = 0;

        if(zombieList.size() > 0){
            for(Criatura__c zumbi : zombieList){
                potenciaAntigeno = Math.mod(Integer.valueof(Math.random()*100000),100)+1;
                if(potenciaAntigeno > 85){
                    ac++;
                    zumbi.RecordTypeId = humanId;
                    zumbi.Tipo_do_Zumbi__c = null;
                    zumbi.Data_de_Zumbificacao__c = null;
                }
            }

            System.debug('Quantidade de sucesso: '+ ac);
            System.debug('Tamanho da Lista: '+zombieList.size());
        }else{
            System.debug('Lista de zumbis vazia!');
        }
        update zombieList;
    }
}