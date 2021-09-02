import { LightningElement, api, wire } from 'lwc';
import {getRecord} from 'lightning/uiRecordApi'; //Traz o recordId



const CAMPOS = [
    'Bunker__c.Name',
    'Bunker__c.Ativo__c',
    'Bunker__c.Capacidade__c',
    'Bunker__c.DefesaBunker__c'
]

export default class LwcOne extends LightningElement {
    @api recordId;
    
    @wire( getRecord, {recordId : '$recordId', fields : CAMPOS}) //Faz uma requisição para o backend
    bunker; //Retorno da requisição acima é salvo aqui

    get name(){
        return this.bunker.data.fields.Name.value;
    }

    get ativo(){
        return this.bunker.data.fields.Ativo__c.value;
    }

    oi = 'Hello World!';

    changeHandler(event){
        alert('Nome alterado para: ' + event.target.value);
    }

}

    