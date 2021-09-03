import { LightningElement, api } from 'lwc';

const columns = [
    { label: 'Nome do Heroi',        fieldName: 'nome' },
    { label: 'Nivel',                fieldName: 'nivel'},
    { label: 'Total de Habilidades', fieldName: 'total', type: 'number' }
];

export default class LwcCallApexWithCallback extends LightningElement {
    @api heroisDados = [];
    columns = columns;

}