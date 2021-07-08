({
    computeProgress : function(component, event)  {
        let limitRec = component.get('v.limit');
        let totalVal = limitRec.maxLimit;
        let actualVal = limitRec.usedLimit;
        
        if(totalVal && actualVal && !isNaN(parseInt(totalVal)) && isFinite(totalVal) && !isNaN(parseInt(actualVal)) && isFinite(actualVal)){
            //parameter is number 
            var percVal = parseInt(actualVal) / parseInt(totalVal) ;
            var progressVal = parseInt(  percVal * 360  ) ;
			if(progressVal >360)
                progressVal=360;
            component.set("v.cirDeg" , progressVal );
        }
    },
    setColor : function(component, event){
        let limitRec = component.get('v.limit');
        if(limitRec.percentage >= 90){ //red
            component.set('v.theme', 'red');
        }else if(limitRec.percentage >= 70 && limitRec.percentage < 90 ){ // Orange
            component.set('v.theme', 'orange');
        }else if(limitRec.percentage >= 50 && limitRec.percentage < 70 ){ // Yellow
            component.set('v.theme', 'yellow');
        }else { // green
            component.set('v.theme', 'green');
        }
    }
})