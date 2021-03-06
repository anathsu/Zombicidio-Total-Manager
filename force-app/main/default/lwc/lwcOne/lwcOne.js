import { LightningElement, api, wire } from 'lwc';

//Usado para recuperar dados do objeto passando 2 parametros: recordId e um array dos campos
//SELECT {FIELDS} FROM Bunker__c WHERE id= :RECORDID
import {getRecord} from 'lightning/uiRecordApi'; 

const CAMPOS = [
    'Bunker__c.Name',
    'Bunker__c.Ativo__c',
    'Bunker__c.Capacidade__c',
    'Bunker__c.DefesaBunker__c'
]

export default class LwcOne extends LightningElement {

    //Ao declarar recordID com a decoration @api, conseguimos recuperar o Id do registro no qual o campo esta sendo usado
    @api recordId; //traz o id do registro onde a pagina está
    
    //chama o backend fazendo uma requisição
    @wire( getRecord, {recordId : '$recordId', fields : CAMPOS}) //Faz uma requisição para o backend
    bunker; //Retorno da requisição acima é salvo aqui

    get name(){
        return this.bunker.data.fields.Name.value;
    }

    get ativo(){
        return this.bunker.data.fields.Ativo__c.value;
    }

    get capacidade(){
        return this.bunker.data.fields.Capacidade__c.value;
    }

    get defesaBunker(){
        return this.bunker.data.fields.DefesaBunker__c.value;
    }

    oi = 'Hello World!';

    changeHandler(event){
        alert('Nome alterado para: ' + event.target.value);
    }

}