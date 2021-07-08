({
	filterConditions: {
		'LABEL_ASC': { 'fieldApi': 'label', 'order': 'ASC', 'callingMethod': 'sort' },
		'LABEL_DESC': { 'fieldApi': 'label', 'order': 'DESC', 'callingMethod': 'sort' },
		'Percentage_DESC': { 'fieldApi': 'percentage', 'order': 'DESC', 'callingMethod': 'sort' },
		'Percentage_ASC': { 'fieldApi': 'percentage', 'order': 'ASC', 'callingMethod': 'sort' },
		'Percentage_90': { 'min': '90', 'max': '999', 'callingMethod': 'filter' },
		'Percentage_70': { 'min': '70', 'max': '90', 'callingMethod': 'filter' },
		'Percentage_50': { 'min': '50', 'max': '70', 'callingMethod': 'filter' },
		'Percentage_0': { 'min': '0', 'max': '50', 'callingMethod': 'filter' },
	},
	getSystemLimits: function (cmp, evt) {
		let action = cmp.get("c.limitMethod");
		action.setCallback(this, function (response) {
			var state = response.getState();

			if (state === "SUCCESS") {
				let records = response.getReturnValue();
				cmp.set('v.options', records);
				this.sortRecords(cmp, 'percentage', 'DESC');
			}
			else if (state === "INCOMPLETE") {

			}
			else if (state === "ERROR") {
				var errors = response.getError();
				if (errors) {
					if (errors[0] && errors[0].message) {
						console.log("Error message: " + errors[0].message);
					}
				} else {
					console.log("Unknown error");
				}
			}
		});
		$A.enqueueAction(action);
	},
	sortRecords: function (cmp, fieldApi, order) {
		let records = cmp.get('v.options');
		let sortedRecords = records.sort(function (a, b) {
			var A = a[fieldApi], B = b[fieldApi];

			if (A > B)
				return order == 'ASC' ? 1 : -1;
			if (A < B)
				return order == 'ASC' ? -1 : 1;

			return 0 //default return value (no sorting)
		});
		cmp.set('v.records', sortedRecords);
	},
	filterRecords: function (cmp, min, max) {
		let records = cmp.get('v.options');
		if (min == null || min == undefined || max == null || max == undefined) {
			return;
		}
		let filteredRedcords = records.filter(function (limit) {
			return parseInt(min) <= parseInt(limit.percentage) && parseInt(max) > parseInt(limit.percentage);
		});
        
		cmp.set('v.records', filteredRedcords);
	}
})