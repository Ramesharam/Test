({
    /*
     *  Map the Field to the desired component config, including specific attribute values
     *  Source: https://www.salesforce.com/us/developer/docs/apexcode/index_Left.htm#CSHID=apex_class_Schema_FieldSetMember.htm|StartTopic=Content%2Fapex_class_Schema_FieldSetMember.htm|SkinName=webhelp
     *
     *  Change the componentDef and attributes as needed for other components
     */
    configMap: {
        
       
        'anytype': { componentDef: 'ui:inputText', attributes: {} },
        'base64': { componentDef: 'ui:inputText', attributes: {} },
        'boolean': {componentDef: 'ui:inputCheckbox', attributes: {} },
        'combobox': { componentDef: 'ui:inputText', attributes: {} },
        'currency': { componentDef: 'ui:inputText', attributes: {} },
        'datacategorygroupreference': { componentDef: 'ui:inputText', attributes: {} },
        'date': {
            componentDef: 'ui:inputDate',
            attributes: {
                displayDatePicker: true,
                format: 'MM/dd/yyyy'
            }
        },
        'datetime': { componentDef: 'ui:inputDateTime',
                attributes: {
                displayDatePicker: true,
                format: 'MM/dd/yyyy'
                    }
            },
        'double': { componentDef: 'ui:inputNumber', attributes: {} },
        'email': { componentDef: 'ui:inputEmail', attributes: {} },
        'encryptedstring': { componentDef: 'ui:inputText', attributes: {} },
        'id': { componentDef: 'ui:inputText', attributes: {} },
        'integer': { componentDef: 'ui:inputNumber', attributes: {} },
        'multipicklist': { componentDef: 'ui:inputText', attributes: {} },
        'percent': { componentDef: 'ui:inputNumber', attributes: {} },
        'phone': { componentDef: 'ui:inputPhone', attributes: {} },
        'picklist': { componentDef: 'ui:inputText', attributes: {} },
        'reference': { componentDef: 'ui:inputText', attributes: {} },
        'string': { componentDef: 'ui:inputText', attributes: {} },
        'textarea': { componentDef: 'ui:inputText', attributes: {} },
        'time': { componentDef: 'ui:inputDateTime', attributes: {} },
        'url': { componentDef: 'ui:inputText', attributes: {} }
 
    },
    configMapPrint: {
        
        'anytype': { componentDef: 'ui:outputText', attributes: {} },
        'date': {
            componentDef: 'ui:outputText',
            attributes: { }
        },
        'datetime': {  componentDef: 'ui:outputText',
            attributes: { 
                format: 'MM/dd/yyyy'
                    }
            },
        'string': { componentDef: 'ui:outputText', attributes: {} },
        'id': { componentDef: 'ui:outputText', attributes: {} },
        'integer': { componentDef: 'ui:outputText', attributes: {} },
        'multipicklist': { componentDef: 'ui:outputText', attributes: {} },
        'percent': { componentDef: 'ui:outputText', attributes: {} },
        'phone': { componentDef: 'ui:outputText', attributes: {} },
        'picklist': { componentDef: 'ui:outputText', attributes: {} },
        'reference': { componentDef: 'ui:outputText', attributes: {} },
        'string': { componentDef: 'ui:outputText', attributes: {} },
        'textarea': { componentDef: 'ui:outputText', attributes: {} },
        'time': { componentDef: 'ui:outputText', attributes: {} },
        
    },
    
    createForm: function(cmp) {
        console.log('FieldSetFormHelper.createForm');
        var fields = cmp.get('v.fields');
        var record = cmp.get('v.record');
        var inputDesc = [];
        var edit = cmp.get('v.isEdit');
        for (var i = 0; i < fields.length; i++) {
            var field = fields[i];
            var type = field.Type.toLowerCase();
            
            
            
            
            
            
            
            
            
            
            
            
            if(edit=="True"){
                var configTemplate = this.configMap[type];
            }
            else{
                console.log("Editing.................");
                var configTemplate = this.configMapPrint[type];
            }
            if (!configTemplate) {
                console.log(`type ${ type } not supported`);
                continue;
            }
            
            // Copy the config so that subsequent types don't overwrite a shared config for each type.
            var config = JSON.parse(JSON.stringify(configTemplate));
            config.attributes.label = field.Label;
            config.attributes.required = field.Required;
            config.attributes.value = cmp.getReference(' v.record.' + field.APIName);
            config.attributes.fieldPath = field.APIName;
            
            if (!config.attributes['class']) {
                config.attributes['class'] = 'slds-m-vertical_x-small';
            }
            
            inputDesc.push([
                config.componentDef,
                config.attributes
            ]);
        }
        $A.createComponents(inputDesc, function(cmps) {
            cmp.set('v.body', cmps);
        });
    }
})