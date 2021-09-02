public class Zumbificacao { //Quando um Humano se transforma em zumbi e tem recursos.
    @InvocableMethod (label='Transforma Zumbi')
    public static void zumbificar(List<id> ids){
        List<Criatura__c> criList = [SELECT id, bunker__r.name, bunker__c, (SELECT id FROM RecursosCriatura__r) FROM Criatura__c WHERE id in :ids];
        List<RecursoCriatura__c> rcDeleteList = new List<RecursoCriatura__c>();
        
        for(Criatura__c cr : criList){
            String tipoZumbi = '';
            integer rand = Math.mod(Integer.valueOf(Math.random()*100000), 100);
            if(rand < 50){
                tipoZumbi = 'Lento';
            }else if(rand < 80){
                tipoZumbi = 'Rápido';
            }else{
                tipoZumbi = 'Gordo';
            }
            cr.Tipo_do_Zumbi__c = tipoZumbi;
            if(cr.RecursosCriatura__r != null){
                rcDeleteList.addAll(cr.RecursosCriatura__r);
            }
        }
       update criList;
       delete rcDeleteList;
    }

}