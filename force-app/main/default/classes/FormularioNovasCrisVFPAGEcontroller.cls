public without sharing class FormularioNovasCrisVFPAGEcontroller {

    public Criatura__c criatura {get; set;}

    public FormularioNovasCrisVFPAGEcontroller() {

        Id criaturaId = ApexPages.currentPage().getParameters().get('id');
        this.criatura = [SELECT ID, NAME FROM Criatura__c WHERE ID=:criaturaId];
    }

    public static void save(){

    }
}
