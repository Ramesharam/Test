({
    createGraph : function(cmp, temp, selectedObjectName, viewtype) {
        
        var dataMap = {"chartLabels": Object.keys(temp),
                       "chartData": Object.values(temp)
                      };
        
        var el = cmp.find('barChart').getElement();
        var ctx = el.getContext('2d');
        
        var myChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: dataMap.chartLabels,
                datasets: [
                    {
                        label: selectedObjectName,
                        backgroundColor: "#3399ff",
                        data: dataMap.chartData
                    }
                ]
            },
            options: {            
                scales: {
                    yAxes: [{
                        ticks: {
                            beginAtZero: true,
                            max: 20,
                            autoSkip: false,
                            stacked: true
                        }
                    }]  , 
                    xAxes: [{
                        gridLines: {
                            offsetGridLines: true
                        },
                        ticks: {
                            beginAtZero: true,
                            // label formate for y axes
                            // callback: function(value, index, values) {
                            // return "U$ " + (value).toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,');
                            // }
                            max: 20,
                            autoSkip: false,
                            stacked: true
                        }
                    }]                
                }
            },
        });
        
        // Fix: Old data on hoverover on selection of more than one object
        if(window.bar != undefined) {
            window.bar.destroy(); 
        }
        
        
        window.bar = myChart;
        // myChart.destroy();
        
        
    },
    
    matchSelectedFilter : function(cmp, event, helper) {
        
        var objectName = cmp.get("v.sObjectName");
        var filterLists;
        
        // True When Select Object is All/null
        if(cmp.get('v.isOnloadFilterApplied')){
            filterLists = cmp.get('v.onloadObjectFilter');
        }
        // False When Any Object is Selected
        else if(cmp.get("v.isObjChange")){
            filterLists = cmp.get('v.appliedFilterList');
        }
        // True when Select Object is All/null on page load
            else{
                filterLists = cmp.get("v.onloadObjectFilter")
            }
        
        var dataMap = cmp.get('v.dataMap');
        var viewtype = cmp.get('v.viewType');
        
        var filterDataMap = [];
        var objData = {};
        
        filterLists.forEach(function(ele) {
            if(dataMap.hasOwnProperty(ele)){
                objData[ele] = dataMap[ele];
            }
        });
        filterDataMap.push(objData);
        
        this.createGraph(cmp, filterDataMap[0], objectName, viewtype);
    },
    
})