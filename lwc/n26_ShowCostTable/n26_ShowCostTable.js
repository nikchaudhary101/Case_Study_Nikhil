import { LightningElement,wire,track,api } from 'lwc';
import getFieldSetMember from '@salesforce/apex/N26_ShowCostTableHelper.getFieldSetMember';
import costTableName from '@salesforce/label/c.N26_Cost_Table_ObjName';
import warningMsg from '@salesforce/label/c.N26_CostTable_Warning_msg';

export default class N26_ShowCostTable extends LightningElement {
    @api recordId; //Store Id of the Record
    @track errorMsg;
    @track isError=false;
    @track costTableId;
     @track fieldSet = [];

    label ={
        costTableName,warningMsg
    };

    //Calling getFieldSetMember method on n26_ShowCostTableHelper to fetch Field Value response based on Field Set
    @wire(getFieldSetMember, { obName : costTableName,recordID : '$recordId'})
    fieldSetList({ error, data }) {
        if (data) {
            let costList = JSON.parse(JSON.stringify(data));
            if(costList.isError===false){
                this.costTableId=costList.costTableId;
                this.fieldSet= costList.fieldSetValue.split(',');
            }
            else{
                this.isError=true;
                this.errorMsg=warningMsg;
            }
        } else if (error) {
            this.isError=true;
            this.errorMsg = 'Unknown error';
            if (Array.isArray(error.body)) {
                this.errorMsg = error.body.map(e => e.message).join(', ');
            } else if (typeof error.body.message === 'string') {
                this.errorMsg = error.body.message;
            }
        }
    };
}