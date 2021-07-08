({
    doInit: function (cmp, evt, help) {
        let options = [ {'label': 'Label ASC', 'value': 'LABEL_ASC'},
                        {'label': 'Lable DESC', 'value': 'LABEL_DESC'},
                        {'label': 'Percentage DESC', 'value': 'Percentage_DESC'}, 
                        {'label': 'Percentage ASC', 'value': 'Percentage_ASC'},
                        {'label': 'Percentage 90+', 'value': 'Percentage_90'},
                        {'label': 'Percentage 70-90', 'value': 'Percentage_70'},
                        {'label': 'Percentage 50-70', 'value': 'Percentage_50'},
                        {'label': 'Percentage 0-50', 'value': 'Percentage_0'},
                        ];
        cmp.set('v.filterOptions',options);
        help.getSystemLimits(cmp, evt);
    },
    handleFilter : function (cmp, evt, help) {
        let val = evt.getParam("value");
        cmp.set('v.title',val);
        let chooseMethod = help.filterConditions;
        if(chooseMethod[val].callingMethod == 'sort'){
            help.sortRecords(cmp, chooseMethod[val].fieldApi , chooseMethod[val].order );

        }else if(chooseMethod[val].callingMethod == 'filter'){
            help.filterRecords(cmp, chooseMethod[val].min ,chooseMethod[val].max );

        }

    },
	// handleChange: function (cmp, event) {
	// 	//cmp.set('v.isAll', false);
    //     var selectedOptionValue = event.getParam("value");
    //     console.log('---------->',JSON.stringify(selectedOptionValue));
	// },
})